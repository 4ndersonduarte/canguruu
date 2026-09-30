import '../../../../core/civil_date.dart';
import '../../../../core/failure.dart';
import '../../../../core/money.dart';
import '../../domain/models.dart';
import '../../domain/services/recurrence_rules.dart';
import 'schedule_codec.dart';

final class ScheduleBackupValidator {
  ScheduleBackupValidator(this.clock);
  final Clock clock;
  Never _invalid() => throw const FinanceFailure(
    'invalid_backup',
    'A agenda desta cópia contém registros inconsistentes.',
  );
  void validate(Map<String, List<Map<String, Object?>>> data) {
    Map<String, Map<String, Object?>> index(String table) {
      final rows = data[table]!;
      final result = {for (final r in rows) r['id'] as String: r};
      if (result.length != rows.length) _invalid();
      return result;
    }

    final series = index('recurrence_series');
    final ruleRows = index('recurrence_rule_versions');
    final occurrences = index('scheduled_occurrences');
    final accounts = index('accounts');
    final cards = index('credit_cards');
    final categories = index('categories');
    final events = index('financial_events');
    final receipts = index('operation_receipts');
    void entry(PlannedEntry e, CivilDate date) {
      if (e.amount.cents <= 0) _invalid();
      void account(String? id) {
        final a = accounts[id];
        if (a == null ||
            date.isBefore(CivilDate.parse(a['opened_on'] as String))) {
          _invalid();
        }
      }

      if (e.kind == ScheduleKind.cardPurchase) {
        final card = cards[e.cardId];
        if (card == null ||
            e.accountId != null ||
            e.destinationId != null ||
            date.isBefore(CivilDate.parse(card['opened_on'] as String))) {
          _invalid();
        }
      } else {
        account(e.accountId);
        if (e.cardId != null) _invalid();
      }
      if (e.kind == ScheduleKind.transfer) {
        account(e.destinationId);
        if (e.destinationId == e.accountId ||
            e.categoryId != null ||
            e.costNature != null ||
            e.essential != null) {
          _invalid();
        }
      } else {
        if (e.destinationId != null) _invalid();
        final expense = e.kind != ScheduleKind.income;
        if (categories[e.categoryId]?['kind'] !=
                (expense ? 'expense' : 'income') ||
            expense && (e.costNature == null || e.essential == null) ||
            !expense && (e.costNature != null || e.essential != null)) {
          _invalid();
        }
      }
    }

    final rules = <String, RecurrenceVersion>{};
    for (final row in ruleRows.values) {
      final s = series[row['series_id']];
      if (s == null) _invalid();
      final rule = ScheduleCodec.rule(
        row,
        ScheduleKind.parse(s['kind'] as String),
      );
      RecurrenceRules.validate(rule.pattern);
      entry(rule.entry, rule.pattern.anchor);
      rules[rule.id] = rule;
    }
    for (final s in series.values) {
      final versions = rules.values.where((r) => r.seriesId == s['id']).toList()
        ..sort((a, b) => a.validFrom.compareTo(b.validFrom));
      final current = versions
          .where((r) => ruleRows[r.id]!['is_current'] == 1)
          .toList();
      if (current.length != 1 ||
          !receipts.values.any(
            (r) => r['command'] == 'create_series' && r['result_id'] == s['id'],
          )) {
        _invalid();
      }
      CivilDate? end;
      for (final r in versions) {
        if (r.validUntil != null && r.validUntil!.isBefore(r.validFrom)) {
          continue;
        }
        if (end != null && !r.validFrom.isAfter(end)) _invalid();
        end = r.validUntil ?? CivilDate(9999, 12, 31);
      }
      if (s['paused_on'] != null) {
        final paused = CivilDate.parse(s['paused_on'] as String);
        if (paused.isAfter(clock.today) ||
            versions.any(
              (r) => r.validUntil == null || !r.validUntil!.isBefore(paused),
            )) {
          _invalid();
        }
      } else if (current.single.validUntil != null) {
        _invalid();
      }
    }
    final pending = <ScheduleKind, List<Money>>{};
    for (final row in occurrences.values) {
      final e = ScheduleCodec.entry(row);
      final date = CivilDate.parse(row['scheduled_on'] as String);
      entry(e, date);
      final status = OccurrenceStatus.values.byName(row['status'] as String);
      if (status == OccurrenceStatus.pending) {
        (pending[e.kind] ??= []).add(e.amount);
      }
      if (row['series_id'] == null) {
        if (row['rule_version_id'] != null ||
            row['ordinal'] != null ||
            !receipts.values.any(
              (r) =>
                  r['command'] == 'create_schedule' &&
                  r['result_id'] == row['id'],
            )) {
          _invalid();
        }
      } else {
        final rule = rules[row['rule_version_id']];
        if (rule == null ||
            rule.seriesId != row['series_id'] ||
            rule.entry.kind != e.kind ||
            row['ordinal'] is! int) {
          _invalid();
        }
        final ordinal = row['ordinal'] as int;
        final originalDate = RecurrenceRules.dateAt(rule.pattern, ordinal);
        if (originalDate.isBefore(rule.validFrom) ||
            rule.pattern.maxOccurrences != null &&
                ordinal > rule.pattern.maxOccurrences! ||
            rule.pattern.endOn != null &&
                originalDate.isAfter(rule.pattern.endOn!)) {
          _invalid();
        }
        if (row['is_manual_override'] == 0) {
          if (date != originalDate) _invalid();
          final fields = ScheduleCodec.entryFields(rule.entry);
          for (final field in fields.keys) {
            if (fields[field] != row[field]) _invalid();
          }
          if (status == OccurrenceStatus.pending &&
              rule.validUntil != null &&
              date.isAfter(rule.validUntil!)) {
            _invalid();
          }
        }
      }
      if (status == OccurrenceStatus.settled) {
        final event = events[row['settled_event_id']];
        if (event == null ||
            event['kind'] != e.kind.code ||
            event['description'] != e.description) {
          _invalid();
        }
        final postings = data['postings']!
            .where((p) => p['event_id'] == event['id'])
            .toList();
        final expected = switch (e.kind) {
          ScheduleKind.income => {
            e.accountId: e.amount.cents,
            'system-income': -e.amount.cents,
          },
          ScheduleKind.expense => {
            e.accountId: -e.amount.cents,
            'system-expense': e.amount.cents,
          },
          ScheduleKind.transfer => {
            e.accountId: -e.amount.cents,
            e.destinationId: e.amount.cents,
          },
          ScheduleKind.cardPurchase => {
            e.cardId: -e.amount.cents,
            'system-expense': e.amount.cents,
          },
        };
        if (postings.length != 2 ||
            postings.any(
              (p) => expected[p['ledger_account_id']] != p['amount_cents'],
            )) {
          _invalid();
        }
        final classified = postings
            .where((p) => p['category_id'] != null)
            .firstOrNull;
        if (e.categoryId != null &&
            (classified == null ||
                classified['category_id'] != e.categoryId ||
                classified['cost_nature'] != e.costNature?.name ||
                classified['essential'] !=
                    (e.essential == null
                        ? null
                        : e.essential!
                        ? 1
                        : 0))) {
          _invalid();
        }
        if (e.kind == ScheduleKind.cardPurchase &&
            !data['card_operations']!.any(
              (o) => o['id'] == event['id'] && o['installment_count'] == 1,
            )) {
          _invalid();
        }
        if (receipts.values
                .where(
                  (r) =>
                      r['command'] == 'settle_scheduled' &&
                      r['result_id'] == event['id'],
                )
                .length !=
            1) {
          _invalid();
        }
      } else if (row['settled_event_id'] != null) {
        _invalid();
      }
    }
    for (final amounts in pending.values) {
      Money.sum(amounts);
    }
    for (final receipt in receipts.values) {
      final command = receipt['command'];
      final result = receipt['result_id'];
      if ([
                'create_series',
                'revise_series',
                'pause_series',
                'resume_series',
              ].contains(command) &&
              !series.containsKey(result) ||
          [
                'create_schedule',
                'edit_scheduled',
                'skip_scheduled',
              ].contains(command) &&
              !occurrences.containsKey(result) ||
          command == 'settle_scheduled' &&
              !occurrences.values.any(
                (o) =>
                    o['settled_event_id'] == result && o['status'] == 'settled',
              )) {
        _invalid();
      }
    }
  }
}
