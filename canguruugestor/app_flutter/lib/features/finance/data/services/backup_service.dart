import 'dart:convert';
import '../../../schedule/data/services/schedule_backup_validator.dart';
import '../../../cards/data/services/card_backup_validator.dart';
import 'package:drift/drift.dart';
import '../../../../core/civil_date.dart';
import '../../../../core/failure.dart';
import '../../../../core/money.dart';
import '../../../../persistence/database.dart';
import '../../domain/repositories/finance_repository.dart';

typedef _Row = Map<String, Object?>;

final class BackupService {
  BackupService(this.db, this.clock, this.validationExecutor);
  final CanguruuDatabase db;
  final Clock clock;
  final Future<QueryExecutor> Function() validationExecutor;
  static const formatVersion = 1;
  static const maxBytes = 10 * 1024 * 1024;
  static const tables = {
    'profiles': [
      'id',
      'currency',
      'locale',
      'timezone',
      'created_at',
      'updated_at',
      'revision',
    ],
    'ledger_accounts': ['id', 'profile_id', 'kind', 'created_at'],
    'accounts': [
      'id',
      'profile_id',
      'name',
      'kind',
      'opened_on',
      'archived',
      'created_at',
      'updated_at',
      'revision',
    ],
    'categories': [
      'id',
      'profile_id',
      'name',
      'kind',
      'parent_id',
      'cost_nature',
      'essential',
      'archived',
      'created_at',
      'updated_at',
      'revision',
    ],
    'financial_events': [
      'id',
      'profile_id',
      'kind',
      'effective_date',
      'description',
      'idempotency_key',
      'reversal_of',
      'created_at',
    ],
    'postings': [
      'id',
      'profile_id',
      'event_id',
      'ledger_account_id',
      'sequence',
      'amount_cents',
      'category_id',
      'cost_nature',
      'essential',
    ],
    'credit_cards': [
      'id',
      'profile_id',
      'name',
      'opened_on',
      'limit_cents',
      'closing_day',
      'due_day',
      'closing_policy',
      'created_at',
      'updated_at',
      'revision',
    ],
    'card_operations': [
      'id',
      'profile_id',
      'card_id',
      'kind',
      'billing_on',
      'installment_count',
      'total_cents',
      'reconciled',
    ],
    'invoices': ['id', 'profile_id', 'card_id', 'closing_on', 'due_on'],
    'invoice_items': [
      'id',
      'profile_id',
      'operation_id',
      'invoice_id',
      'sequence',
      'amount_cents',
    ],
    'invoice_payments': [
      'id',
      'profile_id',
      'card_id',
      'account_id',
      'amount_cents',
    ],
    'invoice_payment_allocations': [
      'id',
      'profile_id',
      'payment_id',
      'invoice_id',
      'amount_cents',
    ],
    'recurrence_series': [
      'id',
      'profile_id',
      'name',
      'kind',
      'paused_on',
      'created_at',
      'updated_at',
      'revision',
    ],
    'recurrence_rule_versions': [
      'id',
      'profile_id',
      'series_id',
      'valid_from',
      'is_current',
      'valid_until',
      'anchor_on',
      'frequency',
      'interval_count',
      'last_day',
      'end_on',
      'max_occurrences',
      'description',
      'amount_cents',
      'account_id',
      'destination_id',
      'card_id',
      'category_id',
      'cost_nature',
      'essential',
      'created_at',
    ],
    'scheduled_occurrences': [
      'id',
      'profile_id',
      'series_id',
      'rule_version_id',
      'ordinal',
      'kind',
      'scheduled_on',
      'description',
      'amount_cents',
      'account_id',
      'destination_id',
      'card_id',
      'category_id',
      'cost_nature',
      'essential',
      'status',
      'settled_event_id',
      'is_manual_override',
      'created_at',
      'updated_at',
      'revision',
    ],
    'objectives': ['id','profile_id','title','status','created_at','updated_at','revision'],
    'goals': ['id','profile_id','objective_id','title','purpose','target_cents','target_on','priority','status','fulfilled_on','fulfilled_cents','created_at','updated_at','revision'],
    'goal_fund_movements': ['id','profile_id','goal_id','account_id','effective_on','amount_cents','sequence_no','request_id','created_at'],
    'operation_receipts': [
      'id',
      'profile_id',
      'command',
      'fingerprint',
      'result_id',
      'created_at',
    ],
  };
  static const goalTableNames = ['objectives', 'goals', 'goal_fund_movements'];
  static const cardTableNames = [
    'credit_cards',
    'card_operations',
    'invoices',
    'invoice_items',
    'invoice_payments',
    'invoice_payment_allocations',
  ];
  static const scheduleTableNames = [
    'recurrence_series',
    'recurrence_rule_versions',
    'scheduled_occurrences',
  ];
  static const _integers = {
    'is_current',
    'interval_count',
    'last_day',
    'max_occurrences',
    'ordinal',
    'is_manual_override',
    'revision',
    'archived',
    'essential',
    'sequence',
    'amount_cents',
    'limit_cents',
    'closing_day',
    'due_day',
    'installment_count',
    'total_cents',
    'reconciled',
  };
  static const _nullable = {
    'paused_on',
    'valid_until',
    'end_on',
    'max_occurrences',
    'account_id',
    'destination_id',
    'card_id',
    'series_id',
    'rule_version_id',
    'ordinal',
    'settled_event_id',
    'parent_id',
    'reversal_of',
    'category_id',
    'cost_nature',
    'essential',
  };

