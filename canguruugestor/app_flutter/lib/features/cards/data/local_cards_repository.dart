import 'package:uuid/uuid.dart';
import '../../../core/civil_date.dart';
import '../../../core/failure.dart';
import '../../../core/money.dart';
import '../../../persistence/database.dart' show CanguruuDatabase;
import '../../../persistence/ledger_writer.dart';
import '../../finance/domain/models.dart';
import '../../finance/domain/services/ledger_rules.dart';
import '../domain/models.dart';
import '../domain/repositories/cards_repository.dart';
import '../domain/services/card_rules.dart';

final class LocalCardsRepository implements CardsRepository {
  LocalCardsRepository(this.db, this.clock, {String Function()? newId})
    : newId = newId ?? const Uuid().v4;
  final CanguruuDatabase db;
  final Clock clock;
  final String Function() newId;
  LedgerWriter get _writer => LedgerWriter(db, clock, newId);
  String get _now => clock.utcNow.toUtc().toIso8601String();

  @override
  Stream<CardsSnapshot> watch() => db
      .customSelect(
        'SELECT count(*) FROM financial_events',
        readsFrom: db.allTables.toSet(),
      )
      .watch()
      .asyncMap((_) => read());

  @override
  Future<CardsSnapshot> read({CivilDate? asOf}) =>
      db.transaction(() => _read(asOf ?? clock.today));

  Future<List<Map<String, Object?>>> _rows(String table) async =>
      (await db.customSelect('SELECT * FROM $table').get())
          .map((r) => r.data)
          .toList();

  Future<CardsSnapshot> _read(CivilDate asOf) async {
    final events = {
      for (final r in await _rows('financial_events'))
        if (!CivilDate.parse(r['effective_date'] as String).isAfter(asOf))
          r['id']: r,
    };
    final sums = <String, List<Money>>{};
    for (final p in await _rows('postings')) {
      if (events.containsKey(p['event_id'])) {
        (sums[p['ledger_account_id'] as String] ??= []).add(
          Money(p['amount_cents'] as int),
        );
      }
    }
    final cards =
        (await _rows('credit_cards'))
            .where(
              (r) => !CivilDate.parse(r['opened_on'] as String).isAfter(asOf),
            )
            .map(
              (r) => CreditCard(
                id: r['id'] as String,
                name: r['name'] as String,
                openedOn: CivilDate.parse(r['opened_on'] as String),
                totalLimit: Money(r['limit_cents'] as int),
                debt: Money(-Money.sum(sums[r['id']] ?? []).cents),
                closingDay: r['closing_day'] as int,
                dueDay: r['due_day'] as int,
                policy: ClosingPolicy.values.byName(
                  r['closing_policy'] as String,
                ),
              ),
            )
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
    final operations = {
      for (final r in await _rows('card_operations'))
        if (events.containsKey(r['id']))
          r['id'] as String: CardOperation(
            id: r['id'] as String,
            cardId: r['card_id'] as String,
            description: events[r['id']]!['description'] as String,
            date: CivilDate.parse(events[r['id']]!['effective_date'] as String),
            billingOn: CivilDate.parse(r['billing_on'] as String),
            total: Money(r['total_cents'] as int),
            count: r['installment_count'] as int,
            openingDebt: r['kind'] == 'opening_debt',
            reconciled: r['reconciled'] == 1,
          ),
    };
    final itemRows = await _rows('invoice_items');
    final paymentRows = {
      for (final r in await _rows('invoice_payments')) r['id']: r,
    };
    final allocations = await _rows('invoice_payment_allocations');
    final invoices =
        (await _rows('invoices'))
            .where((r) => cards.any((c) => c.id == r['card_id']))
            .map(
              (r) => CardInvoice(
                id: r['id'] as String,
                cardId: r['card_id'] as String,
                closingOn: CivilDate.parse(r['closing_on'] as String),
                dueOn: CivilDate.parse(r['due_on'] as String),
                items: [
                  for (final item in itemRows)
                    if (item['invoice_id'] == r['id'] &&
                        operations.containsKey(item['operation_id']))
                      InvoiceItem(
                        id: item['id'] as String,
                        operation: operations[item['operation_id']]!,
                        sequence: item['sequence'] as int,
                        amount: Money(item['amount_cents'] as int),
                      ),
                ],
                payments: [
                  for (final allocation in allocations)
                    if (allocation['invoice_id'] == r['id'] &&
                        events.containsKey(allocation['payment_id']))
                      InvoicePayment(
                        id: allocation['payment_id'] as String,
                        date: CivilDate.parse(
                          events[allocation['payment_id']]!['effective_date']
                              as String,
                        ),
                        accountId:
                            paymentRows[allocation['payment_id']]!['account_id']
                                as String,
                        amount: Money(allocation['amount_cents'] as int),
                      ),
                ],
              ),
            )
            .where((i) => i.items.isNotEmpty || i.payments.isNotEmpty)
            .toList()
          ..sort((a, b) => a.closingOn.compareTo(b.closingOn));
    return CardsSnapshot(
      cards: cards,
      operations: operations.values.toList(),
      invoices: invoices,
      asOf: asOf,
    );
  }

