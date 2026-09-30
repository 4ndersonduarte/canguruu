import 'dart:convert';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/failure.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/persistence/database.dart'
    show CanguruuDatabase;
import 'package:canguruu_finance/features/finance/data/local_finance_repository.dart';
import 'package:canguruu_finance/features/finance/data/services/backup_service.dart';
import 'package:canguruu_finance/features/finance/domain/models.dart';
import 'package:canguruu_finance/features/cards/data/local_cards_repository.dart';
import 'package:canguruu_finance/features/cards/domain/services/card_rules.dart';
import 'package:canguruu_finance/features/schedule/data/local_schedule_repository.dart';
import 'package:canguruu_finance/features/schedule/domain/models.dart';
import 'package:canguruu_finance/features/schedule/domain/services/recurrence_rules.dart';

class TestClock implements Clock {
  TestClock(this.today);
  @override
  CivilDate today;
  @override
  DateTime get utcNow => today.dateTime.add(const Duration(hours: 15));
}

void main() {
  final today = CivilDate(2026, 9, 14);
  late TestClock clock;
  late CanguruuDatabase db;
  late LocalFinanceRepository finance;
  late LocalScheduleRepository schedule;
  late String bank;
  var number = 0;
  String key() => 'request-${number++}';
  PlannedEntry entry({
    int cents = 10000,
    ScheduleKind kind = ScheduleKind.expense,
    String? accountId,
    String? destinationId,
    String? cardId,
  }) => PlannedEntry(
    kind: kind,
    description: kind == ScheduleKind.income
        ? 'Recebimento previsto'
        : 'Compromisso previsto',
    amount: Money(cents),
    accountId: kind == ScheduleKind.cardPurchase ? null : accountId ?? bank,
    destinationId: destinationId,
    cardId: cardId,
    categoryId: kind == ScheduleKind.transfer
        ? null
        : kind == ScheduleKind.income
        ? 'category-salary'
        : 'category-food',
  );
  Future<String> series({
    CivilDate? anchor,
    RepeatFrequency frequency = RepeatFrequency.monthly,
    int? count,
    int cents = 10000,
  }) => schedule.createSeries(
    requestId: key(),
    entry: entry(cents: cents),
    pattern: RecurrencePattern(
      anchor: anchor ?? today,
      frequency: frequency,
      maxOccurrences: count,
    ),
  );
  setUp(() async {
    clock = TestClock(today);
    db = CanguruuDatabase(NativeDatabase.memory());
    finance = LocalFinanceRepository(db, clock);
    schedule = LocalScheduleRepository(db, clock);
    await finance.initialize();
    bank = await finance.createAccount(
      requestId: key(),
      name: 'Banco',
      kind: AccountKind.bank,
      openingBalance: Money(100000),
      openedOn: CivilDate(2026, 1, 1),
    );
  });
  tearDown(() => db.close());

  test('diária e semanal respeitam intervalo e término inclusivo', () {
    RecurrenceVersion rule(RecurrencePattern p) => RecurrenceVersion(
      id: 'r',
      seriesId: 's',
      validFrom: p.anchor,
      entry: entry(),
      pattern: p,
    );
    final daily = RecurrenceRules.occurrences(
      rule(
        RecurrencePattern(
          anchor: today,
          frequency: RepeatFrequency.daily,
          interval: 2,
          endOn: today.addDays(4),
        ),
      ),
      today.addDays(30),
    );
    expect(daily.map((v) => v.$2), [today, today.addDays(2), today.addDays(4)]);
    final weekly = RecurrenceRules.occurrences(
      rule(
        RecurrencePattern(
          anchor: today,
          frequency: RepeatFrequency.weekly,
          interval: 2,
          maxOccurrences: 3,
        ),
      ),
      today.addDays(90),
    );
    expect(weekly.map((v) => v.$2), [
      today,
      today.addDays(14),
      today.addDays(28),
    ]);
  });
  test('mensal dia 31 e último dia não perdem a âncora', () {
    final pattern = RecurrencePattern(
      anchor: CivilDate(2027, 1, 31),
      frequency: RepeatFrequency.monthly,
    );
    expect(
      [
        for (var i = 1; i <= 3; i++)
          RecurrenceRules.dateAt(pattern, i).toString(),
      ],
      ['2027-01-31', '2027-02-28', '2027-03-31'],
    );
    final last = RecurrencePattern(
      anchor: CivilDate(2028, 1, 15),
      frequency: RepeatFrequency.monthly,
      lastDay: true,
    );
    expect(RecurrenceRules.dateAt(last, 2), CivilDate(2028, 2, 29));
  });
  test('anual em 29 de fevereiro retorna ao dia 29 no próximo bissexto', () {
    final pattern = RecurrencePattern(
      anchor: CivilDate(2028, 2, 29),
      frequency: RepeatFrequency.yearly,
    );
    expect(RecurrenceRules.dateAt(pattern, 2), CivilDate(2029, 2, 28));
    expect(RecurrenceRules.dateAt(pattern, 5), CivilDate(2032, 2, 29));
  });
  test('janela de vigência preserva ordinal e limite original', () {
    final p = RecurrencePattern(
      anchor: today,
      frequency: RepeatFrequency.daily,
      maxOccurrences: 5,
    );
    final rule = RecurrenceVersion(
      id: 'r',
      seriesId: 's',
      validFrom: today.addDays(3),
      validUntil: today.addDays(8),
      pattern: p,
      entry: entry(),
    );
    expect(
      RecurrenceRules.occurrences(rule, today.addDays(90)).map((o) => o.$1),
      [4, 5],
    );
  });
  test(
    'recusa intervalo, término e geração excessiva sem série infinita',
    () async {
      expect(
        () => RecurrenceRules.validate(
          RecurrencePattern(
            anchor: today,
            frequency: RepeatFrequency.monthly,
            interval: 0,
          ),
        ),
        throwsA(isA<FinanceFailure>()),
      );
      expect(
        () => RecurrenceRules.validate(
          RecurrencePattern(
            anchor: today,
            frequency: RepeatFrequency.yearly,
            lastDay: true,
          ),
        ),
        throwsA(isA<FinanceFailure>()),
      );
      await expectLater(
        () => schedule.generateThrough(today.addDays(731)),
        throwsA(isA<FinanceFailure>()),
      );
      expect(
        () => RecurrenceRules.occurrences(
          RecurrenceVersion(
            id: 'r',
            seriesId: 's',
            validFrom: CivilDate(1900, 1, 1),
            entry: entry(),
            pattern: RecurrencePattern(
              anchor: CivilDate(1900, 1, 1),
              frequency: RepeatFrequency.daily,
            ),
          ),
          today,
        ),
        throwsA(isA<FinanceFailure>()),
      );
    },
  );
  test(
    'previsões avulsas e recorrentes não alteram saldo, despesas ou limite',
    () async {
      await schedule.createOneOff(
        requestId: key(),
        entry: entry(),
        date: today.addDays(3),
      );
      await series(count: 3);
      final f = await finance.read();
      expect(f.balance.cents, 100000);
      expect(f.expenseIn(today), Money.zero);
      expect((await schedule.read()).pending, hasLength(4));
    },
  );
  test(
    'gerar novamente e reabrir o repositório preserva IDs sem duplicação',
    () async {
      await series(count: 3);
      final ids = (await schedule.read()).occurrences.map((o) => o.id).toList();
      await schedule.generateThrough(today.addDays(90));
      schedule = LocalScheduleRepository(db, clock);
      await schedule.generateThrough(today.addDays(90));
      expect((await schedule.read()).occurrences.map((o) => o.id), ids);
    },
  );
  test(
    'confirmação concorrente com mesma chave cria um evento integral',
    () async {
      final id = await schedule.createOneOff(
        requestId: key(),
        entry: entry(),
        date: today,
      );
      final request = key();
      final events = await Future.wait([
        schedule.settle(requestId: request, occurrenceId: id, date: today),
        schedule.settle(requestId: request, occurrenceId: id, date: today),
      ]);
      expect(events.first, events.last);
      expect((await finance.read()).expenseIn(today).cents, 10000);
      expect((await finance.read()).balance.cents, 90000);
      expect((await schedule.read()).pending, isEmpty);
      await expectLater(
        schedule.settle(requestId: key(), occurrenceId: id, date: today),
        throwsA(isA<FinanceFailure>()),
      );
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test(
    'renda e transferência previstas são realizadas com a composição correta',
    () async {
      final other = await finance.createAccount(
        requestId: key(),
        name: 'Carteira',
        kind: AccountKind.wallet,
        openingBalance: Money.zero,
        openedOn: today,
      );
      final income = await schedule.createOneOff(
        requestId: key(),
        entry: entry(kind: ScheduleKind.income),
        date: today,
      );
      final transfer = await schedule.createOneOff(
        requestId: key(),
        entry: entry(kind: ScheduleKind.transfer, destinationId: other),
        date: today,
      );
      await schedule.settle(
        requestId: key(),
        occurrenceId: income,
        date: today,
      );
      await schedule.settle(
        requestId: key(),
        occurrenceId: transfer,
        date: today,
      );
      final f = await finance.read();
      expect(f.balance.cents, 110000);
      expect(f.incomeIn(today).cents, 10000);
      expect(f.expenseIn(today), Money.zero);
      expect(f.accounts.singleWhere((a) => a.id == other).balance.cents, 10000);
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test(
    'compra prevista de cartão só cria dívida e fatura quando realizada',
    () async {
      final cards = LocalCardsRepository(db, clock);
      final cardId = await cards.createCard(
        requestId: key(),
        name: 'Cartão',
        totalLimit: Money(500000),
        closingDay: 20,
        dueDay: 28,
        policy: ClosingPolicy.next,
        openedOn: today,
      );
      final id = await schedule.createOneOff(
        requestId: key(),
        entry: entry(kind: ScheduleKind.cardPurchase, cardId: cardId),
        date: today.addDays(5),
      );
      expect((await cards.read()).debt, Money.zero);
      await schedule.settle(requestId: key(), occurrenceId: id, date: today);
      expect((await cards.read()).debt.cents, 10000);
      expect(
        (await cards.read()).invoices.single.items.single.operation.count,
        1,
      );
      expect((await finance.read()).balance.cents, 100000);
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test('classificação é fotografada e preservada na realização', () async {
    final id = await schedule.createOneOff(
      requestId: key(),
      entry: entry(),
      date: today,
    );
    await db.customStatement(
      "UPDATE categories SET cost_nature='fixed',essential=0 WHERE id='category-food'",
    );
    await schedule.settle(requestId: key(), occurrenceId: id, date: today);
    final event = (await finance.read()).events.firstWhere(
      (e) => e.kind == 'expense',
    );
    expect(event.entries.last.costNature, CostNature.variable);
    expect(event.entries.last.essential, isTrue);
    await finance.inspectBackup(await finance.exportBackup());
  });
  test(
    'pausa e retomada não reconstroem intervalo suspenso, mesmo após reiniciar',
    () async {
      final id = await series(
        frequency: RepeatFrequency.daily,
        count: 10,
        anchor: today.addDays(-1),
      );
      await schedule.pause(requestId: key(), seriesId: id);
      clock.today = today.addDays(3);
      schedule = LocalScheduleRepository(db, clock);
      await schedule.generateThrough(clock.today.addDays(90));
      expect((await schedule.read()).pending.map((o) => o.date), [
        today.addDays(-1),
      ]);
      await schedule.resume(requestId: key(), seriesId: id);
      final pending = (await schedule.read()).pending;
      expect(
        pending.any(
          (o) => !o.date.isBefore(today) && o.date.isBefore(clock.today),
        ),
        isFalse,
      );
      expect(pending.any((o) => o.date == clock.today), isTrue);
      expect(pending.last.date, today.addDays(8));
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test(
    'editar próximas mantém realizadas e vencidas; substitui somente futuras pendentes',
    () async {
      final id = await series(
        frequency: RepeatFrequency.daily,
        count: 5,
        anchor: today.addDays(-1),
      );
      final original = (await schedule.read()).pending;
      await schedule.settle(
        requestId: key(),
        occurrenceId: original[1].id,
        date: today,
      );
      await schedule.reviseSeries(
        requestId: key(),
        seriesId: id,
        entry: entry(cents: 20000),
        pattern: RecurrencePattern(
          anchor: today,
          frequency: RepeatFrequency.daily,
          maxOccurrences: 3,
        ),
      );
      final after = await schedule.read();
      expect(
        after.pending
            .singleWhere((o) => o.date == today.addDays(-1))
            .entry
            .amount
            .cents,
        10000,
      );
      expect(
        after.occurrences.singleWhere((o) => o.id == original[1].id).status,
        OccurrenceStatus.settled,
      );
      expect(
        after.pending
            .where((o) => o.date.isAfter(today))
            .every((o) => o.entry.amount.cents == 20000),
        isTrue,
      );
      expect(after.pending.any((o) => o.date == today), isFalse);
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test(
    'editar somente uma ocorrência e ignorar não são desfeitos pela geração',
    () async {
      await series(count: 3);
      final pending = (await schedule.read()).pending;
      await schedule.editOccurrence(
        requestId: key(),
        occurrenceId: pending[0].id,
        entry: entry(cents: 5000),
        date: today.addDays(1),
      );
      await schedule.skip(requestId: key(), occurrenceId: pending[1].id);
      await schedule.generateThrough(today.addDays(90));
      final after = await schedule.read();
      expect(
        after.occurrences
            .singleWhere((o) => o.id == pending[0].id)
            .manualOverride,
        isTrue,
      );
      expect(
        after.occurrences.singleWhere((o) => o.id == pending[1].id).status,
        OccurrenceStatus.skipped,
      );
      expect(after.occurrences, hasLength(3));
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test(
    'edição de ocorrência recusa data ocupada por outra ocorrência ativa',
    () async {
      await series(count: 2);
      final items = (await schedule.read()).pending;
      await expectLater(
        schedule.editOccurrence(
          requestId: key(),
          occurrenceId: items.first.id,
          entry: entry(),
          date: items.last.date,
        ),
        throwsA(isA<FinanceFailure>()),
      );
    },
  );
  test(
    'falha ao vincular realização desfaz evento, lançamentos e recibos',
    () async {
      final id = await schedule.createOneOff(
        requestId: key(),
        entry: entry(),
        date: today,
      );
      final before = await finance.exportBackup();
      await db.customStatement(
        "CREATE TRIGGER fail_settle BEFORE UPDATE OF status ON scheduled_occurrences WHEN NEW.status='settled' BEGIN SELECT RAISE(ABORT, 'injected failure'); END",
      );
      final request = key();
      await expectLater(
        schedule.settle(requestId: request, occurrenceId: id, date: today),
        throwsA(anything),
      );
      expect(await finance.exportBackup(), before);
      await db.customStatement('DROP TRIGGER fail_settle');
      await schedule.settle(requestId: request, occurrenceId: id, date: today);
      expect((await finance.read()).balance.cents, 90000);
    },
  );
  test(
    'totais previstos excessivos são recusados na mesma transação',
    () async {
      await schedule.createOneOff(
        requestId: key(),
        entry: entry(cents: Money.maxCents),
        date: today,
      );
      final before = await finance.exportBackup();
      await expectLater(
        schedule.createOneOff(
          requestId: key(),
          entry: entry(cents: 1),
          date: today,
        ),
        throwsA(isA<FinanceFailure>()),
      );
      expect(await finance.exportBackup(), before);
    },
  );
  test(
    'backup v3 restaura regras, pausa, exceções e realizações sem duplicar',
    () async {
      final id = await series(count: 3);
      final o = (await schedule.read()).pending.first;
      await schedule.settle(requestId: key(), occurrenceId: o.id, date: today);
      await schedule.pause(requestId: key(), seriesId: id);
      final backup = await finance.exportBackup();
      await schedule.createOneOff(
        requestId: key(),
        entry: entry(),
        date: today,
      );
      await finance.restoreBackup(backup);
      await finance.restoreBackup(backup);
      expect(await finance.exportBackup(), backup);
      await schedule.generateThrough(today.addDays(90));
      expect((await schedule.read()).pending, isEmpty);
    },
  );
  test(
    'backup v2 pode ser restaurado pela nova versão sem inventar agenda',
    () async {
      final raw =
          jsonDecode(await finance.exportBackup()) as Map<String, dynamic>;
      raw['schema_version'] = 2;
      for (final table in BackupService.scheduleTableNames) {
        (raw['tables'] as Map).remove(table);
      }
      await series(count: 3);
      await finance.restoreBackup(jsonEncode(raw));
      expect((await schedule.read()).series, isEmpty);
      expect((await finance.read()).balance.cents, 100000);
    },
  );
  test(
    'backup adulterado em vigência, valor, origem ou liquidação preserva dados atuais',
    () async {
      await series(count: 3);
      await schedule.settle(
        requestId: key(),
        occurrenceId: (await schedule.read()).pending.first.id,
        date: today,
      );
      final good = await finance.exportBackup();
      final mutations = <void Function(Map<String, dynamic>)>[
        (t) => t['recurrence_rule_versions'][0]['interval_count'] = 0,
        (t) => t['scheduled_occurrences'][0]['amount_cents'] = 1234,
        (t) => t['scheduled_occurrences'][0]['rule_version_id'] = 'missing',
        (t) => t['scheduled_occurrences'][0]['ordinal'] = 0,
        (t) => t['recurrence_rule_versions'][0]['is_current'] = 0,
        (t) => t['recurrence_rule_versions'][0]['account_id'] = 'missing',
        (t) => t['scheduled_occurrences'].firstWhere(
          (o) => o['status'] == 'settled',
        )['settled_event_id'] = 'missing',
      ];
      for (final mutate in mutations) {
        final raw = jsonDecode(good) as Map<String, dynamic>;
        mutate(raw['tables'] as Map<String, dynamic>);
        await expectLater(
          finance.restoreBackup(jsonEncode(raw)),
          throwsA(isA<FinanceFailure>()),
        );
        expect(await finance.exportBackup(), good);
      }
    },
  );
  test(
    'editar série pausada permite trocar conta e retomar sem reabrir a pausa',
    () async {
      final id = await series(frequency: RepeatFrequency.daily, count: 8);
      await schedule.pause(requestId: key(), seriesId: id);
      final other = await finance.createAccount(
        requestId: key(),
        name: 'Outra conta',
        kind: AccountKind.bank,
        openingBalance: Money.zero,
        openedOn: today,
      );
      clock.today = today.addDays(2);
      await schedule.reviseSeries(
        requestId: key(),
        seriesId: id,
        entry: entry(cents: 2500, accountId: other),
        pattern: RecurrencePattern(
          anchor: clock.today,
          frequency: RepeatFrequency.daily,
          maxOccurrences: 5,
        ),
      );
      expect((await schedule.read()).series.single.paused, isTrue);
      expect((await schedule.read()).pending, isEmpty);
      final backup = await finance.exportBackup();
      await finance.inspectBackup(backup);
      await finance.restoreBackup(backup);
      clock.today = today.addDays(4);
      await schedule.resume(requestId: key(), seriesId: id);
      final pending = (await schedule.read()).pending;
      expect(pending.map((o) => o.date), [
        today.addDays(4),
        today.addDays(5),
        today.addDays(6),
      ]);
      expect(
        pending.every(
          (o) => o.entry.accountId == other && o.entry.amount.cents == 2500,
        ),
        isTrue,
      );
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
}
