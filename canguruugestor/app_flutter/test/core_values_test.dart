import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/failure.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/shared/presentation/formatters.dart';

void main() {
  group('Centavos exatos em todas as plataformas', () {
    test('aceita BRL e vírgula sem arredondar', () {
      expect(Money.parse('R\$ 1.234,56').cents, 123456);
      expect(Money.parse('-12,5').cents, -1250);
      expect((Money.parse('0,10') + Money.parse('0,20')).cents, 30);
      expect(Money.parse('0').cents, 0);
    });
    test('rejeita formatos ambíguos e frações menores que um centavo', () {
      for (final input in [
        '',
        '1.25',
        '1,234',
        '1e3',
        'NaN',
        '+1',
        '1,2,3',
        '1.23.456',
        'R\$',
      ]) {
        expect(
          () => Money.parse(input),
          throwsA(isA<FinanceFailure>()),
          reason: input,
        );
      }
    });
    test('preserva os extremos interoperáveis com JavaScript', () {
      final maximum = Money.parse('90.071.992.547.409,91');
      expect(maximum.cents, Money.maxCents);
      expect(formatMoney(maximum), 'R\$ 90.071.992.547.409,91');
      expect(Money.parse('-90.071.992.547.409,91').cents, -Money.maxCents);
      expect(
        () => Money.parse('90.071.992.547.409,92'),
        throwsA(isA<FinanceFailure>()),
      );
      expect(() => maximum + Money(1), throwsA(isA<FinanceFailure>()));
      expect(Money.sum([maximum, maximum, Money(-Money.maxCents)]), maximum);
    });
  });
  group('Calendário civil', () {
    test('rejeita datas inexistentes e mantém ano bissexto', () {
      expect(CivilDate.parse('2024-02-29').display, '29/02/2024');
      expect(
        () => CivilDate.parse('2025-02-29'),
        throwsA(isA<FinanceFailure>()),
      );
      expect(
        () => CivilDate.parse('2026-13-01'),
        throwsA(isA<FinanceFailure>()),
      );
      expect(
        () => CivilDate.parse('11/09/2026'),
        throwsA(isA<FinanceFailure>()),
      );
    });
    test('ajusta ao fim do mês preservando o dia configurado', () {
      final january = CivilDate(2026, 1, 31);
      final february = january.inMonth(1, preferredDay: 31);
      expect(february, CivilDate(2026, 2, 28));
      expect(february.inMonth(1, preferredDay: 31), CivilDate(2026, 3, 31));
      expect(CivilDate(2024, 1, 31).inMonth(1), CivilDate(2024, 2, 29));
    });
    test('cruza mês e ano sem horário ou fuso do dispositivo', () {
      expect(CivilDate(2025, 12, 31).addDays(1), CivilDate(2026, 1, 1));
      expect(CivilDate(2026, 3, 1).addDays(-1), CivilDate(2026, 2, 28));
    });
  });
}
