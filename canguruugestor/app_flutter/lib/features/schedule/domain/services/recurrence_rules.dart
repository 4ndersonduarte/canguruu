import '../../../../core/civil_date.dart';
import '../../../../core/failure.dart';
import '../models.dart';

abstract final class RecurrenceRules {
  static void validate(RecurrencePattern pattern) {
    if (pattern.interval < 1 ||
        pattern.interval > 1200 ||
        pattern.lastDay && pattern.frequency != RepeatFrequency.monthly ||
        pattern.endOn != null && pattern.endOn!.isBefore(pattern.anchor) ||
        pattern.maxOccurrences != null &&
            (pattern.maxOccurrences! < 1 ||
                pattern.maxOccurrences! > 1000000)) {
      throw const FinanceFailure(
        'invalid_recurrence',
        'Confira o intervalo, a data final e a quantidade de repetições.',
      );
    }
  }

  static CivilDate dateAt(RecurrencePattern pattern, int ordinal) {
    validate(pattern);
    if (ordinal < 1) {
      throw const FinanceFailure('invalid_ordinal', 'Ocorrência inválida.');
    }
    final offset = (ordinal - 1) * pattern.interval;
    return switch (pattern.frequency) {
      RepeatFrequency.daily => pattern.anchor.addDays(offset),
      RepeatFrequency.weekly => pattern.anchor.addDays(offset * 7),
      RepeatFrequency.monthly => pattern.anchor.inMonth(
        offset,
        preferredDay: pattern.lastDay ? 31 : pattern.anchor.day,
      ),
      RepeatFrequency.yearly => pattern.anchor.inMonth(
        offset * 12,
        preferredDay: pattern.anchor.day,
      ),
    };
  }

  static List<(int, CivilDate)> occurrences(
    RecurrenceVersion rule,
    CivilDate through,
  ) {
    validate(rule.pattern);
    var end = through;
    for (final limit in [rule.validUntil, rule.pattern.endOn]) {
      if (limit != null && limit.isBefore(end)) end = limit;
    }
    if (end.isBefore(rule.validFrom) || end.isBefore(rule.pattern.anchor)) {
      return const [];
    }
    final pattern = rule.pattern;
    final deltaDays = rule.validFrom.dateTime
        .difference(pattern.anchor.dateTime)
        .inDays;
    final deltaMonths =
        (rule.validFrom.year - pattern.anchor.year) * 12 +
        rule.validFrom.month -
        pattern.anchor.month;
    final rough = switch (pattern.frequency) {
      RepeatFrequency.daily => deltaDays ~/ pattern.interval,
      RepeatFrequency.weekly => deltaDays ~/ (7 * pattern.interval),
      RepeatFrequency.monthly => deltaMonths ~/ pattern.interval,
      RepeatFrequency.yearly => deltaMonths ~/ (12 * pattern.interval),
    };
    var ordinal = (rough + 1).clamp(1, 1000000);
    final result = <(int, CivilDate)>[];
    while (pattern.maxOccurrences == null ||
        ordinal <= pattern.maxOccurrences!) {
      CivilDate date;
      try {
        date = dateAt(pattern, ordinal);
      } on FinanceFailure {
        break;
      }
      if (date.isAfter(end)) break;
      if (!date.isBefore(rule.validFrom)) result.add((ordinal, date));
      if (result.length > 5000) {
        throw const FinanceFailure(
          'too_many_occurrences',
          'Esta regra gera mais de 5.000 previsões. Use uma data inicial mais recente ou um período menor.',
        );
      }
      ordinal++;
    }
    return List.unmodifiable(result);
  }
}
