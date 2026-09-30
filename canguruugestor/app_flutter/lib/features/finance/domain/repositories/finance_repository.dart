import '../../../../core/civil_date.dart';
import '../../../../core/money.dart';
import '../models.dart';

abstract interface class FinanceRepository {
  Future<void> initialize();
  Stream<FinanceSnapshot> watch();
  Future<FinanceSnapshot> read();
  Future<String> createAccount({
    required String requestId,
    required String name,
    required AccountKind kind,
    required Money openingBalance,
    required CivilDate openedOn,
  });
  Future<String> createCategory({
    required String requestId,
    required String name,
    required MovementKind kind,
    String? parentId,
    CostNature costNature = CostNature.variable,
    bool essential = false,
  });
  Future<String> record({
    required String requestId,
    required MovementKind kind,
    required Money amount,
    required CivilDate date,
    required String description,
    required String accountId,
    String? destinationId,
    String? categoryId,
  });
  Future<String> reverse({
    required String requestId,
    required String eventId,
    required CivilDate date,
  });
  Future<void> archiveAccount(String id);
  Future<String> exportBackup();
  Future<BackupSummary> inspectBackup(String content);
  Future<void> restoreBackup(String content);
}

final class BackupSummary {
  const BackupSummary(
    this.accounts,
    this.events,
    this.createdAt, {
    this.cards = 0,
    this.scheduled = 0,
  });
  final int accounts;
  final int events;
  final int cards;
  final int scheduled;
  final DateTime createdAt;
}
