import 'package:drift/drift.dart';
part 'database.g.dart';

@DriftDatabase(include: {'schema.drift'})
class CanguruuDatabase extends _$CanguruuDatabase {
  CanguruuDatabase(super.executor);
  @override
  int get schemaVersion => 4;
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (![1, 2, 3].contains(from) ||
          ![3, 4].contains(to) ||
          (to == 3 && from == 3)) {
        throw StateError('Não há migração definida de $from para $to.');
      }
      await customStatement('PRAGMA foreign_keys = OFF');
      try {
        await transaction(() async {
          await migrator.alterTable(TableMigration(operationReceipts));
          if (from == 1) {
            await migrator.alterTable(TableMigration(ledgerAccounts));
            await migrator.alterTable(TableMigration(financialEvents));
            for (final table in <TableInfo>[
              creditCards,
              cardOperations,
              invoices,
              invoiceItems,
              invoicePayments,
              invoicePaymentAllocations,
            ]) {
              await migrator.createTable(table);
            }
            for (final index in [
              invoicesByDue,
              itemsByInvoice,
              allocationsByInvoice,
            ]) {
              await migrator.createIndex(index);
            }
          }
          for (final table in <TableInfo>[
            recurrenceSeries,
            recurrenceRuleVersions,
            scheduledOccurrences,
          ]) {
            await migrator.createTable(table);
          }
          for (final index in [
            occurrenceBySeriesDate,
            scheduledByDate,
            rulesBySeries,
            currentRulePerSeries,
          ]) {
            await migrator.createIndex(index);
          }
          if (from <= 3) {
            for (final table in <TableInfo>[
              objectives,
              goals,
              goalFundMovements,
            ]) {
              await migrator.createTable(table);
            }
            for (final index in [
              goalsByStatus,
              goalMovementsByGoal,
              goalMovementsByAccount,
            ]) {
              await migrator.createIndex(index);
            }
          }
          if ((await customSelect(
            'PRAGMA foreign_key_check',
          ).get()).isNotEmpty) {
            throw StateError('A migração encontrou vínculos inconsistentes.');
          }
        });
      } finally {
        await customStatement('PRAGMA foreign_keys = ON');
      }
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
  void changed() => markTablesUpdated(allTables.toSet());
}

/// Independent executor used to validate backups without touching the live file.
class ValidationDatabase extends CanguruuDatabase {
  ValidationDatabase(super.executor);
}
