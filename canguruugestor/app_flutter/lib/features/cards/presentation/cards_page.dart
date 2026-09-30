import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';

import '../../../shared/presentation/components.dart';
import '../../../shared/presentation/formatters.dart';
import '../../finance/domain/models.dart';
import '../../finance/presentation/forms.dart' show showAccountForm;
import '../domain/models.dart';
import 'card_forms.dart';

class CardsPage extends ConsumerStatefulWidget {
  const CardsPage({super.key});
  @override
  ConsumerState<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends ConsumerState<CardsPage> {
  String? selectedId;
  String filter = 'pending';
  int visible = 12;
  @override
  Widget build(BuildContext context) => FinanceView(
    builder: (finance) => ref
        .watch(cardsSnapshotProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(friendlyError(error))),
          data: (snapshot) {
            final hidden = ref.watch(hiddenAmountsProvider);
            final card =
                snapshot.cards.where((c) => c.id == selectedId).firstOrNull ??
                snapshot.cards.firstOrNull;
            final invoices = snapshot.invoices
                .where(
                  (i) =>
                      i.cardId == card?.id &&
                      (filter == 'all' ||
                          filter == 'pending' && i.balance.cents > 0 ||
                          filter == 'future' &&
                              i.closingOn.monthStart.isAfter(
                                // The current cycle is the first closing on or after today.
                                snapshot.asOf.day <= (card?.closingDay ?? 31)
                                    ? snapshot.asOf.monthStart
                                    : snapshot.asOf.monthStart.inMonth(1),
                              )),
                )
                .toList();
            return PageBody(
              children: [
                PageHeading(
                  'Seus cartões',
                  'Entenda o limite de hoje e os compromissos dos próximos meses.',
                  action: FilledButton.icon(
                    onPressed: () => showCardForm(context),
                    icon: const CanguruuIcon(Icons.add, size: 18),
                    label: const Text('Adicionar cartão'),
                  ),
                ),
                if (snapshot.cards.isEmpty)
                  const EmptyCard(
                    icon: Icons.credit_card_outlined,
                    title: 'Mais clareza a cada compra',
                    message:
                        'Cadastre seu cartão para acompanhar o limite, organizar as parcelas e registrar o pagamento das faturas.',
                  )
                else ...[
                  LayoutBuilder(
                    builder: (context, constraints) => Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        for (final c in snapshot.cards)
                          SizedBox(
                            width: constraints.maxWidth < 740
                                ? constraints.maxWidth
                                : (constraints.maxWidth - 16) / 2,
                            child: _CardSummary(
                              card: c,
                              selected: c.id == card!.id,
                              hidden: hidden,
                              onTap: () => setState(() {
                                selectedId = c.id;
                                visible = 12;
                              }),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  SectionLabel(
                    'Faturas · ${card!.name}',
                    trailing: FilledButton.icon(
                      onPressed: () => showPurchaseForm(context, finance, card),
                      icon: const CanguruuIcon(
                        Icons.add_shopping_cart_outlined,
                        size: 17,
                      ),
                      label: const Text('Nova compra'),
                    ),
                  ),
                  Text(
                    'Fecha dia ${card.closingDay} · vence dia ${card.dueDay}. '
                    'Dias inexistentes usam o último dia do mês.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: CanguruuColors.muted,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (!hidden &&
                      snapshot.invoices.any((i) => i.cardId == card.id))
                    _InvoiceChart(
                      invoices: snapshot.invoices
                          .where(
                            (i) => i.cardId == card.id && i.balance.cents > 0,
                          )
                          .take(6)
                          .toList(),
                    ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final choice in {
                        'pending': 'Em aberto',
                        'future': 'Ciclos futuros',
                        'all': 'Todas',
                      }.entries)
                        ChoiceChip(
                          label: Text(choice.value),
                          selected: filter == choice.key,
                          onSelected: (_) => setState(() {
                            filter = choice.key;
                            visible = 12;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (invoices.isEmpty)
                    const EmptyCard(
                      icon: Icons.receipt_long_outlined,
                      title: 'Nenhuma fatura neste filtro',
                      message:
                          'As compras criam os ciclos e as parcelas automaticamente. Consulte “Todas” para ver também os ciclos quitados.',
                    )
                  else ...[
                    for (final invoice in invoices.take(visible)) ...[
                      _InvoiceCard(
                        invoice: invoice,
                        card: card,
                        finance: finance,
                        snapshot: snapshot,
                        hidden: hidden,
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (invoices.length > visible)
                      TextButton(
                        onPressed: () => setState(() => visible += 12),
                        child: const Text('Ver mais faturas'),
                      ),
                  ],
                  const SizedBox(height: 18),
                  Text(
                    'Parcelamentos em aberto em todos os cartões: ${formatMoney(snapshot.installmentCommitment, hidden: hidden)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'O saldo das faturas já faz parte da dívida do cartão. Limite disponível não é dinheiro em conta. '
                    'Os pagamentos são distribuídos internamente entre os itens mais antigos de cada fatura.',
                    style: TextStyle(fontSize: 11, color: CanguruuColors.muted),
                  ),
                ],
              ],
            );
          },
        ),
  );
}

class _CardSummary extends StatelessWidget {
  const _CardSummary({
    required this.card,
    required this.selected,
    required this.hidden,
    required this.onTap,
  });
  final CreditCard card;
  final bool selected, hidden;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : CanguruuColors.ink;
    final muted = selected ? Colors.white70 : CanguruuColors.muted;
    return Material(
      color: selected ? CanguruuColors.ink : Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CanguruuIcon(
                    Icons.credit_card_rounded,
                    color: selected
                        ? CanguruuColors.yellow
                        : CanguruuColors.ink,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      card.name,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (selected)
                    const CanguruuIcon(
                      Icons.check_circle,
                      size: 20,
                      color: CanguruuColors.yellow,
                    ),
                ],
              ),
              const SizedBox(height: 26),
              Text(
                'Disponível para compras',
                style: TextStyle(color: muted, fontSize: 12),
              ),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formatMoney(card.available, hidden: hidden),
                  style: CanguruuType.amount.copyWith(
                    color: foreground,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              if (!hidden)
                LinearProgressIndicator(
                  value: card.utilization?.clamp(0, 1) ?? 0,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(5),
                  backgroundColor: selected
                      ? Colors.white12
                      : CanguruuColors.offWhite,
                  color: card.excess.cents > 0
                      ? CanguruuColors.red
                      : CanguruuColors.yellow,
                  semanticsLabel: 'Utilização do limite',
                  semanticsValue: card.utilization == null
                      ? 'Sem limite cadastrado'
                      : '${(card.utilization! * 100).toStringAsFixed(0)}%',
                ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 20,
                runSpacing: 6,
                children: [
                  Text(
                    'Utilizado: ${formatMoney(card.used, hidden: hidden)}',
                    style: TextStyle(color: muted, fontSize: 12),
                  ),
                  Text(
                    'Total: ${formatMoney(card.totalLimit, hidden: hidden)}',
                    style: TextStyle(color: muted, fontSize: 12),
                  ),
                ],
              ),
              if (card.excess.cents > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    'Acima do limite em ${formatMoney(card.excess, hidden: hidden)}',
                    style: TextStyle(
                      color: selected
                          ? CanguruuColors.yellow
                          : CanguruuColors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (card.totalLimit.cents == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Limite zero · percentual indisponível',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({
    required this.invoice,
    required this.card,
    required this.finance,
    required this.snapshot,
    required this.hidden,
  });
  final CardInvoice invoice;
  final CreditCard card;
  final FinanceSnapshot finance;
  final CardsSnapshot snapshot;
  final bool hidden;
  @override
  Widget build(BuildContext context) {
    final overdue = invoice.overdue(snapshot.asOf);
    final remaining = invoice.remainingByItem;
    final items = [...invoice.items]
      ..sort((a, b) {
        final date = a.operation.billingOn.compareTo(b.operation.billingOn);
        return date != 0 ? date : a.id.compareTo(b.id);
      });
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat(
                                'MMMM yyyy',
                                'pt_BR',
                              ).format(invoice.closingOn.dateTime),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Fecha ${invoice.closingOn.display} · vence ${invoice.dueOn.display}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: CanguruuColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatMoney(invoice.balance, hidden: hidden),
                            style: CanguruuType.amount.copyWith(
                              fontSize: 22,
                              color: overdue
                                  ? CanguruuColors.red
                                  : CanguruuColors.ink,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _Tag(
                        invoice.closed(snapshot.asOf)
                            ? 'Ciclo encerrado'
                            : 'Ciclo aberto',
                      ),
                      _Tag(invoice.settlement(snapshot.asOf)),
                      if (overdue) const _Tag('Vencida', alert: true),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Composição: ${formatMoney(invoice.total, hidden: hidden)} · pago: ${formatMoney(invoice.paid, hidden: hidden)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: CanguruuColors.muted,
                    ),
                  ),
                  if (invoice.balance.cents > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: OutlinedButton.icon(
                        key: ValueKey('pay-${invoice.id}'),
                        onPressed: () => finance.activeAccounts.isEmpty
                            ? showAccountForm(context)
                            : showPaymentForm(context, finance, card, invoice),
                        icon: const CanguruuIcon(Icons.check_rounded, size: 17),
                        label: Text(
                          finance.activeAccounts.isEmpty
                              ? 'Cadastrar conta para pagar'
                              : 'Registrar pagamento',
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text(
                'Ver ${items.length} cobranças e pagamentos',
                style: const TextStyle(fontSize: 12),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.operation.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Parcela ${item.sequence}/${item.operation.count} · compra ${item.operation.date.display}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: CanguruuColors.muted,
                                ),
                              ),
                              if (item.operation.reconciled &&
                                  !item.operation.openingDebt)
                                const Text(
                                  'Ciclo conferido no registro',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: CanguruuColors.muted,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatMoney(item.amount, hidden: hidden),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Pendente: ${formatMoney(remaining[item.id]!, hidden: hidden)}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: CanguruuColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (invoice.payments.isNotEmpty) const Divider(),
                for (final payment in invoice.payments)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${payment.date.display} · ${finance.accountName(payment.accountId)} · pago ${formatMoney(payment.amount, hidden: hidden)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: CanguruuColors.green,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label, {this.alert = false});
  final String label;
  final bool alert;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: alert
          ? CanguruuColors.red.withValues(alpha: .08)
          : CanguruuColors.offWhite,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        color: alert ? CanguruuColors.red : CanguruuColors.muted,
      ),
    ),
  );
}

class _InvoiceChart extends StatelessWidget {
  const _InvoiceChart({required this.invoices});
  final List<CardInvoice> invoices;
  @override
  Widget build(BuildContext context) {
    if (invoices.isEmpty) return const SizedBox.shrink();
    final maximum = invoices
        .map((i) => i.balance.cents)
        .reduce((a, b) => a > b ? a : b);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Faturas por vencimento',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            const Text(
              'Saldo conhecido de até 6 faturas em aberto, incluindo as vencidas',
              style: TextStyle(fontSize: 11, color: CanguruuColors.muted),
            ),
            const SizedBox(height: 18),
            for (final invoice in invoices)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          invoice.dueOn.display,
                          style: const TextStyle(fontSize: 11),
                        ),
                        const Spacer(),
                        Text(
                          formatMoney(invoice.balance),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: maximum == 0 ? 0 : invoice.balance.cents / maximum,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(5),
                      color: CanguruuColors.yellow,
                      backgroundColor: CanguruuColors.offWhite,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
