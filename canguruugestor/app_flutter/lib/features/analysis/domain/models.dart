import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import '../../finance/domain/models.dart';
import '../../schedule/domain/models.dart';

enum AnalysisConfidence { low, medium, high }

final class Recommendation {
  const Recommendation({required this.decision, required this.explanation, required this.confidence, required this.impact, required this.factors});
  final String decision, explanation;
  final AnalysisConfidence confidence;
  final Money impact;
  final List<String> factors;
}

final class CategorySpend {
  const CategorySpend(this.categoryId, this.amount, this.share);
  final String categoryId;
  final Money amount;
  final double share;
}

final class CashProjection {
  const CashProjection({required this.days, required this.balance});
  final int days;
  final Money balance;
}

final class FinancialAnalysis {
  const FinancialAnalysis({required this.month, required this.income, required this.expense, required this.savings, required this.savingsRate, required this.fixedExpense, required this.variableExpense, required this.commitmentRate, required this.netWorth, required this.averageDailyExpense, required this.categorySpend, required this.projections, required this.recommendations});
  final CivilDate month;
  final Money income, expense, savings, fixedExpense, variableExpense, netWorth;
  final double savingsRate, commitmentRate;
  final Money averageDailyExpense;
  final List<CategorySpend> categorySpend;
  final List<CashProjection> projections;
  final List<Recommendation> recommendations;

  static FinancialAnalysis calculate({required FinanceSnapshot finance, ScheduleSnapshot? schedule, CivilDate? month}) {
    final selected = month ?? finance.asOf.monthStart;
    final income = finance.incomeIn(selected);
    final expense = finance.expenseIn(selected);
    final savings = income - expense;
    final byCategory = <String, int>{};
    var fixed = 0;
    var variable = 0;
    for (final event in finance.events.where((e) => e.date.monthStart == selected && e.kind == 'expense')) {
      for (final entry in event.entries.where((e) => e.accountId == 'system-expense' && e.categoryId != null)) {
        byCategory[entry.categoryId!] = (byCategory[entry.categoryId!] ?? 0) + entry.cents;
        if (entry.costNature == CostNature.fixed) {
          fixed += entry.cents;
        } else {
          variable += entry.cents;
        }
      }
    }
    final total = byCategory.values.fold<int>(0, (a, b) => a + b);
    final categories = byCategory.entries.where((e) => e.value > 0).map((e) => CategorySpend(e.key, Money(e.value), total == 0 ? 0 : e.value / total)).toList()..sort((a, b) => b.amount.cents.compareTo(a.amount.cents));
    final days = selected == finance.asOf.monthStart ? finance.asOf.day : 30;
    final scheduledExpense = schedule?.expectedIn(30, ScheduleKind.expense) ?? Money.zero;
    final scheduledIncome = schedule?.expectedIn(30, ScheduleKind.income) ?? Money.zero;
    final projections = [for (final daysAhead in const [7, 30, 90]) CashProjection(days: daysAhead, balance: finance.balance + (schedule == null ? Money.zero : schedule.expectedIn(daysAhead, ScheduleKind.income) - schedule.expectedIn(daysAhead, ScheduleKind.expense)))];
    final recommendations = <Recommendation>[];
    if (expense.cents > income.cents && expense.cents > 0) {
      recommendations.add(Recommendation(decision: 'Reduza as saídas deste mês', explanation: 'As despesas já superam as receitas registradas.', confidence: AnalysisConfidence.high, impact: savings, factors: ['Receitas: ${income.cents}', 'Despesas: ${expense.cents}']));
    } else if (income.cents > 0 && savings.cents > 0) {
      recommendations.add(Recommendation(decision: 'Você está no ritmo para economizar', explanation: 'Mantendo este padrão, sua economia mensal permanece positiva.', confidence: AnalysisConfidence.medium, impact: savings, factors: ['Economia: ${savings.cents}', 'Taxa: ${(savings.cents * 100 / income.cents).round()}%']));
    }
    if (scheduledExpense.cents > scheduledIncome.cents && finance.balance.cents > 0) {
      recommendations.add(Recommendation(decision: 'Atenção às contas previstas', explanation: 'As despesas agendadas dos próximos 30 dias superam as entradas previstas.', confidence: AnalysisConfidence.medium, impact: scheduledIncome - scheduledExpense, factors: ['Saídas previstas: ${scheduledExpense.cents}', 'Entradas previstas: ${scheduledIncome.cents}']));
    }
    return FinancialAnalysis(month: selected, income: income, expense: expense, savings: savings, savingsRate: income.cents == 0 ? 0 : savings.cents / income.cents, fixedExpense: Money(fixed), variableExpense: Money(variable), commitmentRate: income.cents == 0 ? 0 : (expense.cents + scheduledExpense.cents) / income.cents, netWorth: finance.netWorth, averageDailyExpense: days == 0 ? Money.zero : Money(expense.cents ~/ days), categorySpend: categories, projections: projections, recommendations: recommendations);
  }
}
