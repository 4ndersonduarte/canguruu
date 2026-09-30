import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../shared/presentation/components.dart';
import '../../../shared/presentation/formatters.dart';
import '../../cards/domain/models.dart';
import '../../finance/domain/models.dart';
import '../../finance/presentation/forms.dart' show showAccountForm;
import '../domain/models.dart';
import 'schedule_forms.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});
  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  String filter = 'pending';
  int visible = 40;
  bool busy = false;
  Future<void> run(Future<Object?> Function() action) async {
    if (busy) return;
    setState(() => busy = true);
    try {
      await action();
      if (mounted) notifyUser(context, 'Agenda atualizada neste dispositivo.');
    } catch (e) {
      if (mounted) notifyUser(context, friendlyError(e));
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<bool> confirm(String title, String message, String action) async =>
      await showDialog<bool>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialog, true),
              child: Text(action),
            ),
          ],
        ),
      ) ??
      false;
  @override
  Widget build(BuildContext context) => FinanceView(
    builder: (finance) {
      final cards =
          ref.watch(cardsSnapshotProvider).valueOrNull?.cards ?? <CreditCard>[];
      return ref
          .watch(scheduleSnapshotProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(friendlyError(error)),
                    TextButton(
                      onPressed: () => ref.invalidate(scheduleSnapshotProvider),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            ),
            data: (snapshot) {
              final hidden = ref.watch(hiddenAmountsProvider);
              final pending = snapshot.pending;
              final overdue = pending
                  .where((o) => o.overdue(snapshot.asOf))
                  .length;
              final occurrences = filter == 'history'
                  ? snapshot.occurrences
                        .where((o) => o.status != OccurrenceStatus.pending)
                        .toList()
                        .reversed
                        .toList()
                  : pending;
              void create(bool recurring) {
                if (finance.activeAccounts.isEmpty && cards.isEmpty) {
                  showAccountForm(context);
                  return;
                }
                showScheduleForm(context, finance, cards, recurring: recurring);
              }

              return PageBody(
                children: [
                  PageHeading(
                    'Sua agenda financeira',
                    'O que está previsto, o que vence e o que já aconteceu.',
                    action: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => create(true),
                          icon: const CanguruuIcon(
                            Icons.repeat_rounded,
                            size: 18,
                          ),
                          label: const Text('Nova recorrência'),
                        ),
                        FilledButton.icon(
                          onPressed: () => create(false),
                          icon: const CanguruuIcon(Icons.add, size: 18),
                          label: const Text('Nova previsão'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: CanguruuColors.ink,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NO SEU RADAR · PRÓXIMOS 30 DIAS',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 40,
                          runSpacing: 20,
                          children: [
                            _ForecastValue(
                              'Receitas previstas',
                              formatMoney(
                                snapshot.expectedIn(30, ScheduleKind.income),
                                hidden: hidden,
                              ),
                            ),
                            _ForecastValue(
                              'Despesas em conta',
                              formatMoney(
                                snapshot.expectedIn(30, ScheduleKind.expense),
                                hidden: hidden,
                              ),
                            ),
                            _ForecastValue(
                              'Compras no cartão',
                              formatMoney(
                                snapshot.expectedIn(
                                  30,
                                  ScheduleKind.cardPurchase,
                                ),
                                hidden: hidden,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Valores pendentes. Transferências e pagamento de faturas são acompanhados separadamente; '
                          'nenhum valor previsto já foi somado ao seu saldo.',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  if (overdue > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        '$overdue previsões vencidas continuam pendentes. Confira se já aconteceram antes de confirmar.',
                        style: const TextStyle(
                          color: CanguruuColors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final option in {
                        'pending': 'Pendentes',
                        'series': 'Recorrências',
                        'history': 'Histórico da agenda',
                      }.entries)
                        ChoiceChip(
                          label: Text(option.value),
                          selected: filter == option.key,
                          onSelected: (_) => setState(() {
                            filter = option.key;
                            visible = 40;
                          }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (filter == 'series') ...[
                    if (snapshot.series.isEmpty)
                      const EmptyCard(
                        icon: Icons.repeat_rounded,
                        title: 'Uma rotina mais organizada',
                        message:
                            'Cadastre salários, assinaturas, aluguel ou outras previsões que se repetem.',
                      ),
                    for (final series in snapshot.series) ...[
                      _SeriesCard(
                        series: series,
                        rule: snapshot.rules.singleWhere(
                          (r) => r.id == series.currentRuleId,
                        ),
                        hidden: hidden,
                        busy: busy,
                        onEdit: () => showScheduleForm(
                          context,
                          finance,
                          cards,
                          recurring: true,
                          rule: snapshot.rules.singleWhere(
                            (r) => r.id == series.currentRuleId,
                          ),
                        ),
                        onToggle: () async {
                          final accepted = await confirm(
                            series.paused
                                ? 'Retomar recorrência?'
                                : 'Pausar recorrência?',
                            series.paused
                                ? 'As próximas ocorrências usarão a última regra e a âncora original. O intervalo de pausa não será recriado.'
                                : 'As previsões pendentes de hoje em diante serão canceladas. As vencidas e realizadas serão preservadas.',
                            series.paused ? 'Retomar' : 'Pausar',
                          );
                          if (!accepted || !mounted) return;
                          await run(
                            () => series.paused
                                ? ref
                                      .read(scheduleRepositoryProvider)
                                      .resume(
                                        requestId: const Uuid().v4(),
                                        seriesId: series.id,
                                      )
                                : ref
                                      .read(scheduleRepositoryProvider)
                                      .pause(
                                        requestId: const Uuid().v4(),
                                        seriesId: series.id,
                                      ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ] else ...[
                    if (occurrences.isEmpty)
                      EmptyCard(
                        icon: Icons.event_available_outlined,
                        title: filter == 'pending'
                            ? 'Tudo em dia por aqui'
                            : 'Seu histórico começa com uma previsão',
                        message: filter == 'pending'
                            ? 'Crie uma previsão avulsa ou uma recorrência para acompanhar os próximos compromissos.'
                            : 'Realizações, ocorrências ignoradas e previsões substituídas ficam registradas aqui.',
                      ),
                    for (final occurrence in occurrences.take(visible)) ...[
                      _OccurrenceCard(
                        occurrence: occurrence,
                        finance: finance,
                        cards: cards,
                        hidden: hidden,
                        busy: busy,
                        overdue: occurrence.overdue(snapshot.asOf),
                        onSettle: () => showSettleForm(context, occurrence),
                        onEdit: () => showScheduleForm(
                          context,
                          finance,
                          cards,
                          occurrence: occurrence,
                        ),
                        onSkip: () async {
                          if (!await confirm(
                                'Ignorar esta previsão?',
                                'Ela ficará no histórico e não criará uma movimentação. As demais ocorrências serão preservadas.',
                                'Ignorar',
                              ) ||
                              !mounted) {
                            return;
                          }
                          await run(
                            () => ref
                                .read(scheduleRepositoryProvider)
                                .skip(
                                  requestId: const Uuid().v4(),
                                  occurrenceId: occurrence.id,
                                ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (occurrences.length > visible)
                      TextButton(
                        onPressed: () => setState(() => visible += 40),
                        child: const Text('Ver mais previsões'),
                      ),
                  ],
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: busy
                        ? null
                        : () => run(
                            () => ref
                                .read(scheduleRepositoryProvider)
                                .generateThrough(snapshot.asOf.addDays(365)),
                          ),
                    icon: const CanguruuIcon(Icons.update_rounded, size: 18),
                    label: Text(
                      busy ? 'Atualizando…' : 'Atualizar próximos 12 meses',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A geração inicial cobre 90 dias. Atualizar a agenda amplia a janela e preserva os registros existentes. '
                    'Atraso não gera débito automático; juros e pagamentos parciais de previsões não são presumidos.',
                    style: TextStyle(fontSize: 11, color: CanguruuColors.muted),
                  ),
                ],
              );
            },
          );
    },
  );
}

class _ForecastValue extends StatelessWidget {
  const _ForecastValue(this.label, this.value);
  final String label, value;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      const SizedBox(height: 8),
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          value,
          style: CanguruuType.amount.copyWith(color: CanguruuColors.yellow),
        ),
      ),
    ],
  );
}

class _SeriesCard extends StatelessWidget {
  const _SeriesCard({
    required this.series,
    required this.rule,
    required this.hidden,
    required this.busy,
    required this.onEdit,
    required this.onToggle,
  });
  final RecurrenceSeries series;
  final RecurrenceVersion rule;
  final bool hidden, busy;
  final VoidCallback onEdit, onToggle;
  @override
  Widget build(BuildContext context) => Card(
    semanticContainer: false,
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CanguruuIcon(Icons.repeat_rounded, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  series.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                series.paused ? 'Pausada' : 'Ativa',
                style: TextStyle(
                  fontSize: 11,
                  color: series.paused
                      ? CanguruuColors.muted
                      : CanguruuColors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${scheduleKindLabel(series.kind)} · ${formatMoney(rule.entry.amount, hidden: hidden)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            '${frequencyLabel(rule.pattern.frequency)} · intervalo ${rule.pattern.interval} · âncora ${rule.pattern.anchor.display}'
            '${rule.pattern.lastDay ? ' · último dia do mês' : ''}',
            style: const TextStyle(fontSize: 12, color: CanguruuColors.muted),
          ),
          if (rule.pattern.maxOccurrences != null)
            Text(
              'Limite: ${rule.pattern.maxOccurrences} ocorrências por regra',
              style: const TextStyle(fontSize: 11, color: CanguruuColors.muted),
            ),
          if (rule.pattern.endOn != null)
            Text(
              'Até ${rule.pattern.endOn!.display}',
              style: const TextStyle(fontSize: 11, color: CanguruuColors.muted),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: [
              OutlinedButton.icon(
                onPressed: busy ? null : onToggle,
                icon: CanguruuIcon(
                  series.paused
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  size: 17,
                ),
                label: Text(series.paused ? 'Retomar' : 'Pausar'),
              ),

              TextButton(
                onPressed: busy ? null : onEdit,
                child: const Text('Editar próximas'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _OccurrenceCard extends StatelessWidget {
  const _OccurrenceCard({
    required this.occurrence,
    required this.finance,
    required this.cards,
    required this.hidden,
    required this.busy,
    required this.overdue,
    required this.onSettle,
    required this.onEdit,
    required this.onSkip,
  });
  final ScheduledOccurrence occurrence;
  final FinanceSnapshot finance;
  final List<CreditCard> cards;
  final bool hidden, busy, overdue;
  final VoidCallback onSettle, onEdit, onSkip;
  @override
  Widget build(BuildContext context) {
    final e = occurrence.entry;
    final origin = e.kind == ScheduleKind.cardPurchase
        ? cards.where((c) => c.id == e.cardId).firstOrNull?.name ?? 'Cartão'
        : finance.accountName(e.accountId!);
    final status = switch (occurrence.status) {
      OccurrenceStatus.pending => overdue ? 'Vencida · pendente' : 'Pendente',
      OccurrenceStatus.settled =>
        occurrence.reversed ? 'Realizada · lançamento estornado' : 'Realizada',
      OccurrenceStatus.skipped => 'Ignorada',
      OccurrenceStatus.cancelled => 'Cancelada · histórico preservado',
    };
    return Card(
      semanticContainer: false,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    e.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      formatMoney(e.amount, hidden: hidden),
                      style: CanguruuType.amount.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${occurrence.date.display} · ${scheduleKindLabel(e.kind)} · $origin',
              style: const TextStyle(fontSize: 12, color: CanguruuColors.muted),
            ),
            if (e.destinationId != null)
              Text(
                'Destino: ${finance.accountName(e.destinationId!)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: CanguruuColors.muted,
                ),
              ),
            if (e.categoryId != null)
              Text(
                finance.categoryName(e.categoryId!),
                style: const TextStyle(
                  fontSize: 11,
                  color: CanguruuColors.muted,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              '$status${occurrence.seriesId == null ? ' · avulsa' : ' · recorrente'}${occurrence.manualOverride ? ' · exceção' : ''}',
              style: TextStyle(
                fontSize: 11,
                color: overdue ? CanguruuColors.red : CanguruuColors.muted,
              ),
            ),
            if (occurrence.status == OccurrenceStatus.pending) ...[
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: busy ? null : onSettle,
                    icon: const CanguruuIcon(Icons.check_rounded, size: 17),
                    label: Text(switch (e.kind) {
                      ScheduleKind.income => 'Confirmar recebimento',
                      ScheduleKind.expense => 'Confirmar pagamento',
                      ScheduleKind.transfer => 'Confirmar transferência',
                      ScheduleKind.cardPurchase => 'Confirmar compra',
                    }),
                  ),
                  IconButton(
                    tooltip: 'Editar esta previsão',
                    onPressed: busy ? null : onEdit,
                    icon: const CanguruuIcon(Icons.edit_outlined, size: 19),
                  ),
                  IconButton(
                    tooltip: 'Ignorar previsão',
                    onPressed: busy ? null : onSkip,
                    icon: const CanguruuIcon(Icons.block_rounded, size: 19),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
