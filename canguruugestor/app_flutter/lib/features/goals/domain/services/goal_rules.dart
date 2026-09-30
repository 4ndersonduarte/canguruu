import '../../../../core/money.dart';
import '../../../../core/failure.dart';

abstract final class GoalRules {
  /// Largest remainders with BigInt intermediates and a stable goal-ID tie break.
  static Map<String, Money> coverage(Money balance, Map<String, Money> reserves) {
    if(reserves.values.any((m) => m.cents < 0)) {
      throw const FinanceFailure('invalid_reserve', 'A reserva não pode ficar negativa.');
    }
    final total = Money.sum(reserves.values).cents;
    if(total == 0) return {for(final id in reserves.keys) id: Money.zero};
    final available = balance.cents.clamp(0, total);
    final denominator = BigInt.from(total);
    final result = <String, Money>{};
    final remainders = <(String, BigInt)>[];
    var assigned = 0;
    for(final e in reserves.entries) {
      final product = BigInt.from(available) * BigInt.from(e.value.cents);
      final cents = (product ~/ denominator).toInt();
      result[e.key] = Money(cents);
      assigned += cents;
      remainders.add((e.key, product % denominator));
    }
    remainders.sort((a,b) {final c=b.$2.compareTo(a.$2); return c != 0 ? c : a.$1.compareTo(b.$1);});
    for(var n=0; n<available-assigned; n++) {
      final id = remainders[n].$1;
      result[id] = result[id]! + Money(1);
    }
    return result;
  }
}
