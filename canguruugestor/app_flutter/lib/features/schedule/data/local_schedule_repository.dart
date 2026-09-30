import 'package:uuid/uuid.dart';
import '../../../core/civil_date.dart';
import '../../../core/failure.dart';
import '../../../core/money.dart';
import '../../../persistence/database.dart' show CanguruuDatabase;
import '../../../persistence/ledger_writer.dart';
import '../../cards/data/local_cards_repository.dart';
import '../../finance/data/local_finance_repository.dart';
import '../../finance/domain/models.dart';
import '../../finance/domain/services/ledger_rules.dart';
import '../domain/models.dart';
import '../domain/repositories/schedule_repository.dart';
import '../domain/services/recurrence_rules.dart';
import 'services/schedule_codec.dart';

final class LocalScheduleRepository implements ScheduleRepository {
  LocalScheduleRepository(this.db, this.clock, {String Function()? newId})
    : newId = newId ?? const Uuid().v4;
  final CanguruuDatabase db;
  final Clock clock;
  final String Function() newId;
  LedgerWriter get _writer => LedgerWriter(db, clock, newId);
  String get _now => clock.utcNow.toUtc().toIso8601String();
  Future<List<Map<String, Object?>>> _rows(String table) async =>
      (await db.customSelect('SELECT * FROM $table').get())
          .map((r) => r.data)
          .toList();
  Future<void> _insert(
    String table,
    Map<String, Object?> values,
  ) => db.customStatement(
    'INSERT INTO $table (${values.keys.join(',')}) VALUES (${List.filled(values.length, '?').join(',')})',
    values.values.toList(),
  );
  List<Object?> _entryPayload(PlannedEntry entry) => [
    entry.kind.code,
    ...ScheduleCodec.entryFields(entry).values,
  ];
  List<Object?> _patternPayload(RecurrencePattern p) => [
    '${p.anchor}',
    p.frequency.name,
    p.interval,
    p.lastDay,
    p.endOn?.toString(),
    p.maxOccurrences,
  ];

  @override
  Stream<ScheduleSnapshot> watch() => db
      .customSelect(
        'SELECT count(*) FROM scheduled_occurrences',
        readsFrom: db.allTables.toSet(),
      )
      .watch()
      .asyncMap((_) => read());
  @override
  Future<ScheduleSnapshot> read() => db.transaction(_read);
  Future<ScheduleSnapshot> _read() async {
    final ruleRows = await _rows('recurrence_rule_versions');
    final currentRules = {
      for (final r in ruleRows)
        if (r['is_current'] == 1) r['series_id']: r['id'],
    };
    final series = [
      for (final r in await _rows('recurrence_series'))
        RecurrenceSeries(
          id: r['id'] as String,
          name: r['name'] as String,
          kind: ScheduleKind.parse(r['kind'] as String),
          currentRuleId: currentRules[r['id']] as String,
          pausedOn: r['paused_on'] == null
              ? null
              : CivilDate.parse(r['paused_on'] as String),
        ),
    ];
    final kinds = {for (final s in series) s.id: s.kind};
    final rules = [
      for (final r in ruleRows) ScheduleCodec.rule(r, kinds[r['series_id']]!),
    ];
    final reversed = (await _rows(
      'financial_events',
    )).map((e) => e['reversal_of']).whereType<String>().toSet();
    final occurrences =
        [
          for (final r in await _rows('scheduled_occurrences'))
            ScheduledOccurrence(
              id: r['id'] as String,
              entry: ScheduleCodec.entry(r),
              date: CivilDate.parse(r['scheduled_on'] as String),
              status: OccurrenceStatus.values.byName(r['status'] as String),
              manualOverride: r['is_manual_override'] == 1,
              seriesId: r['series_id'] as String?,
              ruleId: r['rule_version_id'] as String?,
              ordinal: r['ordinal'] as int?,
              eventId: r['settled_event_id'] as String?,
              reversed: reversed.contains(r['settled_event_id']),
            ),
        ]..sort((a, b) {
          final date = a.date.compareTo(b.date);
          return date != 0 ? date : a.id.compareTo(b.id);
        });
    return ScheduleSnapshot(
      series: series,
      rules: rules,
      occurrences: occurrences,
      asOf: clock.today,
    );
  }

