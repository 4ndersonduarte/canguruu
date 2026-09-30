import 'dart:convert';
import 'package:canguruu_finance/features/cards/data/local_cards_repository.dart';
import 'package:canguruu_finance/features/cards/domain/services/card_rules.dart';

import 'package:drift/native.dart';
import 'package:canguruu_finance/core/civil_date.dart';
import 'package:canguruu_finance/core/money.dart';
import 'package:canguruu_finance/features/finance/data/local_finance_repository.dart';
import 'package:canguruu_finance/features/finance/data/services/backup_service.dart';
import 'package:canguruu_finance/features/finance/domain/models.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:canguruu_finance/persistence/database.dart'
    show CanguruuDatabase;
import 'generated_migrations/schema.dart';

void main() {
  test('esquema criado corresponde exatamente à versão 4 preservada', () async {
    final verifier = SchemaVerifier(GeneratedHelper());
    final db = CanguruuDatabase(NativeDatabase.memory());
    try {
      await verifier.migrateAndValidate(db, 4);
    } finally {
      await db.close();
    }
  });

  test('migração da versão 1 preserva perfil já existente', () async {
    final verifier = SchemaVerifier(GeneratedHelper());
    final schema = await verifier.schemaAt(1);
    schema.rawDatabase.execute(
      "INSERT INTO profiles (id,currency,locale,timezone,created_at,updated_at) VALUES ('local','BRL','pt_BR','America/Sao_Paulo','2026-09-11T15:00:00.000Z','2026-09-11T15:00:00.000Z')",
    );
    final db = CanguruuDatabase(schema.newConnection());
    try {
      await verifier.migrateAndValidate(db, 4);
      expect(
        (await db.customSelect('SELECT id FROM profiles').getSingle())
            .data['id'],
        'local',
      );
    } finally {
      await db.close();
    }
  });

  test(
    'migração v1 com transferências e estornos preserva cada registro e índice',
    () async {
      final clock = FixedClock(
        DateTime.utc(2026, 9, 14, 15),
        CivilDate(2026, 9, 14),
      );
      final source = CanguruuDatabase(NativeDatabase.memory());
      final repo = LocalFinanceRepository(source, clock);
      await repo.initialize();
      final a = await repo.createAccount(
        requestId: 'a',
        name: 'Banco',
        kind: AccountKind.bank,
        openingBalance: Money(50000),
        openedOn: clock.today,
      );
      final b = await repo.createAccount(
        requestId: 'b',
        name: 'Carteira',
        kind: AccountKind.wallet,
        openingBalance: Money.zero,
        openedOn: clock.today,
      );
      final movement = await repo.record(
        requestId: 'move',
        kind: MovementKind.transfer,
        amount: Money(10000),
        date: clock.today,
        description: 'Transferência',
        accountId: a,
        destinationId: b,
      );
      await repo.reverse(
        requestId: 'undo',
        eventId: movement,
        date: clock.today,
      );
      final data =
          (jsonDecode(await repo.exportBackup()) as Map)['tables'] as Map;
      await source.close();
      final verifier = SchemaVerifier(GeneratedHelper());
      final old = await verifier.schemaAt(1);
      old.rawDatabase.execute('PRAGMA foreign_keys=OFF');
      final original = <String, dynamic>{};
      for (final entry in data.entries) {
        if ([
          ...BackupService.cardTableNames,
          ...BackupService.scheduleTableNames,
        ].contains(entry.key)) {
          continue;
        }
        original[entry.key as String] = entry.value;
        for (final row in entry.value as List) {
          final fields = (row as Map).keys.toList();
          old.rawDatabase.execute(
            'INSERT INTO ${entry.key} (${fields.join(',')}) VALUES (${List.filled(fields.length, '?').join(',')})',
            fields.map((f) => row[f]).toList(),
          );
        }
      }
      final migrated = CanguruuDatabase(old.newConnection());
      try {
        await verifier.migrateAndValidate(migrated, 4);
        final migratedRepo = LocalFinanceRepository(migrated, clock);
        final after =
            (jsonDecode(await migratedRepo.exportBackup()) as Map)['tables']
                as Map;
        for (final entry in original.entries) {
          expect(after[entry.key], entry.value, reason: entry.key);
        }
        expect((await migratedRepo.read()).balance.cents, 50000);
        expect(
          await migrated.customSelect('PRAGMA foreign_key_check').get(),
          isEmpty,
        );
        expect(
          (await migrated.customSelect('PRAGMA foreign_keys').getSingle())
              .data
              .values
              .single,
          1,
        );
        await migratedRepo.inspectBackup(await migratedRepo.exportBackup());
      } finally {
        await migrated.close();
      }
    },
  );

  test(
    'versão futura não é recriada nem sobrescrita silenciosamente',
    () async {
      final verifier = SchemaVerifier(GeneratedHelper());
      final schema = await verifier.schemaAt(1);
      schema.rawDatabase.execute('PRAGMA user_version = 99');
      final db = CanguruuDatabase(schema.newConnection());
      try {
        await expectLater(
          db.customSelect('SELECT * FROM profiles').get(),
          throwsA(anything),
        );
        expect(
          schema.rawDatabase.select('PRAGMA user_version').single.values.single,
          99,
        );
      } finally {
        await db.close();
      }
    },
  );

  test('migração v2 para v3 preserva cartões, parcelas e pagamento', () async {
    final clock = FixedClock(
      DateTime.utc(2026, 9, 14, 15),
      CivilDate(2026, 9, 14),
    );
    final source = CanguruuDatabase(NativeDatabase.memory());
    final finance = LocalFinanceRepository(source, clock);
    final cards = LocalCardsRepository(source, clock);
    await finance.initialize();
    final bank = await finance.createAccount(
      requestId: 'bank',
      name: 'Banco',
      kind: AccountKind.bank,
      openingBalance: Money(100000),
      openedOn: clock.today,
    );
    final card = await cards.createCard(
      requestId: 'card',
      name: 'Cartão',
      totalLimit: Money(500000),
      closingDay: 20,
      dueDay: 28,
      policy: ClosingPolicy.next,
      openedOn: clock.today,
    );
    await cards.purchase(
      requestId: 'buy',
      cardId: card,
      categoryId: 'category-food',
      description: 'Compra',
      total: Money(10000),
      installments: 3,
      date: clock.today,
      billingOn: clock.today,
    );
    await cards.payInvoice(
      requestId: 'pay',
      invoiceId: (await cards.read()).invoices.first.id,
      accountId: bank,
      amount: Money(1000),
      date: clock.today,
    );
    final oldData =
        (jsonDecode(await finance.exportBackup()) as Map)['tables'] as Map;
    await source.close();
    final verifier = SchemaVerifier(GeneratedHelper());
    final old = await verifier.schemaAt(2);
    old.rawDatabase.execute('PRAGMA foreign_keys=OFF');
    for (final table in oldData.entries) {
      if (BackupService.scheduleTableNames.contains(table.key)) continue;
      for (final row in table.value as List) {
        final fields = (row as Map).keys.toList();
        old.rawDatabase.execute(
          'INSERT INTO ${table.key} (${fields.join(',')}) VALUES (${List.filled(fields.length, '?').join(',')})',
          fields.map((f) => row[f]).toList(),
        );
      }
    }
    final migrated = CanguruuDatabase(old.newConnection());
    try {
      await verifier.migrateAndValidate(migrated, 4);
      final repo = LocalFinanceRepository(migrated, clock);
      final after =
          (jsonDecode(await repo.exportBackup()) as Map)['tables'] as Map;
      for (final table in oldData.entries) {
        expect(after[table.key], table.value, reason: table.key as String);
      }
      expect((await repo.read()).balance.cents, 99000);
      expect(
        (await LocalCardsRepository(migrated, clock).read()).debt.cents,
        9000,
      );
      await repo.inspectBackup(await repo.exportBackup());
      expect(
        await migrated.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
    } finally {
      await migrated.close();
    }
  });
}
