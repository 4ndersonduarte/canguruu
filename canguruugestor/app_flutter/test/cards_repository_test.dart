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

void main() {
  final today = CivilDate(2026, 9, 14);
  final opened = CivilDate(2026, 8, 1);
  final clock = FixedClock(DateTime.utc(2026, 9, 14, 15), today);
  late CanguruuDatabase db;
  late LocalFinanceRepository finance;
  late LocalCardsRepository cards;
  var number = 0;
  String key() => 'request-${number++}';
  Future<String> card({
    int limit = 500000,
    int debt = 0,
    int closing = 20,
    int due = 28,
  }) => cards.createCard(
    requestId: key(),
    name: 'Meu cartão',
    totalLimit: Money(limit),
    closingDay: closing,
    dueDay: due,
    policy: ClosingPolicy.next,
    openedOn: opened,
    openingDebt: Money(debt),
  );
  Future<String> account([int balance = 100000]) => finance.createAccount(
    requestId: key(),
    name: 'Banco',
    kind: AccountKind.bank,
    openingBalance: Money(balance),
    openedOn: opened,
  );
  Future<String> buy(
    String cardId, {
    int total = 120000,
    int count = 3,
    CivilDate? date,
    CivilDate? billing,
    bool confirm = false,
    String? requestId,
  }) => cards.purchase(
    requestId: requestId ?? key(),
    cardId: cardId,
    categoryId: 'category-food',
    description: 'Compra teste',
    total: Money(total),
    installments: count,
    date: date ?? today,
    billingOn: billing ?? date ?? today,
    confirmClosedCycle: confirm,
  );
  setUp(() async {
    db = CanguruuDatabase(NativeDatabase.memory());
    finance = LocalFinanceRepository(db, clock);
    cards = LocalCardsRepository(db, clock);
    await finance.initialize();
  });
  tearDown(() => db.close());

  test('nenhum cartão ou fatura fictícios', () async {
    expect((await cards.read()).cards, isEmpty);
    expect((await cards.read()).invoices, isEmpty);
  });
  test(
    'compra reconhece despesa e dívida total, sem retirar caixa ou duplicar parcelas',
    () async {
      await account();
      final id = await card();
      await buy(id);
      final c = await cards.read();
      final f = await finance.read();
      expect(c.debt.cents, 120000);
      expect(c.cards.single.available.cents, 380000);
      expect(c.invoices.map((i) => i.balance.cents), [40000, 40000, 40000]);
      expect(c.invoices.map((i) => i.dueOn.toString()), [
        '2026-09-28',
        '2026-10-28',
        '2026-11-28',
      ]);
      expect(c.installmentCommitment.cents, 120000);
      expect(f.balance.cents, 100000);
      expect(f.expenseIn(today).cents, 120000);
      expect(f.cardDebt.cents, 120000);
      expect(f.netWorth.cents, -20000);
    },
  );
  test(
    'dívida inicial afeta patrimônio e cria cobrança, sem despesa nova',
    () async {
      await account();
      await card(debt: 50000);
      expect((await cards.read()).invoices.single.total.cents, 50000);
      final f = await finance.read();
      expect(f.expenseIn(opened), Money.zero);
      expect(f.netWorth.cents, 50000);
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test('permite dívida real acima do limite e mostra excesso', () async {
    final id = await card(limit: 10000);
    await buy(id, total: 15000, count: 1);
    final c = (await cards.read()).cards.single;
    expect(c.excess.cents, 5000);
    expect(c.available, Money.zero);
  });
  test(
    'processamento define ciclo; compra define competência da despesa',
    () async {
      final id = await card();
      await buy(
        id,
        date: CivilDate(2026, 8, 31),
        billing: CivilDate(2026, 9, 1),
      );
      expect((await finance.read()).expenseIn(opened).cents, 120000);
      expect((await finance.read()).expenseIn(today), Money.zero);
      expect(
        (await cards.read()).invoices.first.closingOn,
        CivilDate(2026, 9, 20),
      );
    },
  );
  test(
    'ciclo encerrado exige conferência explícita, preservada no backup',
    () async {
      final id = await card(closing: 10, due: 17);
      await expectLater(
        buy(id, date: CivilDate(2026, 9, 9)),
        throwsA(isA<FinanceFailure>()),
      );
      await buy(id, date: CivilDate(2026, 9, 9), confirm: true);
      final c = await cards.read();
      expect(c.operations.single.reconciled, isTrue);
      expect(c.invoices.first.closed(today), isTrue);
      expect(c.invoices.first.overdue(CivilDate(2026, 9, 18)), isTrue);
      await finance.inspectBackup(await finance.exportBackup());
    },
  );
  test(
    'pagamento parcial reduz saldo e dívida e mantém despesas e vencimento',
    () async {
      final bank = await account();
      final id = await card();
      await buy(id);
      final invoice = (await cards.read()).invoices.first;
      await cards.payInvoice(
        requestId: key(),
        invoiceId: invoice.id,
        accountId: bank,
        amount: Money(20000),
        date: today,
      );
      final after = (await cards.read()).invoices.first;
      expect(after.balance.cents, 20000);
      expect(after.settlement(today), 'Pagamento parcial');
      expect(after.dueOn, invoice.dueOn);
      final f = await finance.read();
      expect(f.balance.cents, 80000);
      expect(f.cardDebt.cents, 100000);
      expect(f.expenseIn(today).cents, 120000);
      expect(f.netWorth.cents, -20000);
    },
  );
  test(
    'pagamento integral em ciclo aberto continua identificado como ciclo aberto',
    () async {
      final bank = await account();
      final id = await card();
      await buy(id);
      final invoice = (await cards.read()).invoices.first;
      await cards.payInvoice(
        requestId: key(),
        invoiceId: invoice.id,
        accountId: bank,
        amount: invoice.total,
        date: today,
      );
      final after = (await cards.read()).invoices.first;
      expect(after.balance, Money.zero);
      expect(after.closed(today), isFalse);
      expect(after.settlement(today), 'Sem saldo em aberto');
      expect(after.settlement(CivilDate(2026, 9, 21)), 'Quitada');
    },
  );
  test(
    'mesma chave não duplica compra nem pagamento, inclusive concorrente',
    () async {
      final bank = await account();
      final id = await card();
      final purchaseKey = key();
      final buys = await Future.wait([
        buy(id, requestId: purchaseKey),
        buy(id, requestId: purchaseKey),
      ]);
      expect(buys.first, buys.last);
      final invoice = (await cards.read()).invoices.first;
      final paymentKey = key();
      Future<String> pay() => cards.payInvoice(
        requestId: paymentKey,
        invoiceId: invoice.id,
        accountId: bank,
        amount: Money(10000),
        date: today,
      );
      final payments = await Future.wait([pay(), pay()]);
      expect(payments.first, payments.last);
      expect((await finance.read()).balance.cents, 90000);
      expect((await cards.read()).invoices.first.paid.cents, 10000);
      await expectLater(
        buy(id, total: 120001, requestId: purchaseKey),
        throwsA(isA<FinanceFailure>()),
      );
    },
  );
  test('pagamentos concorrentes diferentes não ultrapassam a fatura', () async {
    final bank = await account();
    final id = await card();
    await buy(id);
    final invoice = (await cards.read()).invoices.first;
    final results = await Future.wait(
      List.generate(2, (_) async {
        try {
          await cards.payInvoice(
            requestId: key(),
            invoiceId: invoice.id,
            accountId: bank,
            amount: Money(30000),
            date: today,
          );
          return true;
        } on FinanceFailure {
          return false;
        }
      }),
    );
    expect(results.where((r) => r), hasLength(1));
    expect((await cards.read()).invoices.first.balance.cents, 10000);
    expect((await finance.read()).balance.cents, 70000);
  });
  test(
    'adiantar fatura futura reduz parcelas pendentes sem nova despesa',
    () async {
      final bank = await account(200000);
      final id = await card();
      await buy(id);
      final invoice = (await cards.read()).invoices.last;
      await cards.payInvoice(
        requestId: key(),
        invoiceId: invoice.id,
        accountId: bank,
        amount: invoice.total,
        date: today,
      );
      final after = await cards.read();
      expect(after.invoices.last.remainingByItem.values.single, Money.zero);
      expect(after.installmentCommitment.cents, 80000);
      expect((await finance.read()).expenseIn(today).cents, 120000);
    },
  );
  test(
    'datas futuras, compra anterior ao cartão e pagamento antes da dívida são recusados',
    () async {
      final bank = await account();
      final id = await card();
      for (final date in [today.addDays(1), opened.addDays(-1)]) {
        await expectLater(
          () => buy(id, date: date),
          throwsA(isA<FinanceFailure>()),
        );
      }
      await expectLater(
        buy(id, billing: today.addDays(-1)),
        throwsA(isA<FinanceFailure>()),
      );
      await buy(id);
      await expectLater(
        cards.payInvoice(
          requestId: key(),
          invoiceId: (await cards.read()).invoices.first.id,
          accountId: bank,
          amount: Money(100),
          date: today.addDays(-1),
        ),
        throwsA(isA<FinanceFailure>()),
      );
      expect((await cards.read(asOf: today.addDays(-1))).debt, Money.zero);
    },
  );
  test('estorno genérico não deixa parcelas ou alocações órfãs', () async {
    final id = await card();
    final event = await buy(id);
    await expectLater(
      finance.reverse(requestId: key(), eventId: event, date: today),
      throwsA(isA<FinanceFailure>()),
    );
    expect((await cards.read()).debt.cents, 120000);
  });
  test(
    'falha ao gravar parcela desfaz compra, lançamentos, fatura e recibo; permite repetir',
    () async {
      final id = await card();
      final before = await finance.exportBackup();
      await db.customStatement(
        "CREATE TRIGGER fail_item BEFORE INSERT ON invoice_items WHEN NEW.sequence=2 BEGIN SELECT RAISE(ABORT, 'injected failure'); END",
      );
      final requestId = key();
      await expectLater(buy(id, requestId: requestId), throwsA(anything));
      expect(await finance.exportBackup(), before);
      await db.customStatement('DROP TRIGGER fail_item');
      await buy(id, requestId: requestId);
      expect((await cards.read()).debt.cents, 120000);
    },
  );
  test('falha na alocação desfaz pagamento e permite repetir', () async {
    final bank = await account();
    final id = await card();
    await buy(id);
    final invoice = (await cards.read()).invoices.first;
    final before = await finance.exportBackup();
    await db.customStatement(
      "CREATE TRIGGER fail_payment BEFORE INSERT ON invoice_payment_allocations BEGIN SELECT RAISE(ABORT, 'injected failure'); END",
    );
    final requestId = key();
    Future<String> pay() => cards.payInvoice(
      requestId: requestId,
      invoiceId: invoice.id,
      accountId: bank,
      amount: Money(10000),
      date: today,
    );
    await expectLater(pay(), throwsA(anything));
    expect(await finance.exportBackup(), before);
    await db.customStatement('DROP TRIGGER fail_payment');
    await pay();
    expect((await cards.read()).invoices.first.paid.cents, 10000);
  });
  test(
    'backup v2 preserva cartões, parcelas e pagamentos após restaurar duas vezes',
    () async {
      final bank = await account();
      final id = await card();
      await buy(id, total: 10000);
      final invoice = (await cards.read()).invoices.first;
      await cards.payInvoice(
        requestId: key(),
        invoiceId: invoice.id,
        accountId: bank,
        amount: Money(1000),
        date: today,
      );
      final backup = await finance.exportBackup();
      await finance.inspectBackup(backup);
      await buy(id, total: 5000);
      await finance.restoreBackup(backup);
      await finance.restoreBackup(backup);
      expect(await finance.exportBackup(), backup);
      expect((await cards.read()).debt.cents, 9000);
    },
  );
  test('backup v1 permanece importável, sem inventar cartões', () async {
    await account();
    final old =
        jsonDecode(await finance.exportBackup()) as Map<String, dynamic>;
    old['schema_version'] = 1;
    for (final table in [
      ...BackupService.cardTableNames,
      ...BackupService.scheduleTableNames,
    ]) {
      (old['tables'] as Map).remove(table);
    }
    final content = jsonEncode(old);
    await card();
    await finance.restoreBackup(content);
    expect((await cards.read()).cards, isEmpty);
    expect((await finance.read()).balance.cents, 100000);
  });
  test(
    'cópias adulteradas de parcelas, ciclos, dívida ou pagamentos nunca substituem dados',
    () async {
      final bank = await account();
      final id = await card();
      await buy(id, total: 10000);
      await cards.payInvoice(
        requestId: key(),
        invoiceId: (await cards.read()).invoices.first.id,
        accountId: bank,
        amount: Money(1000),
        date: today,
      );
      final good = await finance.exportBackup();
      final mutations = <void Function(Map<String, dynamic>)>[
        (t) => t['invoice_items'][0]['amount_cents'] = 1,
        (t) => t['invoice_items'].removeLast(),
        (t) => t['invoices'][0]['due_on'] = '2026-01-01',
        (t) => t['invoices'][0]['card_id'] = 'missing',
        (t) => t['card_operations'][0]['total_cents'] = 20000,
        (t) => t['invoice_payments'][0]['amount_cents'] = 2000,
        (t) => t['invoice_payment_allocations'][0]['amount_cents'] = 999999,
        (t) => t['invoice_payment_allocations'].clear(),
        (t) => t['credit_cards'][0]['closing_day'] = 0,
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
    'pagamento retroativo não cria saldo negativo entre compras posteriores',
    () async {
      final bank = await account();
      final id = await card();
      await buy(id, total: 10000, count: 1, date: CivilDate(2026, 9, 1));
      final invoice = (await cards.read()).invoices.single;
      await cards.payInvoice(
        requestId: key(),
        invoiceId: invoice.id,
        accountId: bank,
        amount: Money(10000),
        date: CivilDate(2026, 9, 5),
      );
      await buy(id, total: 10000, count: 1, date: CivilDate(2026, 9, 10));
      final before = await finance.exportBackup();
      await expectLater(
        cards.payInvoice(
          requestId: key(),
          invoiceId: invoice.id,
          accountId: bank,
          amount: Money(10000),
          date: CivilDate(2026, 9, 1),
        ),
        throwsA(isA<FinanceFailure>()),
      );
      expect(await finance.exportBackup(), before);
    },
  );
}
