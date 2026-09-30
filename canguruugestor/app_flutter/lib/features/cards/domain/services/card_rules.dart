import '../../../../core/civil_date.dart';
import '../../../../core/failure.dart';
import '../../../../core/money.dart';

enum ClosingPolicy { next, current }

final class BillingCycle {
  const BillingCycle(this.closingOn, this.dueOn);
  final CivilDate closingOn;
  final CivilDate dueOn;
}

abstract final class CardRules {
  static void days(int closingDay, int dueDay) {
    if (closingDay < 1 || closingDay > 31 || dueDay < 1 || dueDay > 31) {
      throw const FinanceFailure('invalid_cycle', 'Informe dias entre 1 e 31.');
    }
  }

  static List<Money> installments(Money total, int count) {
    if (total.cents <= 0 || count < 1 || count > 360 || count > total.cents) {
      throw const FinanceFailure(
        'invalid_installments',
        'Informe um total positivo e de 1 a 360 parcelas, sem parcelas de zero centavo.',
      );
    }
    // BigInt also keeps division exact when compiled to JavaScript.
    final value = BigInt.from(total.cents);
    final base = (value ~/ BigInt.from(count)).toInt();
    final remainder = (value % BigInt.from(count)).toInt();
    return List.unmodifiable(
      List.generate(count, (i) => Money(base + (i < remainder ? 1 : 0))),
    );
  }

  static BillingCycle cycle(CivilDate month, int closingDay, int dueDay) {
    days(closingDay, dueDay);
    final closing = month.monthStart.inMonth(0, preferredDay: closingDay);
    var due = month.monthStart.inMonth(0, preferredDay: dueDay);
    if (!due.isAfter(closing)) {
      due = month.monthStart.inMonth(1, preferredDay: dueDay);
    }
    return BillingCycle(closing, due);
  }

  static List<BillingCycle> schedule(
    CivilDate billingOn,
    int count,
    int closingDay,
    int dueDay,
    ClosingPolicy policy,
  ) {
    days(closingDay, dueDay);
    if (count < 1 || count > 360) {
      throw const FinanceFailure(
        'invalid_installments',
        'Quantidade de parcelas inválida.',
      );
    }
    var month = billingOn.monthStart;
    final first = cycle(month, closingDay, dueDay);
    if (first.closingOn.isBefore(billingOn) ||
        (first.closingOn == billingOn && policy == ClosingPolicy.next)) {
      month = month.inMonth(1);
    }
    return List.unmodifiable(
      List.generate(count, (i) => cycle(month.inMonth(i), closingDay, dueDay)),
    );
  }
}