  @override
  Future<String> createCard({
    required String requestId,
    required String name,
    required Money totalLimit,
    required int closingDay,
    required int dueDay,
    required ClosingPolicy policy,
    required CivilDate openedOn,
    Money openingDebt = Money.zero,
  }) {
    final validName = LedgerRules.name(name);
    LedgerRules.effectiveDate(openedOn, clock);
    CardRules.days(closingDay, dueDay);
    if (totalLimit.cents < 0 || openingDebt.cents < 0) {
      throw const FinanceFailure(
        'invalid_amount',
        'Limite e dívida inicial não podem ser negativos.',
      );
    }
    return _writer.command(
      requestId,
      'create_card',
      [
        validName,
        totalLimit.cents,
        closingDay,
        dueDay,
        policy.name,
        '$openedOn',
        openingDebt.cents,
      ],
      () async {
        final id = newId();
        await db.customStatement(
          'INSERT INTO ledger_accounts VALUES (?,?,?,?)',
          [id, 'local', 'liability', _now],
        );
        await db.customStatement(
          '''
          INSERT INTO credit_cards (id,profile_id,name,opened_on,limit_cents,closing_day,
            due_day,closing_policy,created_at,updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)
        ''',
          [
            id,
            'local',
            validName,
            '$openedOn',
            totalLimit.cents,
            closingDay,
            dueDay,
            policy.name,
            _now,
            _now,
          ],
        );
        if (openingDebt.cents > 0) {
          final eventId = await _writer.event(
            requestId,
            'card_opening',
            openedOn,
            'Dívida inicial · $validName',
            [
              LedgerEntry(accountId: 'system-equity', cents: openingDebt.cents),
              LedgerEntry(accountId: id, cents: -openingDebt.cents),
            ],
          );
          await _operation(
            eventId,
            id,
            'opening_debt',
            openedOn,
            openingDebt,
            1,
            true,
            CardRules.schedule(openedOn, 1, closingDay, dueDay, policy),
          );
        }
        return id;
      },
    );
  }

  @override
  Future<String> purchase({
    required String requestId,
    required String cardId,
    required String categoryId,
    required String description,
    required Money total,
    required int installments,
    required CivilDate date,
    required CivilDate billingOn,
    bool confirmClosedCycle = false,
    CostNature? costNatureSnapshot,
    bool? essentialSnapshot,
  }) {
    if ((costNatureSnapshot == null) != (essentialSnapshot == null)) {
      throw const FinanceFailure(
        'invalid_classification',
        'Classificação da previsão inválida.',
      );
    }
    final validDescription = LedgerRules.name(description, max: 160);
    LedgerRules.effectiveDate(date, clock);
    LedgerRules.effectiveDate(billingOn, clock);
    CardRules.installments(total, installments);
    return _writer.command(
      requestId,
      'purchase',
      [
        cardId,
        categoryId,
        validDescription,
        total.cents,
        installments,
        '$date',
        '$billingOn',
        confirmClosedCycle,
        if (costNatureSnapshot != null) ...[
          'classification_snapshot',
          costNatureSnapshot.name,
          essentialSnapshot,
        ],
      ],
      () async {
        final snapshot = await _read(clock.today);
        final card = snapshot.cards.where((c) => c.id == cardId).firstOrNull;
        final category = (await _rows(
          'categories',
        )).where((c) => c['id'] == categoryId).firstOrNull;
        if (card == null ||
            category == null ||
            category['kind'] != 'expense' ||
            category['archived'] == 1) {
          throw const FinanceFailure(
            'invalid_reference',
            'Escolha um cartão e uma categoria de despesa disponíveis.',
          );
        }
        if (date.isBefore(card.openedOn) || billingOn.isBefore(date)) {
          throw const FinanceFailure(
            'invalid_date',
            'A compra deve ser posterior ao início do cartão e o processamento não pode anteceder a compra.',
          );
        }
        final cycles = CardRules.schedule(
          billingOn,
          installments,
          card.closingDay,
          card.dueDay,
          card.policy,
        );
        if (cycles.first.closingOn.isBefore(clock.today) &&
            !confirmClosedCycle) {
          throw const FinanceFailure(
            'closed_cycle',
            'Confira e confirme as datas para incluir uma compra em ciclo já encerrado.',
          );
        }
        final id = await _writer
            .event(requestId, 'card_purchase', date, validDescription, [
              LedgerEntry(
                accountId: 'system-expense',
                cents: total.cents,
                categoryId: categoryId,
                costNature:
                    costNatureSnapshot ??
                    CostNature.values.byName(category['cost_nature'] as String),
                essential: essentialSnapshot ?? (category['essential'] == 1),
              ),
              LedgerEntry(accountId: cardId, cents: -total.cents),
            ]);
        await _operation(
          id,
          cardId,
          'purchase',
          billingOn,
          total,
          installments,
          confirmClosedCycle,
          cycles,
        );
        return id;
      },
    );
  }

