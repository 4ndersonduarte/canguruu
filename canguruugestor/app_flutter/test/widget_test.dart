import 'package:canguruu_finance/features/schedule/data/local_schedule_repository.dart';
import 'package:drift/native.dart';
import 'package:canguruu_finance/features/cards/data/local_cards_repository.dart';
import 'package:canguruu_finance/features/cards/domain/services/card_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/app/app.dart';
import 'package:canguruu_finance/app/providers.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/features/finance/data/local_finance_repository.dart';
import 'package:canguruu_finance/features/finance/domain/models.dart';
import 'package:canguruu_finance/persistence/database.dart'
    show CanguruuDatabase;

void main() {
  late CanguruuDatabase db;
  late LocalFinanceRepository repo;
  final clock = FixedClock(
    DateTime.utc(2026, 9, 11, 15),
    CivilDate(2026, 9, 11),
  );
  setUp(() async {
    db = CanguruuDatabase(NativeDatabase.memory());
    repo = LocalFinanceRepository(db, clock);
    await repo.initialize();
  });
  tearDown(() => db.close());

  Future<void> launch(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithValue(repo),
          databaseProvider.overrideWithValue(db),
          clockProvider.overrideWithValue(clock),
        ],
        child: const CanguruuApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('conta criada pelo formulário aparece com saldo persistido', (
    tester,
  ) async {
    await launch(tester, const Size(1440, 1000));
    expect(find.text('Seu dinheiro'), findsOneWidget);
    await tester.tap(find.text('Adicionar conta').first);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('account-name')),
      'Minha conta',
    );
    await tester.enterText(
      find.byKey(const Key('opening-balance')),
      '1.000,00',
    );
    await tester.tap(find.byKey(const Key('submit-form')));
    await tester.pumpAndSettle();
    expect((await repo.read()).balance.cents, 100000);
    expect(find.text('R\$ 1.000,00'), findsWidgets);
    // Flutter test reports layout exceptions with their widget locations.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets(
    'despesa válida atualiza o saldo e formulário inválido fica aberto',
    (tester) async {
      await repo.createAccount(
        requestId: 'account',
        name: 'Banco',
        kind: AccountKind.bank,
        openingBalance: Money(10000),
        openedOn: clock.today,
      );
      await launch(tester, const Size(1100, 1100));
      await tester.tap(find.text('Nova movimentação').first);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('submit-form')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('form-error')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('movement-amount')), '25,50');
      await tester.enterText(
        find.byKey(const Key('movement-description')),
        'Café da manhã',
      );
      await tester.tap(find.byKey(const ValueKey('category-expense')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alimentação').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('submit-form')));
      await tester.pumpAndSettle();
      expect((await repo.read()).balance.cents, 7450);
      expect((await repo.read()).expenseIn(clock.today).cents, 2550);
      expect(find.byKey(const Key('form-error')), findsNothing);
      // Flutter test reports layout exceptions with their widget locations.
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'layout mobile permite navegação e abertura do cadastro sem overflow',
    (tester) async {
      await launch(tester, const Size(390, 844));
      expect(find.byType(NavigationBar), findsOneWidget);
      await tester.tap(find.text('Contas'));
      await tester.pumpAndSettle();
      expect(find.text('Suas contas'), findsOneWidget);
      await tester.tap(find.text('Adicionar conta'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('account-name')), findsOneWidget);
      // Flutter test reports layout exceptions with their widget locations.
      await tester.tap(find.byTooltip('Fechar'));
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    },
  );

  for (final size in [const Size(390, 844), const Size(1440, 1000)]) {
    testWidgets(
      'cartões e parcelas cabem em ${size.width.toInt()}px e pagamento atualiza a tela',
      (tester) async {
        final cards = LocalCardsRepository(db, clock);
        await repo.createAccount(
          requestId: 'bank',
          name: 'Banco',
          kind: AccountKind.bank,
          openingBalance: Money(100000),
          openedOn: clock.today,
        );
        final id = await cards.createCard(
          requestId: 'card',
          name: 'Meu cartão',
          totalLimit: Money(500000),
          closingDay: 20,
          dueDay: 28,
          policy: ClosingPolicy.next,
          openedOn: clock.today,
        );
        await cards.purchase(
          requestId: 'buy',
          cardId: id,
          categoryId: 'category-food',
          description: 'Compra parcelada',
          total: Money(10000),
          installments: 3,
          date: clock.today,
          billingOn: clock.today,
        );
        await launch(tester, size);
        await tester.tap(find.text('Cartões').first);
        await tester.pumpAndSettle();
        expect(find.text('Seus cartões'), findsOneWidget);
        expect(find.text('R\$ 4.900,00'), findsOneWidget);
        final payButton = find.text('Registrar pagamento').first;
        await tester.ensureVisible(payButton);
        await tester.tap(payButton);
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('invoice-payment-amount')),
          '10,00',
        );
        await tester.ensureVisible(find.byKey(const Key('submit-form')));
        await tester.tap(find.byKey(const Key('submit-form')));
        await tester.pumpAndSettle();
        expect((await cards.read()).debt.cents, 9000);
        expect((await repo.read()).expenseIn(clock.today).cents, 10000);
        expect(find.text('Pagamento parcial'), findsOneWidget);
        final detail = find.text('Ver 1 cobranças e pagamentos').first;
        await tester.ensureVisible(detail);
        await tester.tap(detail);
        await tester.pumpAndSettle();
        expect(find.text('Compra parcelada'), findsOneWidget);
        await tester.pumpWidget(const SizedBox());
        await tester.pumpAndSettle();
      },
    );
  }
  for (final size in [const Size(390, 844), const Size(1440, 1000)]) {
    testWidgets(
      'agenda cria recorrência e confirma apenas uma em ${size.width.toInt()}px',
      (tester) async {
        await repo.createAccount(
          requestId: 'bank',
          name: 'Banco',
          kind: AccountKind.bank,
          openingBalance: Money(100000),
          openedOn: clock.today,
        );
        final schedule = LocalScheduleRepository(db, clock);
        await launch(tester, size);
        await tester.tap(find.text('Agenda').first);
        await tester.pumpAndSettle();
        expect(find.text('Sua agenda financeira'), findsOneWidget);
        await tester.tap(find.text('Nova recorrência').first);
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('schedule-description')),
          'Assinatura',
        );
        await tester.enterText(
          find.byKey(const Key('schedule-amount')),
          '50,00',
        );
        final category = find.byKey(
          const ValueKey('schedule-category-expense'),
        );
        await tester.ensureVisible(category);
        await tester.tap(category);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Alimentação').last);
        await tester.pumpAndSettle();
        final count = find.byKey(const Key('recurrence-count'));
        await tester.ensureVisible(count);
        await tester.enterText(count, '3');
        await tester.ensureVisible(find.byKey(const Key('submit-form')));
        await tester.tap(find.byKey(const Key('submit-form')));
        await tester.pumpAndSettle();
        expect((await schedule.read()).pending, hasLength(3));
        expect((await repo.read()).balance.cents, 100000);
        final pay = find.text('Confirmar pagamento').first;
        await tester.ensureVisible(pay);
        await tester.tap(pay);
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.byKey(const Key('submit-form')));
        await tester.tap(find.byKey(const Key('submit-form')));
        await tester.pumpAndSettle();
        expect((await schedule.read()).pending, hasLength(2));
        expect((await repo.read()).balance.cents, 95000);
        expect((await repo.read()).expenseIn(clock.today).cents, 5000);
        await tester.pumpWidget(const SizedBox());
        await tester.pumpAndSettle();
      },
    );
  }
}