  Never _invalid() => throw const FinanceFailure(
    'invalid_backup',
    'Esta cópia não é compatível ou contém registros inconsistentes. Seus dados atuais foram preservados.',
  );

  Future<String> export() => db.transaction(() async {
    final data = <String, Object?>{};
    for (final table in tables.keys) {
      data[table] =
          (await db.customSelect('SELECT * FROM $table ORDER BY id').get())
              .map((row) => row.data)
              .toList();
    }
    final content = const JsonEncoder.withIndent('  ').convert({
      'application': 'canguruu_finance',
      'format_version': formatVersion,
      'schema_version': db.schemaVersion,
      'currency': 'BRL',
      'created_at': clock.utcNow.toUtc().toIso8601String(),
      'tables': data,
    });
    if (utf8.encode(content).length > maxBytes) {
      throw const FinanceFailure(
        'backup_too_large',
        'A cópia excede o limite de 10 MB desta versão.',
      );
    }
    return content;
  });

  Map<String, List<_Row>> _decode(String content) {
    if (content.length > maxBytes || utf8.encode(content).length > maxBytes) {
      _invalid();
    }
    final raw = jsonDecode(content);
    if (raw is! Map<String, dynamic> ||
        raw['application'] != 'canguruu_finance' ||
        raw['format_version'] != formatVersion ||
        ![1, 2, db.schemaVersion].contains(raw['schema_version']) ||
        raw['currency'] != 'BRL' ||
        raw['created_at'] is! String ||
        DateTime.tryParse(raw['created_at'] as String) == null ||
        raw['tables'] is! Map<String, dynamic>) {
      _invalid();
    }
    final data = Map<String, dynamic>.from(
      raw['tables'] as Map<String, dynamic>,
    );
    if (raw['schema_version'] != db.schemaVersion) {
      if ((raw['schema_version'] as int) < 4) {
        for (final table in goalTableNames) {
          final rows = data[table];
          if (rows is List && rows.isNotEmpty) _invalid();
          data.remove(table);
        }
      }
      final missing = [
        if ((raw['schema_version'] as int) < 3) ...scheduleTableNames,
        if ((raw['schema_version'] as int) < 4) ...goalTableNames,
        if (raw['schema_version'] == 1) ...cardTableNames,
      ];
      final originalTables = tables.keys.where((t) => !missing.contains(t));
      if (data.length != originalTables.length ||
          !originalTables.every(data.containsKey)) {
        _invalid();
      }
      for (final table in missing) {
        data[table] = <Object>[];
      }
    }
    if (data.length != tables.length || !tables.keys.every(data.containsKey)) {
      _invalid();
    }
    final result = <String, List<_Row>>{};
    for (final table in tables.entries) {
      if (data[table.key] is! List) _invalid();
      result[table.key] = [];
      for (final rawRow in data[table.key] as List) {
        if (rawRow is! Map<String, dynamic> ||
            rawRow.length != table.value.length ||
            !table.value.every(rawRow.containsKey)) {
          _invalid();
        }
        final row = Map<String, Object?>.from(rawRow);
        for (final column in table.value) {
          final value = row[column];
          if (value == null && _nullable.contains(column)) continue;
          if (_integers.contains(column)) {
            if (value is! int || value.abs() > Money.maxCents) _invalid();
          } else if (value is! String || value.isEmpty || value.length > 1024) {
            _invalid();
          }
          if ((column == 'id' ||
                  column.endsWith('_id') ||
                  column == 'idempotency_key') &&
              value is String &&
              value.length > 80) {
            _invalid();
          }
          if (column.endsWith('_at') &&
              (value is! String ||
                  !value.endsWith('Z') ||
                  DateTime.tryParse(value) == null)) {
            _invalid();
          }
        }
        result[table.key]!.add(row);
      }
    }
    _validateGraph(result);
    return result;
  }

