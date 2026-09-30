import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/money.dart';
import '../../../shared/presentation/components.dart';
import '../../../shared/presentation/formatters.dart';
import '../domain/models.dart';

String eventLabel(String kind) => switch (kind) {
  'income' => 'Receita',
  'expense' => 'Despesa',
  'transfer' => 'Transferência',
  'opening_balance' => 'Saldo inicial',
  'reversal' => 'Estorno',
  'card_purchase' => 'Compra no cartão',
  'card_payment' => 'Pagamento de fatura',
  'card_opening' => 'Dívida inicial',
  _ => 'Movimentação',
};

class EventTile extends ConsumerWidget {
  const EventTile({super.key, required this.event, required this.snapshot});
  final FinancialEvent event;
  final FinanceSnapshot snapshot;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hidden = ref.watch(hiddenAmountsProvider);
    final category = event.entries
        .map((e) => e.categoryId)
        .whereType<String>()
        .firstOrNull;
    final assets = event.entries
        .where((e) => snapshot.accounts.any((a) => a.id == e.accountId))
        .toList();
    final accountText = event.kind == 'transfer'
        ? '${snapshot.accountName(assets.where((a) => a.cents < 0).first.accountId)} → ${snapshot.accountName(assets.where((a) => a.cents > 0).first.accountId)}'
        : assets.isEmpty
        ? event.entries
              .map((e) => snapshot.cardNames[e.accountId])
              .whereType<String>()
              .join('')
        : snapshot.accountName(assets.first.accountId);
    final icon = switch (event.kind) {
      'income' => Icons.south_west_rounded,
      'expense' => Icons.north_east_rounded,
      'transfer' => Icons.swap_horiz_rounded,
      'reversal' => Icons.undo_rounded,
      'card_purchase' ||
      'card_payment' ||
      'card_opening' => Icons.credit_card_outlined,
      _ => Icons.account_balance_wallet_outlined,
    };
    final color = event.kind == 'income'
        ? CanguruuColors.green
        : ['expense', 'card_purchase', 'card_payment'].contains(event.kind)
        ? CanguruuColors.red
        : CanguruuColors.muted;
    final signed =
        ['expense', 'card_purchase', 'card_payment'].contains(event.kind)
        ? Money(-event.amount.cents)
        : event.amount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CanguruuIcon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  '${event.date.display} · $accountText${category == null ? '' : ' · ${snapshot.categoryName(category)}'}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: CanguruuColors.muted,
                  ),
                ),
                if (event.reversed)
                  const Text(
                    'Estornada · original preservado',
                    style: TextStyle(fontSize: 11, color: CanguruuColors.muted),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatMoney(signed, hidden: hidden),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    Text(
                      eventLabel(event.kind),
                      style: const TextStyle(
                        fontSize: 10,
                        color: CanguruuColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!event.reversed &&
              ['income', 'expense', 'transfer'].contains(event.kind))
            PopupMenuButton<String>(
              tooltip: 'Opções da movimentação',
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'reverse',
                  child: Text('Estornar movimentação'),
                ),
              ],
              onSelected: (_) async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Estornar movimentação?'),
                    content: Text(
                      '“${event.description}” será compensada na data de hoje. O registro original permanecerá no histórico.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: const Text('Cancelar'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: const Text('Estornar'),
                      ),
                    ],
                  ),
                );
                if (confirmed != true) return;
                try {
                  await ref
                      .read(repositoryProvider)
                      .reverse(
                        requestId: const Uuid().v4(),
                        eventId: event.id,
                        date: ref.read(clockProvider).today,
                      );
                  if (context.mounted) {
                    notifyUser(
                      context,
                      'Estorno registrado. O histórico foi preservado.',
                    );
                  }
                } catch (e) {
                  if (context.mounted) notifyUser(context, friendlyError(e));
                }
              },
            ),
        ],
      ),
    );
  }
}
