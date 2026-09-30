import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import '../../../shared/presentation/components.dart';
import 'event_tile.dart';
import 'forms.dart';

class MovementsPage extends StatefulWidget {
  const MovementsPage({super.key});
  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  String search = '';
  String filter = 'all';
  int visible = 50;
  @override
  Widget build(BuildContext context) => FinanceView(
    builder: (snapshot) {
      final events = snapshot.events
          .where(
            (event) =>
                (filter == 'all' || event.kind == filter) &&
                event.description.toLowerCase().contains(search.toLowerCase()),
          )
          .toList();
      return PageBody(
        children: [
          PageHeading(
            'Seu histórico',
            'Cada entrada, saída e transferência, com clareza.',
            action: FilledButton.icon(
              onPressed: () => snapshot.activeAccounts.isEmpty
                  ? showAccountForm(context)
                  : showMovementForm(context, snapshot),
              icon: const CanguruuIcon(Icons.add, size: 18),
              label: const Text('Nova movimentação'),
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              prefixIcon: CanguruuIcon(Icons.search),
              labelText: 'Buscar pela descrição',
            ),
            onChanged: (value) => setState(() {
              search = value;
              visible = 50;
            }),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final entry in {
                'all': 'Todas',
                'income': 'Receitas',
                'expense': 'Despesas',
                'transfer': 'Transferências',
                'card_purchase': 'Compras no cartão',
                'card_payment': 'Pagamentos de fatura',
                'reversal': 'Estornos',
              }.entries)
                ChoiceChip(
                  label: Text(entry.value),
                  selected: filter == entry.key,
                  onSelected: (_) => setState(() {
                    filter = entry.key;
                    visible = 50;
                  }),
                ),
            ],
          ),
          const SizedBox(height: 24),
          if (events.isEmpty)
            const EmptyCard(
              icon: Icons.receipt_long_outlined,
              title: 'Nenhuma movimentação encontrada',
              message:
                  'Registre uma movimentação ou ajuste a busca para consultar seu histórico.',
            )
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    for (final event in events.take(visible)) ...[
                      EventTile(event: event, snapshot: snapshot),
                      if (event != events.take(visible).last)
                        const Divider(height: 1),
                    ],
                    if (events.length > visible)
                      TextButton(
                        onPressed: () => setState(() => visible += 50),
                        child: const Text('Carregar mais'),
                      ),
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}
