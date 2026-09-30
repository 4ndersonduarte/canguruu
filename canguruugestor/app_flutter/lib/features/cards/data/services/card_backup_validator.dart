import '../../../../core/civil_date.dart';
import '../../../../core/failure.dart';
import '../../../../core/money.dart';
import '../../domain/services/card_rules.dart';

typedef _Row = Map<String, Object?>;

/// Validates cross-table card invariants before a backup can replace live data.
final class CardBackupValidator {
  CardBackupValidator(this.clock);
  final Clock clock;
  Never _invalid() => throw const FinanceFailure(
    'invalid_backup',
    'Cartões ou faturas inconsistentes na cópia.',
  );
  void validate(Map<String, List<Map<String, Object?>>> data) {
    Map<String, _Row> index(String table) {
      final rows = data[table]!;
      final result = {for (final row in rows) row['id'] as String: row};
      if (result.length != rows.length) _invalid();
      return result;
    }

    final cards = index('credit_cards');
    final ledgers = index('ledger_accounts');
    final accounts = index('accounts');
    final events = index('financial_events');
    final categories = index('categories');
    final operations = index('card_operations');
    final invoices = index('invoices');
    final payments = index('invoice_payments');
    index('invoice_items');
    index('invoice_payment_allocations');
    final postings = <Object?, List<_Row>>{};
    for (final p in data['postings']!) {
      (postings[p['event_id']] ??= []).add(p);
    }
    for (final card in cards.values) {
      if (ledgers[card['id']]?['kind'] != 'liability' ||
          accounts.containsKey(card['id'])) {
        _invalid();
      }
      CardRules.days(card['closing_day'] as int, card['due_day'] as int);
      if ((card['limit_cents'] as int) < 0 ||
          CivilDate.parse(card['opened_on'] as String).isAfter(clock.today)) {
        _invalid();
      }
    }
    for (final invoice in invoices.values) {
      final card = cards[invoice['card_id']];
      if (card == null) _invalid();
      final close = CivilDate.parse(invoice['closing_on'] as String);
      final due = CivilDate.parse(invoice['due_on'] as String);
      final cycle = CardRules.cycle(
        close.monthStart,
        card['closing_day'] as int,
        card['due_day'] as int,
      );
      if (close != cycle.closingOn || due != cycle.dueOn) _invalid();
      if (!data['invoice_items']!.any(
        (i) => i['invoice_id'] == invoice['id'],
      )) {
        _invalid();
      }
    }
    final initial = <Object?>{};
    final invoiceTimeline = <Object?, Map<CivilDate, List<Money>>>{};
    void add(Object? invoice, CivilDate date, int amount) {
      ((invoiceTimeline[invoice] ??= {})[date] ??= []).add(Money(amount));
    }

    for (final operation in operations.values) {
      final event = events[operation['id']];
      final card = cards[operation['card_id']];
      if (event == null || card == null) _invalid();
      final opening = operation['kind'] == 'opening_debt';
      if (!['opening_debt', 'purchase'].contains(operation['kind']) ||
          event['kind'] != (opening ? 'card_opening' : 'card_purchase')) {
        _invalid();
      }
      final date = CivilDate.parse(event['effective_date'] as String);
      final billing = CivilDate.parse(operation['billing_on'] as String);
      if (date.isBefore(CivilDate.parse(card['opened_on'] as String)) ||
          billing.isBefore(date) ||
          billing.isAfter(clock.today)) {
        _invalid();
      }
      if (opening &&
          (!initial.add(card['id']) ||
              card['opened_on'] != event['effective_date'] ||
              operation['installment_count'] != 1 ||
              operation['reconciled'] != 1 ||
              billing != date)) {
        _invalid();
      }
      final entries = postings[event['id']] ?? [];
      if (entries.length != 2) _invalid();
      final liability = entries
          .where((p) => p['ledger_account_id'] == card['id'])
          .firstOrNull;
      final other = entries
          .where(
            (p) =>
                p['ledger_account_id'] ==
                (opening ? 'system-equity' : 'system-expense'),
          )
          .firstOrNull;
      if (liability == null ||
          other == null ||
          liability['amount_cents'] != -(operation['total_cents'] as int) ||
          other['amount_cents'] != operation['total_cents'] ||
          liability['category_id'] != null ||
          liability['cost_nature'] != null ||
          liability['essential'] != null) {
        _invalid();
      }
      if (opening) {
        if (other['category_id'] != null ||
            other['cost_nature'] != null ||
            other['essential'] != null) {
          _invalid();
        }
      } else if (categories[other['category_id']]?['kind'] != 'expense' ||
          other['cost_nature'] == null ||
          other['essential'] == null) {
        _invalid();
      }
      final count = operation['installment_count'] as int;
      final values = CardRules.installments(
        Money(operation['total_cents'] as int),
        count,
      );
      final cycles = CardRules.schedule(
        billing,
        count,
        card['closing_day'] as int,
        card['due_day'] as int,
        ClosingPolicy.values.byName(card['closing_policy'] as String),
      );
      final items =
          data['invoice_items']!
              .where((i) => i['operation_id'] == operation['id'])
              .toList()
            ..sort(
              (a, b) => (a['sequence'] as int).compareTo(b['sequence'] as int),
            );
      if (items.length != count) _invalid();
      for (var i = 0; i < count; i++) {
        final item = items[i];
        final invoice = invoices[item['invoice_id']];
        if (item['sequence'] != i + 1 ||
            item['amount_cents'] != values[i].cents ||
            invoice == null ||
            invoice['card_id'] != card['id'] ||
            invoice['closing_on'] != '${cycles[i].closingOn}' ||
            invoice['due_on'] != '${cycles[i].dueOn}') {
          _invalid();
        }
        add(invoice['id'], date, values[i].cents);
      }
    }
    for (final payment in payments.values) {
      final event = events[payment['id']];
      if (event == null ||
          event['kind'] != 'card_payment' ||
          !cards.containsKey(payment['card_id']) ||
          !accounts.containsKey(payment['account_id'])) {
        _invalid();
      }
      final entries = postings[payment['id']] ?? [];
      if (entries.length != 2 ||
          entries.any(
            (p) =>
                p['category_id'] != null ||
                p['cost_nature'] != null ||
                p['essential'] != null,
          )) {
        _invalid();
      }
      final liability = entries
          .where((p) => p['ledger_account_id'] == payment['card_id'])
          .firstOrNull;
      final asset = entries
          .where((p) => p['ledger_account_id'] == payment['account_id'])
          .firstOrNull;
      if (liability == null ||
          asset == null ||
          liability['amount_cents'] != payment['amount_cents'] ||
          asset['amount_cents'] != -(payment['amount_cents'] as int)) {
        _invalid();
      }
      final allocations = data['invoice_payment_allocations']!
          .where((a) => a['payment_id'] == payment['id'])
          .toList();
      if (allocations.isEmpty ||
          Money.sum(
                allocations.map((a) => Money(a['amount_cents'] as int)),
              ).cents !=
              payment['amount_cents']) {
        _invalid();
      }
      for (final allocation in allocations) {
        final invoice = invoices[allocation['invoice_id']];
        if (invoice == null || invoice['card_id'] != payment['card_id']) {
          _invalid();
        }
        add(
          invoice['id'],
          CivilDate.parse(event['effective_date'] as String),
          -(allocation['amount_cents'] as int),
        );
      }
    }
    for (final event in events.values) {
      if (['card_opening', 'card_purchase'].contains(event['kind']) &&
              !operations.containsKey(event['id']) ||
          event['kind'] == 'card_payment' &&
              !payments.containsKey(event['id'])) {
        _invalid();
      }
    }
    final invoiceBalances = <Object?, Money>{};
    for (final entry in invoiceTimeline.entries) {
      var balance = Money.zero;
      final days = entry.value.keys.toList()..sort();
      for (final day in days) {
        balance += Money.sum(entry.value[day]!);
        if (balance.cents < 0) _invalid();
      }
      invoiceBalances[entry.key] = balance;
    }
    final debts = <Money>[];
    for (final card in cards.values) {
      final debt = Money(
        -Money.sum(
          data['postings']!
              .where((p) => p['ledger_account_id'] == card['id'])
              .map((p) => Money(p['amount_cents'] as int)),
        ).cents,
      );
      final billed = Money.sum(
        invoices.values
            .where((i) => i['card_id'] == card['id'])
            .map((i) => invoiceBalances[i['id']] ?? Money.zero),
      );
      if (debt != billed) _invalid();
      debts.add(debt);
    }
    final assets = Money.sum(
      data['postings']!
          .where((p) => accounts.containsKey(p['ledger_account_id']))
          .map((p) => Money(p['amount_cents'] as int)),
    );
    assets - Money.sum(debts);
  }
}
