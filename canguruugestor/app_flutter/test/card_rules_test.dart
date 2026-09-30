import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/failure.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/features/cards/domain/models.dart';
import 'package:canguruu_finance/features/cards/domain/services/card_rules.dart';

void main() {
  test('parcelas preservam o total e distribuem o resto nas primeiras', () {
    expect(CardRules.installments(Money(10000), 3).map((m) => m.cents), [
      3334,
      3333,
      3333,
    ]);
    for (final count in [1, 2, 3, 7, 360]) {
      final values = CardRules.installments(Money(Money.maxCents), count);
      expect(Money.sum(values).cents, Money.maxCents);
      expect(values.first.cents - values.last.cents, lessThanOrEqualTo(1));
      expect(values.every((v) => v.cents > 0), isTrue);
    }
  });
  test('recusa total, quantidade e parcela de zero inválidos', () {
    for (final scenario in [(1, 2), (100, 0), (1000, 361), (0, 1), (-10, 1)]) {
      expect(
        () => CardRules.installments(Money(scenario.$1), scenario.$2),
        throwsA(isA<FinanceFailure>()),
      );
    }
  });
  test('antes, no dia e depois do fechamento com política padrão', () {
    final dates = [
      CivilDate(2026, 9, 9),
      CivilDate(2026, 9, 10),
      CivilDate(2026, 9, 11),
    ];
    final closes = [
      CivilDate(2026, 9, 10),
      CivilDate(2026, 10, 10),
      CivilDate(2026, 10, 10),
    ];
    for (var i = 0; i < dates.length; i++) {
      final cycle = CardRules.schedule(
        dates[i],
        1,
        10,
        17,
        ClosingPolicy.next,
      ).single;
      expect(cycle.closingOn, closes[i]);
      expect(cycle.dueOn, CivilDate(2026, closes[i].month, 17));
    }
    expect(
      CardRules.schedule(
        dates[1],
        1,
        10,
        17,
        ClosingPolicy.current,
      ).single.closingOn,
      closes[0],
    );
  });
  test('dia 31 é preservado entre fevereiro e março', () {
    final cycles = CardRules.schedule(
      CivilDate(2026, 1, 2),
      3,
      31,
      5,
      ClosingPolicy.next,
    );
    expect(cycles.map((c) => c.closingOn.toString()), [
      '2026-01-31',
      '2026-02-28',
      '2026-03-31',
    ]);
    expect(cycles.map((c) => c.dueOn.toString()), [
      '2026-02-05',
      '2026-03-05',
      '2026-04-05',
    ]);
    expect(
      CardRules.cycle(CivilDate(2028, 2, 1), 31, 31).closingOn,
      CivilDate(2028, 2, 29),
    );
  });
  test(
    'vencimento é estritamente posterior, inclusive mesmo dia e mudança de ano',
    () {
      final cycle = CardRules.cycle(CivilDate(2026, 12, 1), 10, 10);
      expect(cycle.dueOn, CivilDate(2027, 1, 10));
      expect(
        CardRules.cycle(CivilDate(2026, 2, 1), 31, 30).dueOn,
        CivilDate(2026, 3, 30),
      );
    },
  );
  test('calendário rejeita dias e quantidade inválidos', () {
    expect(
      () => CardRules.cycle(CivilDate(2026, 1, 1), 0, 17),
      throwsA(isA<FinanceFailure>()),
    );
    expect(
      () => CardRules.cycle(CivilDate(2026, 1, 1), 10, 32),
      throwsA(isA<FinanceFailure>()),
    );
    expect(
      () => CardRules.schedule(
        CivilDate(2026, 1, 1),
        0,
        10,
        17,
        ClosingPolicy.next,
      ),
      throwsA(isA<FinanceFailure>()),
    );
  });
  test(
    'limite disponível, excesso e crédito são separados; zero não divide',
    () {
      CreditCard card(int debt, int limit) => CreditCard(
        id: 'c',
        name: 'C',
        openedOn: CivilDate(2026, 1, 1),
        totalLimit: Money(limit),
        debt: Money(debt),
        closingDay: 10,
        dueDay: 17,
        policy: ClosingPolicy.next,
      );
      expect(card(700, 1000).available.cents, 300);
      expect(card(1200, 1000).available, Money.zero);
      expect(card(1200, 1000).excess.cents, 200);
      expect(card(-200, 1000).available.cents, 1000);
      expect(card(-200, 1000).credit.cents, 200);
      expect(card(200, 0).utilization, isNull);
    },
  );
}
