import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import 'services/card_rules.dart';

final class CreditCard {
  const CreditCard({
    required this.id,
    required this.name,
    required this.openedOn,
    required this.totalLimit,
    required this.debt,
    required this.closingDay,
    required this.dueDay,
    required this.policy,
  });
  final String id, name;
  final CivilDate openedOn;
  final Money totalLimit, debt;
  final int closingDay, dueDay;
  final ClosingPolicy policy;
  Money get used => Money(debt.cents <= 0 ? 0 : debt.cents);
  Money get available =>
      Money((totalLimit.cents - used.cents).clamp(0, Money.maxCents));
  Money get excess =>
      Money((used.cents - totalLimit.cents).clamp(0, Money.maxCents));
  Money get credit => Money(debt.cents < 0 ? -debt.cents : 0);
  double? get utilization =>
      totalLimit.cents == 0 ? null : used.cents / totalLimit.cents;
}

final class CardOperation {
  const CardOperation({
    required this.id,
    required this.cardId,
    required this.description,
    required this.date,
    required this.billingOn,
    required this.total,
    required this.count,
    required this.openingDebt,
    required this.reconciled,
  });
  final String id, cardId, description;
  final CivilDate date, billingOn;
  final Money total;
  final int count;
  final bool openingDebt, reconciled;
}

final class InvoiceItem {
  const InvoiceItem({
    required this.id,
    required this.operation,
    required this.sequence,
    required this.amount,
  });
  final String id;
  final CardOperation operation;
  final int sequence;
  final Money amount;
}

final class InvoicePayment {
  const InvoicePayment({
    required this.id,
    required this.date,
    required this.accountId,
    required this.amount,
  });
  final String id, accountId;
  final CivilDate date;
  final Money amount;
}

final class CardInvoice {
  CardInvoice({
    required this.id,
    required this.cardId,
    required this.closingOn,
    required this.dueOn,
    required List<InvoiceItem> items,
    required List<InvoicePayment> payments,
  }) : items = List.unmodifiable(items),
       payments = List.unmodifiable(payments);
  final String id, cardId;
  final CivilDate closingOn, dueOn;
  final List<InvoiceItem> items;
  final List<InvoicePayment> payments;
  Money get total => Money.sum(items.map((i) => i.amount));
  Money get paid => Money.sum(payments.map((p) => p.amount));
  Money get balance => total - paid;
  Money availableForPayment(CivilDate date) {
    Money balanceAt(CivilDate day) =>
        Money.sum(
          items
              .where((i) => !i.operation.date.isAfter(day))
              .map((i) => i.amount),
        ) -
        Money.sum(
          payments.where((p) => !p.date.isAfter(day)).map((p) => p.amount),
        );
    var minimum = balanceAt(date);
    final laterDates = {
      ...items.map((i) => i.operation.date),
      ...payments.map((p) => p.date),
    }.where((day) => day.isAfter(date));
    for (final day in laterDates) {
      final value = balanceAt(day);
      if (value.cents < minimum.cents) minimum = value;
    }
    return minimum;
  }

  bool closed(CivilDate asOf) => asOf.isAfter(closingOn);
  bool overdue(CivilDate asOf) => balance.cents > 0 && asOf.isAfter(dueOn);
  String settlement(CivilDate asOf) => balance.cents == 0
      ? (closed(asOf) ? 'Quitada' : 'Sem saldo em aberto')
      : paid.cents > 0
      ? 'Pagamento parcial'
      : 'A pagar';

  /// Internal allocation policy v1: oldest billing date, sequence, stable ID.
  /// It does not assert how the bank distributed the payment.
  Map<String, Money> get remainingByItem {
    final ordered = [...items]
      ..sort((a, b) {
        final date = a.operation.billingOn.compareTo(b.operation.billingOn);
        if (date != 0) return date;
        final sequence = a.sequence.compareTo(b.sequence);
        return sequence != 0 ? sequence : a.id.compareTo(b.id);
      });
    var resources = paid.cents;
    return {
      for (final item in ordered)
        item.id: (() {
          final applied = resources.clamp(0, item.amount.cents);
          resources -= applied;
          return Money(item.amount.cents - applied);
        })(),
    };
  }
}

final class CardsSnapshot {
  CardsSnapshot({
    required List<CreditCard> cards,
    required List<CardOperation> operations,
    required List<CardInvoice> invoices,
    required this.asOf,
  }) : cards = List.unmodifiable(cards),
       operations = List.unmodifiable(operations),
       invoices = List.unmodifiable(invoices);
  final List<CreditCard> cards;
  final List<CardOperation> operations;
  final List<CardInvoice> invoices;
  final CivilDate asOf;
  Money get debt => Money.sum(cards.map((c) => c.debt));
  Money get installmentCommitment => Money.sum(
    invoices.expand((invoice) {
      final remaining = invoice.remainingByItem;
      return invoice.items
          .where((item) => item.operation.count > 1)
          .map((item) => remaining[item.id]!);
    }),
  );
}
