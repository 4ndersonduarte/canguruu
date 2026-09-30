import 'package:uuid/uuid.dart';
import '../../../core/civil_date.dart';
import '../../../persistence/ledger_writer.dart';
import '../../../core/failure.dart';
import '../../../core/money.dart';
import '../../../persistence/database.dart' show CanguruuDatabase;
import '../../../persistence/validation_connection.dart';
import '../domain/models.dart';
import '../domain/repositories/finance_repository.dart';
import '../domain/services/ledger_rules.dart';
import 'services/backup_service.dart';

final class LocalFinanceRepository implements FinanceRepository {
  LocalFinanceRepository(this.db, this.clock, {String Function()? newId})
    : newId = newId ?? const Uuid().v4;
  final CanguruuDatabase db;
  final Clock clock;
  final String Function() newId;
  String get _now => clock.utcNow.toUtc().toIso8601String();

  @override
  Future<void> initialize() => db.transaction(() async {
    final rows = await db.customSelect('SELECT id FROM profiles').get();
    if (rows.isNotEmpty) return;
    await db.customStatement(
      'INSERT INTO profiles (id,currency,locale,timezone,created_at,updated_at) VALUES (?,?,?,?,?,?)',
      ['local', 'BRL', 'pt_BR', 'America/Sao_Paulo', _now, _now],
    );
    for (final kind in ['income', 'expense', 'equity']) {
      await db.customStatement('INSERT INTO ledger_accounts VALUES (?,?,?,?)', [
        'system-$kind',
        'local',
        kind,
        _now,
      ]);
    }
    final defaults = [
      ('salary', 'Salário', 'income', 'fixed', 0),
      ('other-income', 'Outras receitas', 'income', 'variable', 0),
      ('home', 'Moradia', 'expense', 'fixed', 1),
      ('food', 'Alimentação', 'expense', 'variable', 1),
      ('transport', 'Transporte', 'expense', 'variable', 1),
      ('health', 'Saúde', 'expense', 'variable', 1),
      ('leisure', 'Lazer', 'expense', 'variable', 0),
      ('other-expense', 'Outras despesas', 'expense', 'variable', 0),
    ];
    for (final item in defaults) {
      await db.customStatement(
        'INSERT INTO categories (id,profile_id,name,kind,cost_nature,essential,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?)',
        [
          'category-${item.$1}',
          'local',
          item.$2,
          item.$3,
          item.$4,
          item.$5,
          _now,
          _now,
        ],
      );
    }
    db.changed();
  });

  @override
  Stream<FinanceSnapshot> watch() => db
      .customSelect(
        'SELECT count(*) AS changes FROM financial_events',
        readsFrom: db.allTables.toSet(),
      )
      .watch()
      .asyncMap((_) => read());

  @override
  Future<FinanceSnapshot> read() => db.transaction(_readSnapshot);

  Future<FinanceSnapshot> _readSnapshot() async {
    final accountRows = await db
        .customSelect('SELECT * FROM accounts ORDER BY name COLLATE NOCASE')
        .get();
    final categoryRows = await db
        .customSelect('SELECT * FROM categories ORDER BY name COLLATE NOCASE')
        .get();
    final eventRows = await db
        .customSelect(
          'SELECT * FROM financial_events ORDER BY effective_date DESC, created_at DESC, id DESC',
        )
        .get();
    final postingRows = await db
        .customSelect('SELECT * FROM postings ORDER BY event_id, sequence')
        .get();
    final entries = <String, List<LedgerEntry>>{};
    for (final row in postingRows) {
      final r = row.data;
      (entries[r['event_id'] as String] ??= []).add(
        LedgerEntry(
          accountId: r['ledger_account_id'] as String,
          cents: r['amount_cents'] as int,
          categoryId: r['category_id'] as String?,
          costNature: r['cost_nature'] == null
              ? null
              : CostNature.values.byName(r['cost_nature'] as String),
          essential: r['essential'] == null ? null : r['essential'] == 1,
        ),
      );
    }
    final reversed = eventRows
        .map((r) => r.data['reversal_of'])
        .whereType<String>()
        .toSet();
    final events = eventRows.map((row) {
      final r = row.data;
      return FinancialEvent(
        id: r['id'] as String,
        kind: r['kind'] as String,
        date: CivilDate.parse(r['effective_date'] as String),
        description: r['description'] as String,
        entries: List.unmodifiable(entries[r['id']] ?? []),
        reversalOf: r['reversal_of'] as String?,
        reversed: reversed.contains(r['id']),
      );
    }).toList();
    final balances = <String, List<Money>>{};
    for (final event in events.where((e) => !e.date.isAfter(clock.today))) {
      for (final entry in event.entries) {
        (balances[entry.accountId] ??= []).add(Money(entry.cents));
      }
    }
    final accounts = accountRows.map((row) {
      final r = row.data;
      return Account(
        id: r['id'] as String,
        name: r['name'] as String,
        kind: AccountKind.values.byName(r['kind'] as String),
        openedOn: CivilDate.parse(r['opened_on'] as String),
        archived: r['archived'] == 1,
        balance: Money.sum(balances[r['id']] ?? []),
      );
    }).toList();
    final categories = categoryRows.map((row) {
      final r = row.data;
      return Category(
        id: r['id'] as String,
        name: r['name'] as String,
        kind: MovementKind.values.byName(r['kind'] as String),
        parentId: r['parent_id'] as String?,
        archived: r['archived'] == 1,
        costNature: CostNature.values.byName(r['cost_nature'] as String),
        essential: r['essential'] == 1,
      );
    }).toList();
    final cardRows = await db
        .customSelect('SELECT id,name FROM credit_cards')
        .get();
    return FinanceSnapshot(
      cardNames: {
        for (final c in cardRows)
          c.data['id'] as String: c.data['name'] as String,
      },
      cardDebts: {
        for (final c in cardRows)
          c.data['id'] as String: Money(
            -Money.sum(balances[c.data['id']] ?? []).cents,
          ),
      },
      accounts: accounts,
      categories: categories,
      events: events,
      asOf: clock.today,
    );
  }