  void _validateGraph(Map<String, List<_Row>> data) {
    Map<String, _Row> index(String table) {
      final rows = data[table]!;
      final result = {for (final row in rows) row['id'] as String: row};
      if (result.length != rows.length) _invalid();
      return result;
    }

    final profile = data['profiles']!;
    if (profile.length != 1 ||
        profile.single['id'] != 'local' ||
        profile.single['currency'] != 'BRL' ||
        profile.single['locale'] != 'pt_BR' ||
        profile.single['timezone'] != 'America/Sao_Paulo') {
      _invalid();
    }
    for (final table in data.entries.where((t) => t.key != 'profiles')) {
      for (final row in table.value) {
        if (row['profile_id'] != 'local') _invalid();
      }
    }
    final ledgers = index('ledger_accounts');
    final accounts = index('accounts');
    final categories = index('categories');
    final events = index('financial_events');
    final receipts = index('operation_receipts');
    final cards = index('credit_cards');
    for (final kind in ['income', 'expense', 'equity']) {
      if (ledgers['system-$kind']?['kind'] != kind) _invalid();
    }
    if (ledgers.length != accounts.length + cards.length + 3) _invalid();
    final balances = <String, List<Money>>{};
    for (final row in accounts.values) {
      if (ledgers[row['id']]?['kind'] != 'asset') _invalid();
      final date = CivilDate.parse(row['opened_on'] as String);
      if (date.isAfter(clock.today)) _invalid();
    }
    for (final category in categories.values) {
      final parentId = category['parent_id'];
      if (parentId != null) {
        final parent = categories[parentId];
        if (parent == null ||
            parent['parent_id'] != null ||
            parent['kind'] != category['kind']) {
          _invalid();
        }
      }
    }
    final postings = <String, List<_Row>>{};
    for (final posting in data['postings']!) {
      if (!events.containsKey(posting['event_id']) ||
          !ledgers.containsKey(posting['ledger_account_id'])) {
        _invalid();
      }
      if (posting['category_id'] != null &&
          !categories.containsKey(posting['category_id'])) {
        _invalid();
      }
      (postings[posting['event_id'] as String] ??= []).add(posting);
    }
    final initialAccounts = <String>{};
    final monthsIncome = <String, List<Money>>{};
    final monthsExpense = <String, List<Money>>{};
    for (final event in events.values) {
      final date = CivilDate.parse(event['effective_date'] as String);
      if (date.isAfter(clock.today)) _invalid();
      final items = postings[event['id']] ?? [];
      items.sort(
        (a, b) => (a['sequence'] as int).compareTo(b['sequence'] as int),
      );
      if (items.length != 2 ||
          items[0]['sequence'] != 0 ||
          items[1]['sequence'] != 1 ||
          items[0]['ledger_account_id'] == items[1]['ledger_account_id'] ||
          items.any((p) => p['amount_cents'] == 0) ||
          Money.sum(items.map((p) => Money(p['amount_cents'] as int))).cents !=
              0) {
        _invalid();
      }
      final assets = items
          .where((p) => accounts.containsKey(p['ledger_account_id']))
          .toList();
      for (final posting in items) {
        final account = accounts[posting['ledger_account_id']];
        if (account != null) {
          if (date.isBefore(CivilDate.parse(account['opened_on'] as String)) ||
              posting['category_id'] != null ||
              posting['cost_nature'] != null ||
              posting['essential'] != null) {
            _invalid();
          }
          (balances[account['id'] as String] ??= []).add(
            Money(posting['amount_cents'] as int),
          );
        }
        final month = date.monthStart.toString();
        if (posting['ledger_account_id'] == 'system-income') {
          (monthsIncome[month] ??= []).add(
            Money(-(posting['amount_cents'] as int)),
          );
        }
        if (posting['ledger_account_id'] == 'system-expense') {
          (monthsExpense[month] ??= []).add(
            Money(posting['amount_cents'] as int),
          );
        }
      }
      final kind = event['kind'];
      if (kind == 'reversal') {
        final original = events[event['reversal_of']];
        final source = postings[event['reversal_of']];
        if (original == null ||
            source == null ||
            source.length != 2 ||
            !['income', 'expense', 'transfer'].contains(original['kind']) ||
            date.isBefore(
              CivilDate.parse(original['effective_date'] as String),
            )) {
          _invalid();
        }
        final ordered = [...source]
          ..sort(
            (a, b) => (a['sequence'] as int).compareTo(b['sequence'] as int),
          );
        for (var i = 0; i < 2; i++) {
          for (final field in [
            'ledger_account_id',
            'category_id',
            'cost_nature',
            'essential',
          ]) {
            if (items[i][field] != ordered[i][field]) _invalid();
          }
          if (items[i]['amount_cents'] !=
              -(ordered[i]['amount_cents'] as int)) {
            _invalid();
          }
        }
      } else if (kind == 'transfer') {
        if (assets.length != 2) _invalid();
      } else if (kind == 'opening_balance') {
        if (assets.length != 1 ||
            !initialAccounts.add(
              assets.single['ledger_account_id'] as String,
            ) ||
            accounts[assets.single['ledger_account_id']]!['opened_on'] !=
                event['effective_date']) {
          _invalid();
        }
        final equity = items
            .where((p) => p['ledger_account_id'] == 'system-equity')
            .firstOrNull;
        if (equity == null ||
            equity['category_id'] != null ||
            equity['cost_nature'] != null ||
            equity['essential'] != null) {
          _invalid();
        }
      } else if (kind == 'income' || kind == 'expense') {
        final expense = kind == 'expense';
        final system = items
            .where((p) => p['ledger_account_id'] == 'system-$kind')
            .firstOrNull;
        if (assets.length != 1 ||
            system == null ||
            (system['amount_cents'] as int) * (expense ? 1 : -1) <= 0 ||
            categories[system['category_id']]?['kind'] != kind) {
          _invalid();
        }
        if (expense &&
            (system['cost_nature'] == null || system['essential'] == null)) {
          _invalid();
        }
        if (!expense &&
            (system['cost_nature'] != null || system['essential'] != null)) {
          _invalid();
        }
      } else if (![
        'card_purchase',
        'card_opening',
        'card_payment',
      ].contains(kind)) {
        _invalid();
      }
      final receipt = receipts[event['idempotency_key']];
      if (receipt == null) _invalid();
      if (kind == 'card_opening') {
        final operation = data['card_operations']!
            .where((o) => o['id'] == event['id'])
            .firstOrNull;
        if (receipt['command'] != 'create_card' ||
            receipt['result_id'] != operation?['card_id']) {
          _invalid();
        }
      } else if (kind == 'card_purchase' || kind == 'card_payment') {
        if (receipt['result_id'] != event['id'] ||
            receipt['command'] !=
                (kind == 'card_purchase' ? 'purchase' : 'pay_invoice')) {
          _invalid();
        }
      } else if (kind == 'opening_balance') {
        if (receipt['command'] != 'create_account' ||
            receipt['result_id'] != assets.single['ledger_account_id']) {
          _invalid();
        }
      } else if (receipt['result_id'] != event['id'] ||
          receipt['command'] != (kind == 'reversal' ? 'reverse' : 'record')) {
        _invalid();
      }
    }
    final totals = <Money>[];
    for (final account in accounts.values) {
      final total = Money.sum(balances[account['id']] ?? []);
      if (account['archived'] == 1 && total.cents != 0) _invalid();
      totals.add(total);
    }
    Money.sum(totals);
    for (final month in {...monthsIncome.keys, ...monthsExpense.keys}) {
      Money.sum(monthsIncome[month] ?? []) -
          Money.sum(monthsExpense[month] ?? []);
    }
    for (final receipt in receipts.values) {
      if (!RegExp(
        r'^[0-9a-f]{64}$',
      ).hasMatch(receipt['fingerprint'] as String)) {
        _invalid();
      }
      final command = receipt['command'];
      final result = receipt['result_id'];
      if (command == 'create_account' && !accounts.containsKey(result) ||
          command == 'create_category' && !categories.containsKey(result) ||
          command == 'record' &&
              ![
                'income',
                'expense',
                'transfer',
              ].contains(events[result]?['kind']) ||
          command == 'reverse' && events[result]?['kind'] != 'reversal') {
        _invalid();
      }
      if (command == 'create_card' && !cards.containsKey(result) ||
          command == 'purchase' && events[result]?['kind'] != 'card_purchase' ||
          command == 'pay_invoice' &&
              events[result]?['kind'] != 'card_payment') {
        _invalid();
      }
      if (command == 'save_objective' && !index('objectives').containsKey(result) ||
          command == 'save_goal' && !index('goals').containsKey(result) ||
          command == 'move_goal_funds' && !index('goal_fund_movements').containsKey(result) ||
          command == 'set_goal_status' && !index('goals').containsKey(result)) {
        _invalid();
      }
      if (['record', 'reverse', 'purchase', 'pay_invoice'].contains(command) &&
          events[result]?['idempotency_key'] != receipt['id']) {
        _invalid();
      }
    }
    CardBackupValidator(clock).validate(data);
    ScheduleBackupValidator(clock).validate(data);
  }

