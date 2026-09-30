import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import '../../finance/domain/models.dart';
import 'services/goal_rules.dart';

enum GoalPurpose { emergency, purchase, general }
enum GoalStatus { active, paused, fulfilled, archived }
enum ObjectiveStatus { active, completed, archived }

final class Objective {
  const Objective({required this.id, required this.title, required this.status, required this.revision});
  final String id, title;
  final ObjectiveStatus status;
  final int revision;
}
final class FinancialGoal {
  const FinancialGoal({required this.id, required this.title, required this.target,
    required this.purpose, required this.status, required this.priority, required this.revision,
    this.objectiveId, this.targetOn, this.fulfilledOn, this.fulfilledAmount});
  final String id, title;
  final String? objectiveId;
  final Money target;
  final GoalPurpose purpose;
  final GoalStatus status;
  final int priority, revision;
  final CivilDate? targetOn, fulfilledOn;
  final Money? fulfilledAmount;
  bool get closed => status == GoalStatus.fulfilled || status == GoalStatus.archived;
}
final class GoalFundMovement {
  const GoalFundMovement({required this.id, required this.goalId, required this.accountId,
    required this.amount, required this.date, required this.sequence});
  final String id, goalId, accountId;
  final Money amount;
  final CivilDate date;
  final int sequence;
}
final class GoalProgress {
  const GoalProgress(this.goal, this.nominal, this.covered);
  final FinancialGoal goal;
  final Money nominal, covered;
  Money get deficit => nominal - covered;
  Money get remaining => Money((goal.target.cents - covered.cents).clamp(0, Money.maxCents));
  Money get excess => Money((covered.cents - goal.target.cents).clamp(0, Money.maxCents));
  double get ratio => (covered.cents / goal.target.cents).clamp(0, 1);
}
final class GoalsSnapshot {
  GoalsSnapshot({required List<Objective> objectives, required List<FinancialGoal> goals,
    required List<GoalFundMovement> movements, required this.finance})
    : objectives = List.unmodifiable(objectives), goals = List.unmodifiable(goals),
      movements = List.unmodifiable(movements);
  final List<Objective> objectives;
  final List<FinancialGoal> goals;
  final List<GoalFundMovement> movements;
  final FinanceSnapshot finance;
  Map<String, Money> reservedIn(String accountId) {
    final values = <String, List<Money>>{};
    for(final m in movements.where((m) => m.accountId == accountId)) {
      (values[m.goalId] ??= []).add(m.amount);
    }
    return {for(final e in values.entries) e.key: Money.sum(e.value)};
  }
  Money freeIn(String accountId) {
    final account = finance.accounts.firstWhere((a) => a.id == accountId);
    final nominal = Money.sum(reservedIn(accountId).values);
    return Money((account.balance.cents - nominal.cents).clamp(0, Money.maxCents));
  }
  List<GoalProgress> get progress {
    final nominal = <String, List<Money>>{}, covered = <String, List<Money>>{};
    for (final a in finance.accounts) {
      final reserves = reservedIn(a.id);
      final allocated = GoalRules.coverage(a.balance, reserves);
      for(final e in reserves.entries) { (nominal[e.key] ??= []).add(e.value); }
      for(final e in allocated.entries) { (covered[e.key] ??= []).add(e.value); }
    }
    return [for(final g in goals) GoalProgress(g, Money.sum(nominal[g.id] ?? []), Money.sum(covered[g.id] ?? []))];
  }
  Money get reserved => Money.sum(progress.map((g) => g.nominal));
  Money get covered => Money.sum(progress.map((g) => g.covered));
  Money get free => Money.sum(finance.accounts.map((a) => freeIn(a.id)));
}
