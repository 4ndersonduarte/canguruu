import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import '../../finance/domain/models.dart';

enum ScheduleKind {
  income,
  expense,
  transfer,
  cardPurchase;

  String get code => this == cardPurchase ? 'card_purchase' : name;
  static ScheduleKind parse(String value) =>
      value == 'card_purchase' ? cardPurchase : values.byName(value);
}

enum RepeatFrequency { daily, weekly, monthly, yearly }

enum OccurrenceStatus { pending, settled, skipped, cancelled }

final class PlannedEntry {
  const PlannedEntry({
    required this.kind,
    required this.description,
    required this.amount,
    this.accountId,
    this.destinationId,
    this.cardId,
    this.categoryId,
    this.costNature,
    this.essential,
  });
  final ScheduleKind kind;
  final String description;
  final Money amount;
  final String? accountId, destinationId, cardId, categoryId;
  final CostNature? costNature;
  final bool? essential;
}

final class RecurrencePattern {
  const RecurrencePattern({
    required this.anchor,
    required this.frequency,
    this.interval = 1,
    this.lastDay = false,
    this.endOn,
    this.maxOccurrences,
  });
  final CivilDate anchor;
  final RepeatFrequency frequency;
  final int interval;
  final bool lastDay;
  final CivilDate? endOn;
  final int? maxOccurrences;
}

final class RecurrenceVersion {
  const RecurrenceVersion({
    required this.id,
    required this.seriesId,
    required this.validFrom,
    required this.entry,
    required this.pattern,
    this.validUntil,
  });
  final String id, seriesId;
  final CivilDate validFrom;
  final CivilDate? validUntil;
  final PlannedEntry entry;
  final RecurrencePattern pattern;
}

final class RecurrenceSeries {
  const RecurrenceSeries({
    required this.id,
    required this.name,
    required this.kind,
    required this.currentRuleId,
    this.pausedOn,
  });
  final String id, name, currentRuleId;
  final ScheduleKind kind;
  final CivilDate? pausedOn;
  bool get paused => pausedOn != null;
}

final class ScheduledOccurrence {
  const ScheduledOccurrence({
    required this.id,
    required this.entry,
    required this.date,
    required this.status,
    required this.manualOverride,
    this.seriesId,
    this.ruleId,
    this.ordinal,
    this.eventId,
    this.reversed = false,
  });
  final String id;
  final PlannedEntry entry;
  final CivilDate date;
  final OccurrenceStatus status;
  final String? seriesId, ruleId, eventId;
  final int? ordinal;
  final bool manualOverride, reversed;
  bool overdue(CivilDate today) =>
      status == OccurrenceStatus.pending && date.isBefore(today);
}

final class ScheduleSnapshot {
  ScheduleSnapshot({
    required List<RecurrenceSeries> series,
    required List<RecurrenceVersion> rules,
    required List<ScheduledOccurrence> occurrences,
    required this.asOf,
  }) : series = List.unmodifiable(series),
       rules = List.unmodifiable(rules),
       occurrences = List.unmodifiable(occurrences);
  final List<RecurrenceSeries> series;
  final List<RecurrenceVersion> rules;
  final List<ScheduledOccurrence> occurrences;
  final CivilDate asOf;
  List<ScheduledOccurrence> get pending =>
      occurrences.where((o) => o.status == OccurrenceStatus.pending).toList();
  Money expectedIn(int days, ScheduleKind kind) => Money.sum(
    pending
        .where(
          (o) =>
              o.entry.kind == kind &&
              !o.date.isBefore(asOf) &&
              !o.date.isAfter(asOf.addDays(days)),
        )
        .map((o) => o.entry.amount),
  );
}
