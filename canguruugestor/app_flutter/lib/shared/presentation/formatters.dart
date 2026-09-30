import '../../core/money.dart';

/// Formatting uses integer digits too, avoiding rounding near the web-safe limit.
String formatMoney(Money money, {bool hidden = false}) {
  if (hidden) return 'R\$ ••••';
  final digits = money.cents.abs().toString().padLeft(3, '0');
  final whole = digits
      .substring(0, digits.length - 2)
      .replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      );
  return '${money.cents < 0 ? '−' : ''}R\$ $whole,${digits.substring(digits.length - 2)}';
}

String editMoney(Money money) {
  final digits = money.cents.abs().toString().padLeft(3, '0');
  return '${money.cents < 0 ? '-' : ''}${digits.substring(0, digits.length - 2)},${digits.substring(digits.length - 2)}';
}