  LedgerWriter get _writer => LedgerWriter(db, clock, newId);
  Future<String> _command(
    String requestId,
    String command,
    List<Object?> payload,
    Future<String> Function() operation,
  ) => _writer.command(requestId, command, payload, operation);

  @override
  Future<String> createAccount({
    required String requestId,
    required String name,
    required AccountKind kind,
    required Money openingBalance,
    required CivilDate openedOn,
  }) {
    name = LedgerRules.name(name);
    LedgerRules.effectiveDate(openedOn, clock);
    final validName = name;
    return _command(
      requestId,
      'create_account',
      [name, kind.name, openingBalance.cents, '$openedOn'],
      () async {
        final id = newId();
        await db.customStatement(
          'INSERT INTO ledger_accounts VALUES (?,?,?,?)',
          [id, 'local', 'asset', _now],
        );
        await db.customStatement(
          'INSERT INTO accounts (id,profile_id,name,kind,opened_on,created_at,updated_at) VALUES (?,?,?,?,?,?,?)',
          [id, 'local', validName, kind.name, '$openedOn', _now, _now],
        );
        if (openingBalance.cents != 0) {
          await _event(
            requestId,
            'opening_balance',
            openedOn,
            'Saldo inicial · $validName',
            [
              LedgerEntry(accountId: id, cents: openingBalance.cents),
              LedgerEntry(
                accountId: 'system-equity',
                cents: -openingBalance.cents,
              ),
            ],
          );
        }
        return id;
      },
    );
  }

  @override
  Future<String> createCategory({
    required String requestId,
    required String name,
    required MovementKind kind,
    String? parentId,
    CostNature costNature = CostNature.variable,
    bool essential = false,
  }) {
    final validName = LedgerRules.name(name);
    if (kind == MovementKind.transfer) {
      throw const FinanceFailure(
        'invalid_category',
        'Transferências não têm categoria.',
      );
    }
    return _command(
      requestId,
      'create_category',
      [validName, kind.name, parentId, costNature.name, essential],
      () async {
        if (parentId != null) {
          final snapshot = await _readSnapshot();
          final parent = snapshot.categories
              .where((c) => c.id == parentId)
              .firstOrNull;
          if (parent == null ||
              parent.archived ||
              parent.parentId != null ||
              parent.kind != kind) {
            throw const FinanceFailure(
              'invalid_parent',
              'Escolha uma categoria principal do mesmo tipo.',
            );
          }
        }
        final id = newId();
        await db.customStatement(
          'INSERT INTO categories (id,profile_id,name,kind,parent_id,cost_nature,essential,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,?)',
          [
            id,
            'local',
            validName,
            kind.name,
            parentId,
            costNature.name,
            essential ? 1 : 0,
            _now,
            _now,
          ],
        );
        return id;
      },
    );
  }

