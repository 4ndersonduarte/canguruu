import '../features/schedule/data/local_schedule_repository.dart';
import '../features/schedule/domain/models.dart';
import '../features/schedule/domain/repositories/schedule_repository.dart';
import '../features/backup/data/local_backup_files.dart';
import '../features/cards/data/local_cards_repository.dart';
import '../features/cards/domain/models.dart';
import '../features/cards/domain/repositories/cards_repository.dart';
import '../features/backup/domain/backup_files.dart';
import '../features/goals/data/local_goals_repository.dart';
import '../features/goals/domain/models.dart';
import '../features/goals/domain/repositories/goals_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import '../core/civil_date.dart';
import '../features/finance/data/local_finance_repository.dart';
import '../features/finance/domain/models.dart';
import '../features/finance/domain/repositories/finance_repository.dart';
import '../features/finance/domain/use_cases/finance_actions.dart';
import '../persistence/connection.dart';
import '../persistence/database.dart';

final class SaoPauloClock implements Clock {
  @override
  DateTime get utcNow => DateTime.now().toUtc();
  @override
  CivilDate get today => CivilDate.fromDateTime(
    tz.TZDateTime.from(utcNow, tz.getLocation('America/Sao_Paulo')),
  );
}

final clockProvider = Provider<Clock>((ref) => SaoPauloClock());
final databaseProvider = Provider<CanguruuDatabase>((ref) {
  final db = CanguruuDatabase(openLocalDatabase());
  ref.onDispose(db.close);
  return db;
});
final repositoryProvider = Provider<FinanceRepository>(
  (ref) => LocalFinanceRepository(
    ref.watch(databaseProvider),
    ref.watch(clockProvider),
  ),
);
final cardsRepositoryProvider = Provider<CardsRepository>(
  (ref) => LocalCardsRepository(
    ref.watch(databaseProvider),
    ref.watch(clockProvider),
  ),
);
final cardsSnapshotProvider = StreamProvider<CardsSnapshot>((ref) async* {
  await ref.watch(repositoryProvider).initialize();
  yield* ref.watch(cardsRepositoryProvider).watch();
});
final actionsProvider = Provider(
  (ref) =>
      FinanceActions(ref.watch(repositoryProvider), ref.watch(clockProvider)),
);
final snapshotProvider = StreamProvider<FinanceSnapshot>((ref) async* {
  final repository = ref.watch(repositoryProvider);
  await repository.initialize();
  yield* repository.watch();
});
final hiddenAmountsProvider = StateProvider<bool>((ref) => false);

final backupFilesProvider = Provider<BackupFiles>((ref) => LocalBackupFiles());

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => LocalScheduleRepository(
    ref.watch(databaseProvider),
    ref.watch(clockProvider),
  ),
);
final scheduleSnapshotProvider = StreamProvider<ScheduleSnapshot>((ref) async* {
  await ref.watch(repositoryProvider).initialize();
  final repository = ref.watch(scheduleRepositoryProvider);
  await repository.generateThrough(ref.watch(clockProvider).today.addDays(90));
  yield* repository.watch();
});

final goalsRepositoryProvider = Provider<GoalsRepository>(
  (ref) => LocalGoalsRepository(
    ref.watch(databaseProvider),
    ref.watch(clockProvider),
  ),
);

final goalsSnapshotProvider = StreamProvider<GoalsSnapshot>((ref) async* {
  await ref.watch(repositoryProvider).initialize();
  yield* ref.watch(goalsRepositoryProvider).watch();
});
