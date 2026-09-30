import '../../../../core/civil_date.dart';
import '../models.dart';

abstract interface class ScheduleRepository {
  Future<void> generateThrough(CivilDate through);
  Stream<ScheduleSnapshot> watch();
  Future<ScheduleSnapshot> read();
  Future<String> createOneOff({
    required String requestId,
    required PlannedEntry entry,
    required CivilDate date,
  });
  Future<String> createSeries({
    required String requestId,
    required PlannedEntry entry,
    required RecurrencePattern pattern,
  });
  Future<String> reviseSeries({
    required String requestId,
    required String seriesId,
    required PlannedEntry entry,
    required RecurrencePattern pattern,
  });
  Future<String> pause({required String requestId, required String seriesId});
  Future<String> resume({required String requestId, required String seriesId});
  Future<String> editOccurrence({
    required String requestId,
    required String occurrenceId,
    required PlannedEntry entry,
    required CivilDate date,
  });
  Future<String> skip({
    required String requestId,
    required String occurrenceId,
  });
  Future<String> settle({
    required String requestId,
    required String occurrenceId,
    required CivilDate date,
    bool confirmClosedCycle = false,
  });
}
