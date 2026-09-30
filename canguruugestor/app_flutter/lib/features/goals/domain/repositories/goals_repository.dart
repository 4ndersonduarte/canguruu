import '../../../../core/civil_date.dart';
import '../../../../core/money.dart';
import '../models.dart';

abstract interface class GoalsRepository {
  Stream<GoalsSnapshot> watch();
  Future<GoalsSnapshot> read();
  Future<String> saveObjective({required String requestId, required String title,
    String? id, int? revision, ObjectiveStatus status = ObjectiveStatus.active});
  Future<String> saveGoal({required String requestId, required String title, required Money target,
    required GoalPurpose purpose, required int priority, String? objectiveId, CivilDate? targetOn,
    String? id, int? revision});
  Future<String> moveFunds({required String requestId, required String goalId,
    required String accountId, required Money amount});
  Future<String> setStatus({required String requestId, required String goalId,
    required int revision, required GoalStatus status});
}