  Future<void> _insert(
    CanguruuDatabase target,
    Map<String, List<_Row>> data,
  ) async {
    await target.customStatement('PRAGMA defer_foreign_keys = ON');
    for (final table in tables.entries) {
      for (final row in data[table.key]!) {
        await target.customStatement(
          'INSERT INTO ${table.key} (${table.value.join(',')}) VALUES (${List.filled(table.value.length, '?').join(',')})',
          table.value.map((column) => row[column]).toList(),
        );
      }
    }
    if ((await target.customSelect('PRAGMA foreign_key_check').get())
        .isNotEmpty) {
      _invalid();
    }
  }

  Future<Map<String, List<_Row>>> _validated(String content) async {
    try {
      final data = _decode(content);
      final temporary = ValidationDatabase(await validationExecutor());
      try {
        await temporary.transaction(() => _insert(temporary, data));
      } finally {
        await temporary.close();
      }
      return data;
    } catch (_) {
      _invalid();
    }
  }

  Future<BackupSummary> inspect(String content) async {
    final data = await _validated(content);
    final raw = jsonDecode(content) as Map<String, dynamic>;
    return BackupSummary(
      data['accounts']!.length,
      data['financial_events']!.length,
      DateTime.parse(raw['created_at'] as String),
      cards: data['credit_cards']!.length,
      scheduled: data['scheduled_occurrences']!.length,
    );
  }

  Future<void> restore(String content) async {
    final data = await _validated(content);
    await db.transaction(() async {
      await db.customStatement('PRAGMA defer_foreign_keys = ON');
      for (final table in tables.keys.toList().reversed) {
        await db.customStatement('DELETE FROM $table');
      }
      await _insert(db, data);
      db.changed();
    });
  }
}
