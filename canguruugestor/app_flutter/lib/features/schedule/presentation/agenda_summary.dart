import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../shared/presentation/formatters.dart';
import '../domain/models.dart';

class AgendaSummary extends ConsumerWidget {
  const AgendaSummary({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(scheduleSnapshotProvider)
      .when(
        loading: () => const SizedBox.shrink(),
        error: (_, stack) => TextButton(
          onPressed: () => context.go('/schedule'),
          child: const Text('Conferir agenda de previsões'),
        ),
        data: (snapshot) {
          final hidden = ref.watch(hiddenAmountsProvider);
          final overdue = snapshot.pending
              .where((o) => o.overdue(snapshot.asOf))
              .length;
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Card(
              color: CanguruuColors.yellowWash,
              semanticContainer: false,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Na agenda',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go('/schedule'),
                          child: const Text('Ver agenda →'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (snapshot.pending.isEmpty)
                      const Text(
                        'Adicione seus próximos recebimentos e pagamentos.',
                        style: TextStyle(color: CanguruuColors.muted),
                      )
                    else ...[
                      Wrap(
                        spacing: 24,
                        runSpacing: 10,
                        children: [
                          Text(
                            'A receber: ${formatMoney(snapshot.expectedIn(30, ScheduleKind.income), hidden: hidden)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'A pagar em conta: ${formatMoney(snapshot.expectedIn(30, ScheduleKind.expense), hidden: hidden)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      if (overdue > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            '$overdue previsões vencidas aguardam confirmação.',
                            style: const TextStyle(
                              color: CanguruuColors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                    const SizedBox(height: 10),
                    const Text(
                      'Próximos 30 dias · valores previstos, sem faturas',
                      style: TextStyle(
                        fontSize: 11,
                        color: CanguruuColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
