import '../../../../core/civil_date.dart';
import '../../../../core/money.dart';
import '../../../finance/domain/models.dart';
import '../../domain/models.dart';

abstract final class ScheduleCodec {
  static PlannedEntry entry(Map<String, Object?> r, {ScheduleKind? kind}) =>
      PlannedEntry(
        kind: kind ?? ScheduleKind.parse(r['kind'] as String),
        description: r['description'] as String,
        amount: Money(r['amount_cents'] as int),
        accountId: r['account_id'] as String?,
        destinationId: r['destination_id'] as String?,
        cardId: r['card_id'] as String?,
        categoryId: r['category_id'] as String?,
        costNature: r['cost_nature'] == null
            ? null
            : CostNature.values.byName(r['cost_nature'] as String),
        essential: r['essential'] == null ? null : r['essential'] == 1,
      );
  static Map<String, Object?> entryFields(PlannedEntry e) => {
    'description': e.description,
    'amount_cents': e.amount.cents,
    'account_id': e.accountId,
    'destination_id': e.destinationId,
    'card_id': e.cardId,
    'category_id': e.categoryId,
    'cost_nature': e.costNature?.name,
    'essential': e.essential == null
        ? null
        : e.essential!
        ? 1
        : 0,
  };
  static RecurrenceVersion rule(Map<String, Object?> r, ScheduleKind kind) =>
      RecurrenceVersion(
        id: r['id'] as String,
        seriesId: r['series_id'] as String,
        validFrom: CivilDate.parse(r['valid_from'] as String),
        validUntil: r['valid_until'] == null
            ? null
            : CivilDate.parse(r['valid_until'] as String),
        entry: entry(r, kind: kind),
        pattern: RecurrencePattern(
          anchor: CivilDate.parse(r['anchor_on'] as String),
          frequency: RepeatFrequency.values.byName(r['frequency'] as String),
          interval: r['interval_count'] as int,
          lastDay: r['last_day'] == 1,
          endOn: r['end_on'] == null
              ? null
              : CivilDate.parse(r['end_on'] as String),
          maxOccurrences: r['max_occurrences'] as int?,
        ),
      );
}
