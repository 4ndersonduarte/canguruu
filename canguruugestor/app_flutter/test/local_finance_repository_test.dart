import 'dart:convert';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/failure.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/features/finance/data/local_finance_repository.dart';
import 'package:canguruu_finance/features/finance/domain/models.dart';
import 'package:canguruu_finance/persistence/database.dart'
    show CanguruuDatabase;

void main() {
  final today = CivilDate(2026, 9, 11);
  final openingDate = CivilDate(2026, 8, 1);
  final clock = FixedClock(DateTime.utc(2026, 9, 11, 15), today);
  late CanguruuDatabase db;
  late LocalFinanceRepository repo;
  var request = 0;
  String key() => 'request-${request++}';
  Future<String> account(String name, int cents) => repo.createAccount(
    requestId: key(),
    name: name,
    kind: AccountKind.bank,
    openingBalance: Money(cents),
    openedOn: openingDate,
  );
  Future<String> income(
    String id,
    int cents, {
    String? requestId,
    CivilDate? date,
  }) => repo.record(
    requestId: requestId ?? key(),
    kind: MovementKind.income,
    amount: Money(cents),
    date: date ?? today,
    description: 'Salário',
    accountId: id,
    categoryId: 'category-salary',
  );
  Future<String> expense(String id, int cents, {CivilDate? date}) =>
      repo.record(
        requestId: key(),
        kind: MovementKind.expense,
        amount: Money(cents),
        date: date ?? today,
        description: 'Almoço',
        accountId: id,
        categoryId: 'category-food',
      );
  setUp(() async {
    db = CanguruuDatabase(NativeDatabase.memory());
    repo = LocalFinanceRepository(db, clock);
    await repo.initialize();
  });
  tearDown(() => db.close());

  test('inicializa perfil e categorias sem movimentações fictícias', () async {
    await repo.initialize();
    final snapshot = await repo.read();
    expect(snapshot.accounts, isEmpty);
    expect(snapshot.events, isEmpty);
    expect(snapshot.categories, hasLength(8));
    expect(snapshot.balance, Money.zero);
  });
  test(
    'saldo inicial positivo e negativo não contam como renda ou despesa',
    () async {
      await account('Banco', 100000);
      await account('Cheque especial', -20000);
      final snapshot = await repo.read();
      expect(snapshot.balance.cents, 80000);
      expect(snapshot.incomeIn(openingDate), Money.zero);
      expect(snapshot.expenseIn(openingDate), Money.zero);
      expect(snapshot.balanceOn(CivilDate(2026, 7, 31)), Money.zero);
    },
  );
  test('receita, despesa e transferência conservam os totais', () async {
    final bank = await account('Banco', 100000);
    final wallet = await account('Carteira', 5000);
    await income(bank, 250000);
    await expense(bank, 70000);
    await repo.record(
      requestId: key(),
      kind: MovementKind.transfer,
      amount: Money(30000),
      date: today,
      description: 'Dinheiro para a semana',
      accountId: bank,
      destinationId: wallet,
    );
    final snapshot = await repo.read();
    expect(
      snapshot.accounts.singleWhere((a) => a.id == bank).balance.cents,
      250000,
    );
    expect(
      snapshot.accounts.singleWhere((a) => a.id == wallet).balance.cents,
      35000,
    );
    expect(snapshot.balance.cents, 285000);
    expect(snapshot.incomeIn(today).cents, 250000);
    expect(snapshot.expenseIn(today).cents, 70000);
    for (final event in snapshot.events) {
      expect(Money.sum(event.entries.map((e) => Money(e.cents))), Money.zero);
    }
  });
  test('saldo negativo é permitido e mantém a exatidão', () async {
    final id = await account('Banco', 0);
    await expense(id, 1001);
    expect((await repo.read()).balance.cents, -1001);
  });
  test('a mesma operação concorrente só grava uma vez', () async {
    final id = await account('Banco', 0);
    final operation = key();
    final results = await Future.wait([
      income(id, 350, requestId: operation),
      income(id, 350, requestId: operation),
    ]);
    expect(results.first, results.last);
    expect((await repo.read()).balance.cents, 350);
    expect((await repo.read()).events, hasLength(1));
    await expectLater(
      income(id, 351, requestId: operation),
      throwsA(isA<FinanceFailure>()),
    );
    expect((await repo.read()).balance.cents, 350);
  });
  test(
    'não permite transferência para a mesma conta ou categoria incompatível',
    () async {
      final id = await account('Banco', 5000);
      final before = await repo.exportBackup();
      await expectLater(
        repo.record(
          requestId: key(),
          kind: MovementKind.transfer,
          amount: Money(100),
          date: today,
          description: 'Transferir',
          accountId: id,
          destinationId: id,
        ),
        throwsA(isA<FinanceFailure>()),
      );
      await expectLater(
        repo.record(
          requestId: key(),
          kind: MovementKind.expense,
          amount: Money(100),
          date: today,
          description: 'Despesa',
          accountId: id,
          categoryId: 'category-salary',
        ),
        throwsA(isA<FinanceFailure>()),
      );
      expect(await repo.exportBackup(), before);
    },
  );
  test(
    'datas futuras ou anteriores ao saldo inicial não gravam dados',
    () async {
      final id = await account('Banco', 5000);
      final before = await repo.exportBackup();
      expect(
        () => income(id, 100, date: today.addDays(1)),
        throwsA(isA<FinanceFailure>()),
      );
      await expectLater(
        expense(id, 100, date: openingDate.addDays(-1)),
        throwsA(isA<FinanceFailure>()),
      );
      expect(await repo.exportBackup(), before);
    },
  );
  test(
    'falha no segundo lançamento reverte evento, recibo e primeiro lançamento',
    () async {
      final id = await account('Banco', 5000);
      final before = await repo.exportBackup();
      var generated = 0;
      final failing = LocalFinanceRepository(
        db,
        clock,
        newId: () => generated++ == 0 ? 'failing-event' : 'duplicate-posting',
      );
      await expectLater(
        failing.record(
          requestId: 'atomic-request',
          kind: MovementKind.income,
          amount: Money(100),
          date: today,
          description: 'Não deve persistir',
          accountId: id,
          categoryId: 'category-salary',
        ),
        throwsA(anything),
      );
      expect(await repo.exportBackup(), before);
      await income(id, 100, requestId: 'atomic-request');
      expect((await repo.read()).balance.cents, 5100);
    },
  );
  test('estorno preserva o original e compensa apenas uma vez', () async {
    final id = await account('Banco', 10000);
    final event = await expense(id, 1250);
    await repo.reverse(requestId: key(), eventId: event, date: today);
    final snapshot = await repo.read();
    expect(snapshot.balance.cents, 10000);
    expect(snapshot.expenseIn(today), Money.zero);
    expect(snapshot.events.singleWhere((e) => e.id == event).reversed, isTrue);
    expect(snapshot.events, hasLength(3));
    await expectLater(
      repo.reverse(requestId: key(), eventId: event, date: today),
      throwsA(isA<FinanceFailure>()),
    );
  });
  test(
    'estorno posterior afeta seu próprio mês sem apagar o mês original',
    () async {
      final id = await account('Banco', 10000);
      final event = await expense(id, 500, date: CivilDate(2026, 8, 20));
      await repo.reverse(requestId: key(), eventId: event, date: today);
      final snapshot = await repo.read();
      expect(snapshot.expenseIn(openingDate).cents, 500);
      expect(snapshot.expenseIn(today).cents, -500);
      expect(snapshot.balanceOn(CivilDate(2026, 8, 31)).cents, 9500);
      expect(snapshot.balance.cents, 10000);
    },
  );
  test('categorias têm somente dois níveis e respeitam o tipo', () async {
    final parent = await repo.createCategory(
      requestId: key(),
      name: 'Educação',
      kind: MovementKind.expense,
    );
    final child = await repo.createCategory(
      requestId: key(),
      name: 'Livros',
      kind: MovementKind.expense,
      parentId: parent,
    );
    await expectLater(
      repo.createCategory(
        requestId: key(),
        name: 'Técnicos',
        kind: MovementKind.expense,
        parentId: child,
      ),
      throwsA(isA<FinanceFailure>()),
    );
    await expectLater(
      repo.createCategory(
        requestId: key(),
        name: 'Renda',
        kind: MovementKind.income,
        parentId: parent,
      ),
      throwsA(isA<FinanceFailure>()),
    );
    expect((await repo.read()).categoryName(child), 'Educação / Livros');
  });
  test('arquivamento exige saldo zero e impede novos lançamentos', () async {
    final id = await account('Banco', 500);
    await expectLater(repo.archiveAccount(id), throwsA(isA<FinanceFailure>()));
    await expense(id, 500);
    await repo.archiveAccount(id);
    await expectLater(income(id, 100), throwsA(isA<FinanceFailure>()));
    expect((await repo.read()).activeAccounts, isEmpty);
  });
  test('overflow de total desfaz integralmente a nova operação', () async {
    final id = await account('Banco', Money.maxCents);
    final before = await repo.exportBackup();
    await expectLater(income(id, 1), throwsA(isA<FinanceFailure>()));
    expect(await repo.exportBackup(), before);
  });
  test('stream publica fotografia consistente após transferência', () async {
    final a = await account('Banco', 5000);
    final b = await account('Carteira', 0);
    final updates = <int>[];
    final subscription = repo.watch().listen(
      (snapshot) => updates.add(snapshot.balance.cents),
    );
    await Future<void>.delayed(const Duration(milliseconds: 30));
    await repo.record(
      requestId: key(),
      kind: MovementKind.transfer,
      amount: Money(2000),
      date: today,
      description: 'Transferência',
      accountId: a,
      destinationId: b,
    );
    await Future<void>.delayed(const Duration(milliseconds: 30));
    await subscription.cancel();
    expect(updates, isNotEmpty);
    expect(updates.every((value) => value == 5000), isTrue);
  });
  test(
    'backup restaura IDs, estornos e subcategorias, sem duplicar na segunda vez',
    () async {
      final id = await account('Banco', 10000);
      final category = await repo.createCategory(
        requestId: key(),
        name: 'Mercado',
        kind: MovementKind.expense,
        parentId: 'category-food',
      );
      final event = await repo.record(
        requestId: key(),
        kind: MovementKind.expense,
        amount: Money(1200),
        date: today,
        description: 'Compras',
        accountId: id,
        categoryId: category,
      );
      await repo.reverse(requestId: key(), eventId: event, date: today);
      final backup = await repo.exportBackup();
      expect((await repo.inspectBackup(backup)).accounts, 1);
      await income(id, 500);
      await repo.restoreBackup(backup);
      expect(await repo.exportBackup(), backup);
      await repo.restoreBackup(backup);
      expect(await repo.exportBackup(), backup);
      expect((await repo.read()).balance.cents, 10000);
    },
  );
  test(
    'rejeita backup incompleto, adulterado ou de versão futura sem perder a base',
    () async {
      final id = await account('Banco', 10000);
      await expense(id, 500);
      final before = await repo.exportBackup();
      final corruptions = <void Function(Map<String, dynamic>)>[
        (data) => data['schema_version'] = 999,
        (data) => data['currency'] = 'USD',
        (data) => (data['tables'] as Map).remove('postings'),
        (data) => (data['tables']['postings'] as List).removeLast(),
        (data) => data['tables']['postings'][0]['amount_cents'] += 1,
        (data) => data['tables']['postings'][0]['amount_cents'] = 1.5,
        (data) => data['tables']['accounts'][0]['opened_on'] = '2026-02-30',
        (data) => data['tables']['ledger_accounts'][0]['kind'] = 'equity',
        (data) => data['tables']['financial_events'][0]['idempotency_key'] =
            'missing',
        (data) => data['tables']['accounts'][0]['profile_id'] = 'other-profile',
        (data) => data['tables']['categories'][0]['parent_id'] = 'missing',
      ];
      for (final corrupt in corruptions) {
        final data = jsonDecode(before) as Map<String, dynamic>;
        corrupt(data);
        await expectLater(
          repo.restoreBackup(jsonEncode(data)),
          throwsA(isA<FinanceFailure>()),
        );
        expect(await repo.exportBackup(), before);
      }
      await expectLater(
        repo.restoreBackup('{invalid'),
        throwsA(isA<FinanceFailure>()),
      );
      expect(await repo.exportBackup(), before);
    },
  );
  test('arquivo SQLite sobrevive à reabertura e mantém o esquema v4', () async {
    final directory = await Directory.systemTemp.createTemp(
      'canguruu-persistence-test-',
    );
    final file = File('${directory.path}/finance.sqlite');
    CanguruuDatabase? first;
    CanguruuDatabase? second;
    try {
      first = CanguruuDatabase(NativeDatabase(file));
      final original = LocalFinanceRepository(first, clock);
      await original.initialize();
      final id = await original.createAccount(
        requestId: 'persist-account',
        name: 'Persistida',
        kind: AccountKind.wallet,
        openingBalance: Money(2505),
        openedOn: today,
      );
      await first.close();
      first = null;
      second = CanguruuDatabase(NativeDatabase(file));
      final reopened = LocalFinanceRepository(second, clock);
      await reopened.initialize();
      final snapshot = await reopened.read();
      expect(snapshot.accounts.single.id, id);
      expect(snapshot.balance.cents, 2505);
      expect(
        (await second.customSelect('PRAGMA user_version').getSingle())
            .data
            .values
            .single,
        4,
      );
      expect(
        await second.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
    } finally {
      await first?.close();
      await second?.close();
      await directory.delete(recursive: true);
    }
  });
}
