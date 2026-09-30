import '../../../../core/civil_date.dart';
import '../../../../core/money.dart';
import '../models.dart';
import '../repositories/finance_repository.dart';
import '../services/ledger_rules.dart';

/// Presentation calls intentions; persistence remains behind the repository port.
final class FinanceActions {
  const FinanceActions(this.repository, this.clock);
  final FinanceRepository repository;
  final Clock clock;
  Future<String> createAccount({
    required String requestId,
    required String name,
    required AccountKind kind,
    required Money openingBalance,
    required CivilDate openedOn,
  }) {
    LedgerRules.effectiveDate(openedOn, clock);
    return repository.createAccount(
      requestId: requestId,
      name: LedgerRules.name(name),
      kind: kind,
      openingBalance: openingBalance,
      openedOn: openedOn,
    );
  }

  Future<String> record({
    required String requestId,
    required MovementKind kind,
    required Money amount,
    required CivilDate date,
    required String description,
    required String accountId,
    String? destinationId,
    String? categoryId,
  }) {
    LedgerRules.effectiveDate(date, clock);
    return repository.record(
      requestId: requestId,
      kind: kind,
      amount: amount,
      date: date,
      description: LedgerRules.name(description, max: 160),
      accountId: accountId,
      destinationId: destinationId,
      categoryId: categoryId,
    );
  }
}