  Future<PlannedEntry> _validateEntry(PlannedEntry e, CivilDate date) async {
    final description = LedgerRules.name(e.description, max: 160);
    if (e.amount.cents <= 0) {
      throw const FinanceFailure(
        'invalid_amount',
        'O valor previsto deve ser maior que zero.',
      );
    }
    final accounts = await _rows('accounts');
    void account(String? id) {
      final row = accounts.where((a) => a['id'] == id).firstOrNull;
      if (row == null ||
          row['archived'] == 1 ||
          date.isBefore(CivilDate.parse(row['opened_on'] as String))) {
        throw const FinanceFailure(
          'invalid_account',
          'Escolha uma conta ativa e uma data a partir de seu saldo inicial.',
        );
      }
    }

    final cardPurchase = e.kind == ScheduleKind.cardPurchase;
    if (cardPurchase) {
      final card = (await _rows(
        'credit_cards',
      )).where((c) => c['id'] == e.cardId).firstOrNull;
      if (card == null ||
          e.accountId != null ||
          e.destinationId != null ||
          date.isBefore(CivilDate.parse(card['opened_on'] as String))) {
        throw const FinanceFailure(
          'invalid_card',
          'Escolha um cartão válido para a data prevista.',
        );
      }
    } else {
      account(e.accountId);
      if (e.cardId != null) {
        throw const FinanceFailure(
          'invalid_reference',
          'Este tipo de previsão usa conta, sem cartão.',
        );
      }
    }
    if (e.kind == ScheduleKind.transfer) {
      account(e.destinationId);
      if (e.destinationId == e.accountId ||
          e.categoryId != null ||
          e.costNature != null ||
          e.essential != null) {
        throw const FinanceFailure(
          'invalid_transfer',
          'A transferência exige contas diferentes e não tem categoria.',
        );
      }
    } else if (e.destinationId != null) {
      throw const FinanceFailure(
        'invalid_reference',
        'Conta de destino adicional somente em transferências.',
      );
    }
    final expense = e.kind == ScheduleKind.expense || cardPurchase;
    CostNature? nature;
    bool? essential;
    if (e.kind != ScheduleKind.transfer) {
      final category = (await _rows(
        'categories',
      )).where((c) => c['id'] == e.categoryId).firstOrNull;
      if (category == null ||
          category['archived'] == 1 ||
          category['kind'] != (expense ? 'expense' : 'income')) {
        throw const FinanceFailure(
          'invalid_category',
          'Escolha uma categoria compatível com a previsão.',
        );
      }
      if (expense) {
        nature =
            e.costNature ??
            CostNature.values.byName(category['cost_nature'] as String);
        essential = e.essential ?? category['essential'] == 1;
      } else if (e.costNature != null || e.essential != null) {
        throw const FinanceFailure(
          'invalid_classification',
          'Receitas não possuem classificação de despesa.',
        );
      }
    }
    return PlannedEntry(
      kind: e.kind,
      description: description,
      amount: e.amount,
      accountId: e.accountId,
      destinationId: e.destinationId,
      cardId: e.cardId,
      categoryId: e.categoryId,
      costNature: nature,
      essential: essential,
    );
  }

  Future<void> _occurrence(
    String id,
    PlannedEntry entry,
    CivilDate date, {
    String? seriesId,
    String? ruleId,
    int? ordinal,
  }) => _insert('scheduled_occurrences', {
    'id': id,
    'profile_id': 'local',
    'series_id': seriesId,
    'rule_version_id': ruleId,
    'ordinal': ordinal,
    'kind': entry.kind.code,
    'scheduled_on': '$date',
    ...ScheduleCodec.entryFields(entry),
    'status': 'pending',
    'is_manual_override': 0,
    'created_at': _now,
    'updated_at': _now,
  });
  Future<String> _rule(
    String seriesId,
    PlannedEntry entry,
    RecurrencePattern p,
    CivilDate validFrom,
  ) async {
    final id = newId();
    await db.customStatement(
      'UPDATE recurrence_rule_versions SET is_current=0 WHERE series_id=?',
      [seriesId],
    );
    await _insert('recurrence_rule_versions', {
      'id': id,
      'profile_id': 'local',
      'series_id': seriesId,
      'valid_from': '$validFrom',
      'anchor_on': '${p.anchor}',
      'frequency': p.frequency.name,
      'interval_count': p.interval,
      'last_day': p.lastDay ? 1 : 0,
      'end_on': p.endOn?.toString(),
      'max_occurrences': p.maxOccurrences,
      ...ScheduleCodec.entryFields(entry),
      'created_at': _now,
    });
    await db.customStatement(
      'UPDATE recurrence_series SET paused_on=NULL,updated_at=?,revision=revision+1 WHERE id=?',
      [_now, seriesId],
    );
    return id;
  }

