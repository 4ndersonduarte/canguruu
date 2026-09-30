import 'failure.dart';

/// Exact signed BRL cents, safe on Dart VM and JavaScript.
final class Money implements Comparable<Money> {
  const Money._(this.cents);
  static const maxCents = 9007199254740991;
  static const zero = Money._(0);
  final int cents;

  factory Money(int cents) {
    if (cents.abs() > maxCents) {
      throw const FinanceFailure(
        'amount_overflow',
        'O valor excede o limite suportado.',
      );
    }
    return Money._(cents);
  }

  factory Money.parse(String text) {
    final input = text.trim().replaceFirst(RegExp(r'^R\$\s*'), '');
    if (!RegExp(
      r'^-?(?:\d+|\d{1,3}(?:\.\d{3})+)(?:,\d{1,2})?$',
    ).hasMatch(input)) {
      throw const FinanceFailure(
        'invalid_amount',
        'Informe um valor como 1.234,56.',
      );
    }
    final negative = input.startsWith('-');
    final parts = input.replaceAll('-', '').replaceAll('.', '').split(',');
    final value =
        BigInt.parse(parts[0]) * BigInt.from(100) +
        BigInt.parse(parts.length == 1 ? '0' : parts[1].padRight(2, '0'));
    return _fromBigInt(negative ? -value : value);
  }

  static Money _fromBigInt(BigInt value) {
    if (value.abs() > BigInt.from(maxCents)) {
      throw const FinanceFailure(
        'amount_overflow',
        'O valor excede o limite suportado.',
      );
    }
    return Money(value.toInt());
  }

  static Money sum(Iterable<Money> values) => _fromBigInt(
    values.fold(BigInt.zero, (sum, value) => sum + BigInt.from(value.cents)),
  );

  Money operator +(Money other) => sum([this, other]);
  Money operator -(Money other) => sum([this, Money(-other.cents)]);
  Money get abs => Money(cents.abs());
  @override
  int compareTo(Money other) => cents.compareTo(other.cents);
  @override
  bool operator ==(Object other) => other is Money && other.cents == cents;
  @override
  int get hashCode => cents.hashCode;
}