  @override
  Future<String> record({
    required String requestId,
    required MovementKind kind,
    required Money amount,
    required CivilDate date,
    required String description,
    required String accountId,
    String? destinationId,
    String? categoryId,
    CostNature? costNatureSnapshot,
    bool? essentialSnapshot,
  }) {
    if ((costNatureSnapshot == null) != (essentialSnapshot == null) ||
        costNatureSnapshot != null && kind != MovementKind.expense) {
      throw const FinanceFailure(
        'invalid_classification',
        'Classificação da previsão inválida.',
      );
    }
    LedgerRules.effectiveDate(date, clock);
    final validDescription = LedgerRules.name(description, max: 160);
    return _command(
      requestId,
      'record',
      [
        kind.name,
        amount.cents,
        '$date',
        validDescription,
        accountId,
        destinationId,
        categoryId,
        if (costNatureSnapshot != null) ...[
          'classification_snapshot',
          costNatureSnapshot.name,
          essentialSnapshot,
        ],
      ],
      () async {
        final snapshot = await _readSnapshot();
        final source = snapshot.accounts
            .where((a) => a.id == accountId)
            .firstOrNull;
        final destination = snapshot.accounts
            .where((a) => a.id == destinationId)
            .firstOrNull;
        final category = snapshot.categories
            .where((c) => c.id == categoryId)
            .firstOrNull;
        if (source == null ||
            (destinationId != null && destination == null) ||
            (categoryId != null && category == null)) {
          throw const FinanceFailure(
            'missing_reference',
            'A conta ou categoria não está disponível.',
          );
        }
        final entries = LedgerRules.movement(
          kind: kind,
          amount: amount,
          source: source,
          destination: destination,
          category: category,
          date: date,
        );
        final classified = costNatureSnapshot == null
            ? entries
            : entries
                  .map(
                    (p) => p.categoryId == null
                        ? p
                        : LedgerEntry(
                            accountId: p.accountId,
                            cents: p.cents,
                            categoryId: p.categoryId,
                            costNature: costNatureSnapshot,
                            essential: essentialSnapshot,
                          ),
                  )
                  .toList();
        return _event(requestId, kind.name, date, validDescription, classified);
      },
    );
  }

  Future<String> _event(
    String requestId,
    String kind,
    CivilDate date,
    String description,
    List<LedgerEntry> entries, {
    String? reversalOf,
  }) => _writer.event(
    requestId,
    kind,
    date,
    description,
    entries,
    reversalOf: reversalOf,
  );

  @override
  Future<String> reverse({
    required String requestId,
    required String eventId,
    required CivilDate date,
  }) {
    LedgerRules.effectiveDate(date, clock);
    return _command(requestId, 'reverse', [eventId, '$date'], () async {
      final snapshot = await _readSnapshot();
      final event = snapshot.events.where((e) => e.id == eventId).firstOrNull;
      if (event == null ||
          event.reversed ||
          !['income', 'expense', 'transfer'].contains(event.kind)) {
        throw const FinanceFailure(
          'invalid_reversal',
          'Esta movimentação não pode ser estornada.',
        );
      }
      if (date.isBefore(event.date)) {
        throw const FinanceFailure(
          'invalid_date',
          'O estorno deve ocorrer a partir da data original.',
        );
      }
      if (snapshot.accounts.any(
        (a) => a.archived && event.entries.any((p) => p.accountId == a.id),
      )) {
        throw const FinanceFailure(
          'invalid_account',
          'A conta está arquivada.',
        );
      }
      return _event(
        requestId,
        'reversal',
        date,
        'Estorno · ${event.description}'.substring(
          0,
          ('Estorno · ${event.description}').length.clamp(0, 160),
        ),
        event.entries
            .map(
              (p) => LedgerEntry(
                accountId: p.accountId,
                cents: -p.cents,
                categoryId: p.categoryId,
                costNature: p.costNature,
                essential: p.essential,
              ),
            )
            .toList(),
        reversalOf: event.id,
      );
    });
  }

  @override
  Future<void> archiveAccount(String id) => db.transaction(() async {
    final snapshot = await _readSnapshot();
    final account = snapshot.accounts.where((a) => a.id == id).firstOrNull;
    if (account == null || account.balance.cents != 0) {
      throw const FinanceFailure(
        'nonzero_balance',
        'Transfira ou concilie o saldo antes de arquivar a conta.',
      );
    }
    await db.customStatement(
      'UPDATE accounts SET archived=1, updated_at=?, revision=revision+1 WHERE id=?',
      [_now, id],
    );
    db.changed();
  });

  BackupService get _backup => BackupService(db, clock, openValidationDatabase);
  @override
  Future<String> exportBackup() => _backup.export();
  @override
  Future<BackupSummary> inspectBackup(String content) =>
      _backup.inspect(content);
  @override
  Future<void> restoreBackup(String content) => _backup.restore(content);
}
