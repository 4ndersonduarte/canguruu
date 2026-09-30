import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../shared/presentation/components.dart';
import '../../../shared/presentation/formatters.dart';
import '../domain/models.dart';
import 'forms.dart';

class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => FinanceView(
    builder: (snapshot) => PageBody(
      children: [
        PageHeading(
          'Suas contas',
          'Bancos e dinheiro na carteira, no mesmo lugar.',
          action: FilledButton.icon(
            onPressed: () => showAccountForm(context),
            icon: const CanguruuIcon(Icons.add, size: 18),
            label: const Text('Adicionar conta'),
          ),
        ),
        if (snapshot.accounts.isEmpty)
          const EmptyCard(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Onde está seu dinheiro?',
            message:
                'Adicione uma conta bancária ou uma carteira. O saldo inicial será o ponto de partida do seu histórico.',
          )
        else
          LayoutBuilder(
            builder: (context, constraints) => Wrap(
              spacing: 18,
              runSpacing: 18,
              children: snapshot.accounts
                  .map(
                    (account) => SizedBox(
                      width: constraints.maxWidth < 620
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 18) / 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: CanguruuColors.offWhite,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: CanguruuIcon(
                                      account.kind == AccountKind.bank
                                          ? Icons.account_balance_outlined
                                          : Icons.wallet_outlined,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (account.archived)
                                    const Chip(label: Text('Arquivada'))
                                  else
                                    PopupMenuButton<String>(
                                      tooltip: 'Opções da conta',
                                      itemBuilder: (_) => [
                                        const PopupMenuItem(
                                          value: 'archive',
                                          child: Text('Arquivar conta'),
                                        ),
                                      ],
                                      onSelected: (_) async {
                                        final confirmed = await showDialog<bool>(
                                          context: context,
                                          builder: (dialogContext) => AlertDialog(
                                            title: const Text(
                                              'Arquivar conta?',
                                            ),
                                            content: Text(
                                              '“${account.name}” sairá das opções de novos lançamentos. O histórico será preservado. A conta precisa estar com saldo zero.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  dialogContext,
                                                  false,
                                                ),
                                                child: const Text('Cancelar'),
                                              ),
                                              FilledButton(
                                                onPressed: () => Navigator.pop(
                                                  dialogContext,
                                                  true,
                                                ),
                                                child: const Text('Arquivar'),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirmed != true) return;
                                        try {
                                          await ref
                                              .read(repositoryProvider)
                                              .archiveAccount(account.id);
                                          if (context.mounted) {
                                            notifyUser(
                                              context,
                                              'Conta arquivada.',
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            notifyUser(
                                              context,
                                              friendlyError(e),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(height: 22),
                              Text(
                                account.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                account.kind == AccountKind.bank
                                    ? 'Conta bancária'
                                    : 'Dinheiro / carteira',
                                style: const TextStyle(
                                  color: CanguruuColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 24),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  formatMoney(
                                    account.balance,
                                    hidden: ref.watch(hiddenAmountsProvider),
                                  ),
                                  style: CanguruuType.amount.copyWith(
                                    fontSize: 28,
                                    color: account.balance.cents < 0
                                        ? CanguruuColors.red
                                        : CanguruuColors.ink,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Histórico a partir de ${account.openedOn.display}',
                                style: const TextStyle(
                                  color: CanguruuColors.muted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        const SizedBox(height: 24),
        const Text(
          'Os saldos são calculados a partir do histórico. Registrar uma transferência move o valor entre duas contas.',
          style: TextStyle(color: CanguruuColors.muted, fontSize: 12),
        ),
      ],
    ),
  );
}