  @override
  Future<String> createOneOff({
    required String requestId,
    required PlannedEntry entry,
    required CivilDate date,
  }) => _command(
    requestId,
    'create_schedule',
    [..._entryPayload(entry), '$date'],
    () async {
      final valid = await _validateEntry(entry, date);
      final id = newId();
      await _occurrence(id, valid, date);
      return id;
    },
  );
  @override
  Future<String> createSeries({
    required String requestId,
    required PlannedEntry entry,
    required RecurrencePattern pattern,
  }) {
    RecurrenceRules.validate(pattern);
    return _command(
      requestId,
      'create_series',
      [..._entryPayload(entry), ..._patternPayload(pattern)],
      () async {
        final valid = await _validateEntry(entry, pattern.anchor);
        final id = newId();
        await _insert('recurrence_series', {
          'id': id,
          'profile_id': 'local',
          'name': valid.description,
          'kind': entry.kind.code,
          'created_at': _now,
          'updated_at': _now,
        });
        await _rule(id, valid, pattern, pattern.anchor);
        await _generate(clock.today.addDays(90));
        return id;
      },
    );
  }

  Future<void> _closeRules(
    String seriesId,
    CivilDate from,
  ) => db.customStatement(
    'UPDATE recurrence_rule_versions SET valid_until=? WHERE series_id=? AND (valid_until IS NULL OR valid_until>=?)',
    ['${from.addDays(-1)}', seriesId, '$from'],
  );
  Future<void> _cancelPending(
    String seriesId,
    CivilDate from,
  ) => db.customStatement(
    "UPDATE scheduled_occurrences SET status='cancelled',updated_at=?,revision=revision+1 WHERE series_id=? AND status='pending' AND scheduled_on>=?",
    [_now, seriesId, '$from'],
  );
  RecurrenceSeries _series(ScheduleSnapshot snapshot, String id) {
    final series = snapshot.series.where((s) => s.id == id).firstOrNull;
    if (series == null) {
      throw const FinanceFailure(
        'missing_series',
        'Esta recorrência não está disponível.',
      );
    }
    return series;
  }

  @override
  Future<String> reviseSeries({
    required String requestId,
    required String seriesId,
    required PlannedEntry entry,
    required RecurrencePattern pattern,
  }) {
    RecurrenceRules.validate(pattern);
    if (pattern.anchor.isBefore(clock.today)) {
      throw const FinanceFailure(
        'past_revision',
        'Altere as próximas a partir de hoje ou de uma data futura. As vencidas ficam preservadas.',
      );
    }
    return _command(
      requestId,
      'revise_series',
      [seriesId, ..._entryPayload(entry), ..._patternPayload(pattern)],
      () async {
        final snapshot = await _read();
        final series = _series(snapshot, seriesId);
        if (series.kind != entry.kind) {
          throw const FinanceFailure(
            'invalid_series',
            'Mantenha o tipo original da recorrência.',
          );
        }
        final valid = await _validateEntry(entry, pattern.anchor);
        await _closeRules(seriesId, pattern.anchor);
        await _cancelPending(seriesId, pattern.anchor);
        final revisedRuleId = await _rule(
          seriesId,
          valid,
          pattern,
          pattern.anchor,
        );
        if (series.paused) {
          await db.customStatement(
            'UPDATE recurrence_rule_versions SET valid_until=? WHERE id=?',
            ['${series.pausedOn!.addDays(-1)}', revisedRuleId],
          );
          await db.customStatement(
            'UPDATE recurrence_series SET paused_on=? WHERE id=?',
            ['${series.pausedOn}', seriesId],
          );
        }
        await db.customStatement(
          'UPDATE recurrence_series SET name=? WHERE id=?',
          [valid.description, seriesId],
        );
        await _generate(clock.today.addDays(90));
        return seriesId;
      },
    );
  }

