import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import '../domain/models.dart';

abstract final class GoalCodec {
  static Objective objective(Map<String,Object?> r) => Objective(
    id:r['id'] as String,title:r['title'] as String,
    status:ObjectiveStatus.values.byName(r['status'] as String),revision:r['revision'] as int);
  static FinancialGoal goal(Map<String,Object?> r) => FinancialGoal(
    id:r['id'] as String,title:r['title'] as String,target:Money(r['target_cents'] as int),
    purpose:GoalPurpose.values.byName(r['purpose'] as String),status:GoalStatus.values.byName(r['status'] as String),
    priority:r['priority'] as int,revision:r['revision'] as int,objectiveId:r['objective_id'] as String?,
    targetOn:r['target_on']==null?null:CivilDate.parse(r['target_on'] as String),
    fulfilledOn:r['fulfilled_on']==null?null:CivilDate.parse(r['fulfilled_on'] as String),
    fulfilledAmount:r['fulfilled_cents']==null?null:Money(r['fulfilled_cents'] as int));
  static GoalFundMovement movement(Map<String,Object?> r) => GoalFundMovement(
    id:r['id'] as String,goalId:r['goal_id'] as String,accountId:r['account_id'] as String,
    amount:Money(r['amount_cents'] as int),date:CivilDate.parse(r['effective_on'] as String),
    sequence:r['sequence_no'] as int);
}
