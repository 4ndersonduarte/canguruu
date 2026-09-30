import '../../../../core/civil_date.dart';
import '../../../../core/failure.dart';
import '../../../../core/money.dart';
import '../models.dart';

final class LedgerRules {
  static String name(String value, {int max = 80}) {
    final normalized = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (normalized.isEmpty || normalized.length > max) {
      throw FinanceFailure('invalid_name', 'Use entre 1 e $max caracteres.');
    }
    return normalized;
  }

  static void effectiveDate(CivilDate date, Clock clock) {
    if (date.isAfter(clock.today)) {
      throw const FinanceFailure(
        'future_date',
        'Use uma data até hoje para valores realizados. Para datas futuras, crie uma previsão na Agenda.',
      );
    }
  }

  static List<LedgerEntry> movement({
    required MovementKind kind,
    required Money amount,
    required Account source,
    Account? destination,
    Category? category,
    required CivilDate date,
  }) {
    if (amount.cents <= 0) {
      throw const FinanceFailure(
        'invalid_amount',
        'O valor deve ser maior que zero.',
      );
    }
    for (final account in [source, if (destination != null) destination]) {
      if (account.archived || date.isBefore(account.openedOn)) {
        throw const FinanceFailure(
          'invalid_account',
          'A conta deve estar ativa e a data deve ser igual ou posterior ao saldo inicial.',
        );
      }
    }
    if (kind == MovementKind.transfer) {
      if (destination == null ||
          destination.id == source.id ||
          category != null) {
        throw const FinanceFailure(
          'invalid_transfer',
          'Escolha duas contas diferentes para transferir.',
        );
      }
      return [
        LedgerEntry(accountId: source.id, cents: -amount.cents),
        LedgerEntry(accountId: destination.id, cents: amount.cents),
      ];
    }
    if (destination != null ||
        category == null ||
        category.archived ||
        category.kind != kind) {
      throw const FinanceFailure(
        'invalid_category',
        'Escolha uma categoria válida para esta movimentação.',
      );
    }
    final expense = kind == MovementKind.expense;
    return [
      LedgerEntry(
        accountId: source.id,
        cents: expense ? -amount.cents : amount.cents,
      ),
      LedgerEntry(
        accountId: expense ? 'system-expense' : 'system-income',
        cents: expense ? amount.cents : -amount.cents,
        categoryId: category.id,
        costNature: expense ? category.costNature : null,
        essential: expense ? category.essential : null,
      ),
    ];
  }

  static void balanced(List<LedgerEntry> entries) {
    if (entries.length != 2 ||
        entries.any((e) => e.cents == 0) ||
        entries[0].accountId == entries[1].accountId ||
        Money.sum(entries.map((e) => Money(e.cents))).cents != 0) {
      throw const FinanceFailure(
        'unbalanced_event',
        'A operação financeira está inconsistente.',
      );
    }
  }
}
