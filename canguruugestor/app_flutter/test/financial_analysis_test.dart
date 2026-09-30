import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/features/analysis/domain/models.dart';
import 'package:canguruu_finance/features/finance/domain/models.dart';

void main() {
  final today = CivilDate(2026, 9, 25);

  test('calcula economia, taxa e gasto por categoria', () {
    final snapshot = FinanceSnapshot(
      accounts: [Account(id: 'a', name: 'Conta', kind: AccountKind.bank, openedOn: today, balance: Money(7000))],
      categories: [Category(id: 'food', name: 'Alimentação', kind: MovementKind.expense)],
      events: [
        FinancialEvent(id: 'in', kind: 'income', date: CivilDate(2026, 9, 2), description: 'Salário', entries: [
          LedgerEntry(accountId: 'system-income', cents: -10000),
          LedgerEntry(accountId: 'a', cents: 10000),
        ]),
        FinancialEvent(id: 'out', kind: 'expense', date: CivilDate(2026, 9, 5), description: 'Mercado', entries: [
          LedgerEntry(accountId: 'a', cents: -3000),
          LedgerEntry(accountId: 'system-expense', cents: 3000, categoryId: 'food', costNature: CostNature.variable),
        ]),
      ],
      asOf: today,
    );

    final result = FinancialAnalysis.calculate(finance: snapshot);
    expect(result.income.cents, 10000);
    expect(result.expense.cents, 3000);
    expect(result.savings.cents, 7000);
    expect(result.savingsRate, closeTo(.7, .001));
    expect(result.categorySpend.single.amount.cents, 3000);
  });

  test('cria recomendação quando as despesas superam as receitas', () {
    final snapshot = FinanceSnapshot(
      accounts: [Account(id: 'a', name: 'Conta', kind: AccountKind.bank, openedOn: today, balance: Money(100))],
      categories: const [],
      events: [
        FinancialEvent(id: 'out', kind: 'expense', date: today, description: 'Saída', entries: [
          LedgerEntry(accountId: 'a', cents: -500),
          LedgerEntry(accountId: 'system-expense', cents: 500),
        ]),
      ],
      asOf: today,
    );

    final result = FinancialAnalysis.calculate(finance: snapshot);
    expect(result.recommendations.single.decision, 'Reduza as saídas deste mês');
    expect(result.recommendations.single.confidence, AnalysisConfidence.high);
  });
}