  Future<void> _operation(
    String id,
    String cardId,
    String kind,
    CivilDate billingOn,
    Money total,
    int count,
    bool reconciled,
    List<BillingCycle> cycles,
  ) async {
    await db.customStatement(
      'INSERT INTO card_operations VALUES (?,?,?,?,?,?,?,?)',
      [
        id,
        'local',
        cardId,
        kind,
        '$billingOn',
        count,
        total.cents,
        reconciled ? 1 : 0,
      ],
    );
    final values = CardRules.installments(total, count);
    final existing = await _rows('invoices');
    for (var i = 0; i < count; i++) {
      final cycle = cycles[i];
      final previous = existing
          .where(
            (r) =>
                r['card_id'] == cardId &&
                r['closing_on'] == '${cycle.closingOn}',
          )
          .firstOrNull;
      final invoiceId = previous?['id'] as String? ?? newId();
      if (previous == null) {
        await db.customStatement('INSERT INTO invoices VALUES (?,?,?,?,?)', [
          invoiceId,
          'local',
          cardId,
          '${cycle.closingOn}',
          '${cycle.dueOn}',
        ]);
      }
      await db.customStatement(
        'INSERT INTO invoice_items VALUES (?,?,?,?,?,?)',
        [newId(), 'local', id, invoiceId, i + 1, values[i].cents],
      );
    }
  }

  @override
  Future<String> payInvoice({
    required String requestId,
    required String invoiceId,
    required String accountId,
    required Money amount,
    required CivilDate date,
  }) {
    LedgerRules.effectiveDate(date, clock);
    if (amount.cents <= 0) {
      throw const FinanceFailure(
        'invalid_amount',
        'Informe um pagamento maior que zero.',
      );
    }
    return _writer.command(
      requestId,
      'pay_invoice',
      [invoiceId, accountId, amount.cents, '$date'],
      () async {
        // Validate both historical availability and current remaining debt, inside the same transaction.
        final atDate = await _read(date);
        final current = date == clock.today ? atDate : await _read(clock.today);
        final invoice = atDate.invoices
            .where((i) => i.id == invoiceId)
            .firstOrNull;
        final live = current.invoices
            .where((i) => i.id == invoiceId)
            .firstOrNull;
        final account = (await _rows(
          'accounts',
        )).where((a) => a['id'] == accountId).firstOrNull;
        if (invoice == null ||
            live == null ||
            account == null ||
            account['archived'] == 1 ||
            date.isBefore(CivilDate.parse(account['opened_on'] as String))) {
          throw const FinanceFailure(
            'invalid_payment',
            'A fatura ou a conta não está disponível nesta data.',
          );
        }
        if (amount.cents > invoice.balance.cents ||
            amount.cents > live.availableForPayment(date).cents) {
          throw const FinanceFailure(
            'excess_payment',
            'O pagamento excede o saldo disponível na fatura ou em uma data posterior já registrada. Confira o valor e a data.',
          );
        }
        final card = current.cards.singleWhere((c) => c.id == invoice.cardId);
        final id = await _writer.event(
          requestId,
          'card_payment',
          date,
          'Pagamento de fatura · ${card.name}',
          [
            LedgerEntry(accountId: invoice.cardId, cents: amount.cents),
            LedgerEntry(accountId: accountId, cents: -amount.cents),
          ],
        );
        await db.customStatement(
          'INSERT INTO invoice_payments VALUES (?,?,?,?,?)',
          [id, 'local', invoice.cardId, accountId, amount.cents],
        );
        await db.customStatement(
          'INSERT INTO invoice_payment_allocations VALUES (?,?,?,?,?)',
          [newId(), 'local', id, invoiceId, amount.cents],
        );
        return id;
      },
    );
  }
}