  @override
  Future<String> pause({
    required String requestId,
    required String seriesId,
  }) => _command(requestId, 'pause_series', [seriesId], () async {
    final series = _series(await _read(), seriesId);
    if (series.paused) {
      throw const FinanceFailure(
        'already_paused',
        'A recorrência já está pausada.',
      );
    }
    await _closeRules(seriesId, clock.today);
    await _cancelPending(seriesId, clock.today);
    await db.customStatement(
      'UPDATE recurrence_series SET paused_on=?,updated_at=?,revision=revision+1 WHERE id=?',
      ['${clock.today}', _now, seriesId],
    );
    return seriesId;
  });
  @override
  Future<String> resume({
    required String requestId,
    required String seriesId,
  }) => _command(requestId, 'resume_series', [seriesId], () async {
    final snapshot = await _read();
    final series = _series(snapshot, seriesId);
    if (!series.paused) {
      throw const FinanceFailure('not_paused', 'A recorrência já está ativa.');
    }
    final current = snapshot.rules.singleWhere(
      (r) => r.id == series.currentRuleId,
    );
    final valid = await _validateEntry(
      current.entry,
      current.pattern.anchor.isAfter(clock.today)
          ? current.pattern.anchor
          : clock.today,
    );
    await _rule(seriesId, valid, current.pattern, clock.today);
    await _generate(clock.today.addDays(90));
    return seriesId;
  });

  ScheduledOccurrence _pending(ScheduleSnapshot snapshot, String id) {
    final occurrence = snapshot.occurrences
        .where((o) => o.id == id)
        .firstOrNull;
    if (occurrence == null || occurrence.status != OccurrenceStatus.pending) {
      throw const FinanceFailure(
        'not_pending',
        'Esta previsão não está mais pendente. Atualize a agenda.',
      );
    }
    return occurrence;
  }

  @override
  Future<String> editOccurrence({
    required String requestId,
    required String occurrenceId,
    required PlannedEntry entry,
    required CivilDate date,
  }) => _command(
    requestId,
    'edit_scheduled',
    [occurrenceId, ..._entryPayload(entry), '$date'],
    () async {
      final snapshot = await _read();
      final occurrence = _pending(snapshot, occurrenceId);
      if (entry.kind != occurrence.entry.kind) {
        throw const FinanceFailure(
          'invalid_kind',
          'Mantenha o tipo original desta previsão.',
        );
      }
      final valid = await _validateEntry(entry, date);
      if (occurrence.seriesId != null &&
          snapshot.occurrences.any(
            (o) =>
                o.id != occurrenceId &&
                o.seriesId == occurrence.seriesId &&
                o.date == date &&
                o.status != OccurrenceStatus.cancelled,
          )) {
        throw const FinanceFailure(
          'duplicate_date',
          'Já existe uma ocorrência desta série na data escolhida.',
        );
      }
      final fields = {
        'scheduled_on': '$date',
        ...ScheduleCodec.entryFields(valid),
        'is_manual_override': 1,
        'updated_at': _now,
      };
      await db.customStatement(
        'UPDATE scheduled_occurrences SET ${fields.keys.map((k) => '$k=?').join(',')},revision=revision+1 WHERE id=?',
        [...fields.values, occurrenceId],
      );
      return occurrenceId;
    },
  );
  @override
  Future<String> skip({
    required String requestId,
    required String occurrenceId,
  }) => _command(requestId, 'skip_scheduled', [occurrenceId], () async {
    _pending(await _read(), occurrenceId);
    await db.customStatement(
      "UPDATE scheduled_occurrences SET status='skipped',updated_at=?,revision=revision+1 WHERE id=?",
      [_now, occurrenceId],
    );
    return occurrenceId;
  });

