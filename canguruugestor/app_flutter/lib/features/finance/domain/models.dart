import '../../../core/civil_date.dart';
import '../../../core/money.dart';

enum AccountKind { bank, wallet }

enum MovementKind { income, expense, transfer }

enum CostNature { fixed, variable }

final class Account {
  const Account({
    required this.id,
    required this.name,
    required this.kind,
    required this.openedOn,
    required this.balance,
    this.archived = false,
  });
  final String id;
  final String name;
  final AccountKind kind;
  final CivilDate openedOn;
  final Money balance;
  final bool archived;
}

final class Category {
  const Category({
    required this.id,
    required this.name,
    required this.kind,
    this.parentId,
    this.costNature = CostNature.variable,
    this.essential = false,
    this.archived = false,
  });
  final String id;
  final String name;
  final MovementKind kind;
  final String? parentId;
  final CostNature costNature;
  final bool essential;
  final bool archived;
}

final class LedgerEntry {
  const LedgerEntry({
    required this.accountId,
    required this.cents,
    this.categoryId,
    this.costNature,
    this.essential,
  });
  final String accountId;
  final int cents;
  final String? categoryId;
  final CostNature? costNature;
  final bool? essential;
}

final class FinancialEvent {
  const FinancialEvent({
    required this.id,
    required this.kind,
    required this.date,
    required this.description,
    required this.entries,
    this.reversalOf,
    this.reversed = false,
  });
  final String id;
  final String kind;
  final CivilDate date;
  final String description;
  final List<LedgerEntry> entries;
  final String? reversalOf;
  final bool reversed;

  Money get amount =>
      Money.sum(entries.where((e) => e.cents > 0).map((e) => Money(e.cents)));
}

final class FinanceSnapshot {
  FinanceSnapshot({
    required List<Account> accounts,
    required List<Category> categories,
    required List<FinancialEvent> events,
    required this.asOf,
    Map<String, Money> cardDebts = const {},
    Map<String, String> cardNames = const {},
  }) : accounts = List.unmodifiable(accounts),
       categories = List.unmodifiable(categories),
       events = List.unmodifiable(events),
       cardDebts = Map.unmodifiable(cardDebts),
       cardNames = Map.unmodifiable(cardNames);
  final List<Account> accounts;
  final List<Category> categories;
  final List<FinancialEvent> events;
  final CivilDate asOf;
  final Map<String, Money> cardDebts;
  final Map<String, String> cardNames;
  Money get cardDebt => Money.sum(cardDebts.values);
  Money get netWorth => balance - cardDebt;
  List<Account> get activeAccounts =>
      accounts.where((a) => !a.archived).toList();
  Money get balance => Money.sum(accounts.map((a) => a.balance));
  Money incomeIn(CivilDate month) => _flow(month, 'system-income', -1);
  Money expenseIn(CivilDate month) => _flow(month, 'system-expense', 1);
  Money _flow(CivilDate month, String ledgerId, int sign) => Money.sum(
    events
        .where((e) => e.date.year == month.year && e.date.month == month.month)
        .expand((e) => e.entries)
        .where((p) => p.accountId == ledgerId)
        .map((p) => Money(p.cents * sign)),
  );
  Money balanceOn(CivilDate date) {
    final ids = accounts.map((a) => a.id).toSet();
    return Money.sum(
      events
          .where((e) => !e.date.isAfter(date))
          .expand((e) => e.entries)
          .where((p) => ids.contains(p.accountId))
          .map((p) => Money(p.cents)),
    );
  }

  String accountName(String id) =>
      accounts.where((a) => a.id == id).map((a) => a.name).firstOrNull ??
      'Conta';
  String categoryName(String id) {
    final category = categories.where((c) => c.id == id).firstOrNull;
    if (category == null) return 'Categoria';
    final parent = categories
        .where((c) => c.id == category.parentId)
        .firstOrNull;
    return parent == null ? category.name : '${parent.name} / ${category.name}';
  }
}
