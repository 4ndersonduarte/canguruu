import 'failure.dart';

/// A calendar date without a time or device time zone.
final class CivilDate implements Comparable<CivilDate> {
  const CivilDate._(this.year, this.month, this.day);
  final int year;
  final int month;
  final int day;

  factory CivilDate(int year, int month, int day) {
    final date = DateTime.utc(year, month, day);
    if (year < 1900 ||
        year > 9999 ||
        date.year != year ||
        date.month != month ||
        date.day != day) {
      throw const FinanceFailure('invalid_date', 'Informe uma data válida.');
    }
    return CivilDate._(year, month, day);
  }

  factory CivilDate.parse(String input) {
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input)) {
      throw const FinanceFailure('invalid_date', 'Informe uma data válida.');
    }
    final parts = input.split('-').map(int.parse).toList();
    return CivilDate(parts[0], parts[1], parts[2]);
  }

  factory CivilDate.fromDateTime(DateTime date) =>
      CivilDate(date.year, date.month, date.day);
  DateTime get dateTime => DateTime.utc(year, month, day);
  CivilDate get monthStart => CivilDate(year, month, 1);
  CivilDate addDays(int count) =>
      CivilDate.fromDateTime(dateTime.add(Duration(days: count)));
  CivilDate inMonth(int offset, {int? preferredDay}) {
    final first = DateTime.utc(year, month + offset);
    final lastDay = DateTime.utc(first.year, first.month + 1, 0).day;
    final requested = preferredDay ?? day;
    if (requested < 1 || requested > 31) {
      throw const FinanceFailure(
        'invalid_date',
        'O dia deve estar entre 1 e 31.',
      );
    }
    return CivilDate(first.year, first.month, requested.clamp(1, lastDay));
  }

  bool isAfter(CivilDate other) => compareTo(other) > 0;
  bool isBefore(CivilDate other) => compareTo(other) < 0;
  @override
  int compareTo(CivilDate other) => toString().compareTo(other.toString());
  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  String get display =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  @override
  bool operator ==(Object other) => other is CivilDate && compareTo(other) == 0;
  @override
  int get hashCode => Object.hash(year, month, day);
}

abstract interface class Clock {
  DateTime get utcNow;
  CivilDate get today;
}

final class FixedClock implements Clock {
  FixedClock(this.utcNow, this.today);
  @override
  final DateTime utcNow;
  @override
  final CivilDate today;
}