  @override
  Future<String> settle({
    required String requestId,
    required String occurrenceId,
    required CivilDate date,
    bool confirmClosedCycle = false,
  }) {
    LedgerRules.effectiveDate(date, clock);
    return _command(
      requestId,
      'settle_scheduled',
      [occurrenceId, '$date', confirmClosedCycle],
      () async {
        final occurrence = _pending(await _read(), occurrenceId);
        final e = occurrence.entry;
        // Nested repositories share this executor. Their events and receipts cannot
        // commit independently of the occurrence link below.
        final eventRequestId = newId();
        final String eventId;
        if (e.kind == ScheduleKind.cardPurchase) {
          eventId = await LocalCardsRepository(db, clock, newId: newId)
              .purchase(
                requestId: eventRequestId,
                cardId: e.cardId!,
                categoryId: e.categoryId!,
                description: e.description,
                total: e.amount,
                installments: 1,
                date: date,
                billingOn: date,
                confirmClosedCycle: confirmClosedCycle,
                costNatureSnapshot: e.costNature,
                essentialSnapshot: e.essential,
              );
        } else {
          eventId = await LocalFinanceRepository(db, clock, newId: newId)
              .record(
                requestId: eventRequestId,
                kind: MovementKind.values.byName(e.kind.code),
                amount: e.amount,
                date: date,
                description: e.description,
                accountId: e.accountId!,
                destinationId: e.destinationId,
                categoryId: e.categoryId,
                costNatureSnapshot: e.costNature,
                essentialSnapshot: e.essential,
              );
        }
        await db.customStatement(
          "UPDATE scheduled_occurrences SET status='settled',settled_event_id=?,updated_at=?,revision=revision+1 WHERE id=?",
          [eventId, _now, occurrenceId],
        );
        return eventId;
      },
    );
  }

  @override
  Future<void> generateThrough(CivilDate through) {
    if (through.isBefore(clock.today) ||
        through.isAfter(clock.today.addDays(730))) {
      throw const FinanceFailure(
        'invalid_horizon',
        'Gere previsões entre hoje e os próximos dois anos.',
      );
    }
    return db.transaction(() async {
      final added = await _generate(through);
      await _validateTotals();
      if (added > 0) db.changed();
    });
  }

  Future<int> _generate(CivilDate through) async {
    final snapshot = await _read();
    final ordinalKeys = {
      for (final o in snapshot.occurrences)
        if (o.ruleId != null) '${o.ruleId}:${o.ordinal}',
    };
    final activeDates = {
      for (final o in snapshot.occurrences)
        if (o.seriesId != null && o.status != OccurrenceStatus.cancelled)
          '${o.seriesId}:${o.date}',
    };
    var added = 0;
    for (final rule in snapshot.rules) {
      for (final occurrence in RecurrenceRules.occurrences(rule, through)) {
        final ordinalKey = '${rule.id}:${occurrence.$1}';
        final dateKey = '${rule.seriesId}:${occurrence.$2}';
        if (ordinalKeys.contains(ordinalKey) || activeDates.contains(dateKey)) {
          continue;
        }
        if (++added > 5000) {
          throw const FinanceFailure(
            'too_many_occurrences',
            'Gere previsões em períodos menores.',
          );
        }
        await _occurrence(
          newId(),
          rule.entry,
          occurrence.$2,
          seriesId: rule.seriesId,
          ruleId: rule.id,
          ordinal: occurrence.$1,
        );
        ordinalKeys.add(ordinalKey);
        activeDates.add(dateKey);
      }
    }
    return added;
  }

  Future<String> _command(
    String requestId,
    String command,
    List<Object?> payload,
    Future<String> Function() operation,
  ) => _writer.command(requestId, command, payload, () async {
    final result = await operation();
    await _validateTotals();
    return result;
  });
  Future<void> _validateTotals() async {
    final snapshot = await _read();
    for (final kind in ScheduleKind.values) {
      Money.sum(
        snapshot.pending
            .where((o) => o.entry.kind == kind)
            .map((o) => o.entry.amount),
      );
    }
  }
}
