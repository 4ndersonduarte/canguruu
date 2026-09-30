import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/core/failure.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/features/goals/domain/services/goal_rules.dart';

void main() {
  test('distribui a cobertura proporcionalmente e desempata pelo id', () {
    final result = GoalRules.coverage(
      Money(1),
      {'a': Money(1), 'b': Money(1)},
    );

    expect(result['a']!.cents, 1);
    expect(result['b']!.cents, 0);
    expect(Money.sum(result.values).cents, 1);
  });

  test('limita a cobertura ao saldo disponível', () {
    final result = GoalRules.coverage(
      Money(500),
      {'reserve': Money(1000)},
    );

    expect(result['reserve']!.cents, 500);
  });

  test('recusa reservas negativas', () {
    expect(
      () => GoalRules.coverage(Money(100), {'reserve': Money(-1)}),
      throwsA(isA<FinanceFailure>()),
    );
  });
}