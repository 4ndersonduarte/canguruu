import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../core/civil_date.dart';
import '../core/failure.dart';
import '../core/money.dart';
import '../features/finance/domain/models.dart';
import '../features/finance/domain/services/ledger_rules.dart';
import 'database.dart' show CanguruuDatabase;

/// Shared atomic boundary for financial events and their module-specific records.
final class LedgerWriter {
  LedgerWriter(this.db, this.clock, this.newId);
  final CanguruuDatabase db;
  final Clock clock;
  final String Function() newId;
  String get _now => clock.utcNow.toUtc().toIso8601String();
  Future<String> command(
    String requestId,
    String command,
    List<Object?> payload,
    Future<String> Function() operation,
  ) async {
    if (requestId.isEmpty || requestId.length > 80) {
      throw const FinanceFailure(
        'invalid_request',
        'Identificador de operação inválido.',
      );
    }
    final fingerprint = sha256
        .convert(utf8.encode(jsonEncode([command, ...payload])))
        .toString();
    return db.transaction(() async {
      final receipts = await db
          .customSelect('SELECT * FROM operation_receipts')
          .get();
      final previous = receipts
          .where((r) => r.data['id'] == requestId)
          .firstOrNull;
      if (previous != null) {
        if (previous.data['fingerprint'] != fingerprint ||
            previous.data['command'] != command) {
          throw const FinanceFailure(
            'idempotency_conflict',
            'Esta operação já foi usada com outros dados. Abra um novo lançamento.',
          );
        }
        return previous.data['result_id'] as String;
      }
      final result = await operation();
      // Overflow checks happen before the transaction can commit.
      await validateTotals();
      await db.customStatement(
        'INSERT INTO operation_receipts VALUES (?,?,?,?,?,?)',
        [requestId, 'local', command, fingerprint, result, _now],
      );
      db.changed();
      return result;
    });
  }

  Future<String> event(
    String requestId,
    String kind,
    CivilDate date,
    String description,
    List<LedgerEntry> entries, {
    String? reversalOf,
  }) async {
    LedgerRules.balanced(entries);
    final id = newId();
    await db.customStatement(
      'INSERT INTO financial_events (id,profile_id,kind,effective_date,description,idempotency_key,reversal_of,created_at) VALUES (?,?,?,?,?,?,?,?)',
      [id, 'local', kind, '$date', description, requestId, reversalOf, _now],
    );
    for (var i = 0; i < entries.length; i++) {
      final p = entries[i];
      await db.customStatement(
        'INSERT INTO postings (id,profile_id,event_id,ledger_account_id,sequence,amount_cents,category_id,cost_nature,essential) VALUES (?,?,?,?,?,?,?,?,?)',
        [
          newId(),
          'local',
          id,
          p.accountId,
          i,
          p.cents,
          p.categoryId,
          p.costNature?.name,
          p.essential == null ? null : (p.essential! ? 1 : 0),
        ],
      );
    }
    return id;
  }

  Future<void> validateTotals() async {
    final rows = await db.customSelect('''
      SELECT p.ledger_account_id, p.amount_cents, l.kind, e.effective_date
      FROM postings p JOIN ledger_accounts l ON l.id=p.ledger_account_id
      JOIN financial_events e ON e.id=p.event_id
    ''').get();
    final accounts = <String, List<Money>>{};
    final income = <String, List<Money>>{};
    final expense = <String, List<Money>>{};
    final assets = <Money>[];
    final liabilities = <Money>[];
    for (final row in rows) {
      final r = row.data;
      final amount = Money(r['amount_cents'] as int);
      final month = (r['effective_date'] as String).substring(0, 7);
      (accounts[r['ledger_account_id'] as String] ??= []).add(amount);
      switch (r['kind']) {
        case 'asset':
          assets.add(amount);
        case 'liability':
          liabilities.add(amount);
        case 'income':
          (income[month] ??= []).add(Money(-amount.cents));
        case 'expense':
          (expense[month] ??= []).add(amount);
      }
    }
    for (final entries in accounts.values) {
      Money.sum(entries);
    }
    final balance = Money.sum(assets);
    final debt = Money.sum(liabilities);
    balance + debt;
    for (final month in {...income.keys, ...expense.keys}) {
      Money.sum(income[month] ?? []) - Money.sum(expense[month] ?? []);
    }
  }
}
