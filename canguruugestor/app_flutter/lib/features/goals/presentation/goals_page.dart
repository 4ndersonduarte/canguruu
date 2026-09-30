import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/money.dart';
import '../../../shared/presentation/brand_icon.dart';
import '../../../shared/presentation/components.dart';
import '../../../shared/presentation/forms.dart';
import '../../../shared/presentation/formatters.dart';
import '../domain/models.dart';

class GoalsPage extends ConsumerWidget {
  const GoalsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => FinanceView(
    builder: (_) => ref
        .watch(goalsSnapshotProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(friendlyError(e))),
          data: (snapshot) => PageBody(
            children: [
              PageHeading(
                'Suas metas',
                'Reserve dinheiro para o que importa.',
                action: FilledButton.icon(
                  onPressed: () => showGoalForm(context),
                  icon: const CanguruuIcon(Icons.add, size: 18),
                  label: const Text('Nova meta'),
                ),
              ),
              if (snapshot.goals.isEmpty)
                EmptyCard(
                  icon: Icons.track_changes_outlined,
                  title: 'Dê um destino ao seu dinheiro',
                  message:
                      'Crie uma meta e acompanhe o quanto já está reservado.',
                  action: FilledButton(
                    onPressed: () => showGoalForm(context),
                    child: const Text('Criar meta'),
                  ),
                )
              else ...[
                _GoalsOverview(snapshot: snapshot),
                const SizedBox(height: 20),
                for (final progress in snapshot.progress.where(
                  (p) => !p.goal.closed,
                )) ...[
                  _GoalCard(progress: progress, snapshot: snapshot),
                  const SizedBox(height: 14),
                ],
              ],
            ],
          ),
        ),
  );
}

class _GoalsOverview extends StatelessWidget {
  const _GoalsOverview({required this.snapshot});
  final GoalsSnapshot snapshot;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final cards = [
        _OverviewMetric('Reservado', snapshot.reserved, CanguruuColors.ink),
        _OverviewMetric('Coberto', snapshot.covered, CanguruuColors.green),
        _OverviewMetric('Livre', snapshot.free, CanguruuColors.yellow),
      ];
      return Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          for (final card in cards)
            SizedBox(
              width: c.maxWidth < 650 ? c.maxWidth : (c.maxWidth - 28) / 3,
              child: card,
            ),
        ],
      );
    },
  );
}

class _OverviewMetric extends StatelessWidget {
  const _OverviewMetric(this.label, this.value, this.color);
  final String label;
  final Money value;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: CanguruuColors.paper,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(
          color: Color(0x120E261D),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          formatMoney(value),
          style: CanguruuType.amount.copyWith(fontSize: 22),
        ),
      ],
    ),
  );
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.progress, required this.snapshot});
  final GoalProgress progress;
  final GoalsSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    final goal = progress.goal;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _PurposeTag(goal.purpose),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress.ratio,
                minHeight: 8,
                backgroundColor: CanguruuColors.offWhite,
                color: CanguruuColors.yellow,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  formatMoney(progress.covered),
                  style: CanguruuType.amount.copyWith(fontSize: 20),
                ),
                const Spacer(),
                Text(
                  'de ${formatMoney(goal.target)}',
                  style: const TextStyle(color: CanguruuColors.muted),
                ),
              ],
            ),
            if (progress.deficit.cents > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Parte da reserva está sem cobertura: ${formatMoney(progress.deficit)}',
                  style: const TextStyle(
                    color: CanguruuColors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => showReserveForm(context, goal.id, add: true),
                  icon: const CanguruuIcon(Icons.add, size: 16),
                  label: const Text('Reservar'),
                ),
                OutlinedButton.icon(
                  onPressed: progress.nominal.cents > 0
                      ? () => showReserveForm(context, goal.id, add: false)
                      : null,
                  icon: const CanguruuIcon(Icons.remove, size: 16),
                  label: const Text('Liberar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PurposeTag extends StatelessWidget {
  const _PurposeTag(this.purpose);
  final GoalPurpose purpose;
  @override
  Widget build(BuildContext context) => Chip(
    label: Text(switch (purpose) {
      GoalPurpose.emergency => 'Reserva',
      GoalPurpose.purchase => 'Compra',
      GoalPurpose.general => 'Objetivo',
    }),
  );
}

Future<void> showGoalForm(BuildContext context) =>
    showDialog(context: context, builder: (_) => const _GoalForm());
Future<void> showReserveForm(
  BuildContext context,
  String goalId, {
  required bool add,
}) => showDialog(
  context: context,
  builder: (_) => _ReserveForm(goalId: goalId, add: add),
);

class _GoalForm extends ConsumerStatefulWidget {
  const _GoalForm();
  @override
  ConsumerState<_GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends ConsumerState<_GoalForm> with SubmitState {
  final title = TextEditingController();
  final target = TextEditingController();
  GoalPurpose purpose = GoalPurpose.general;
  int priority = 3;
  @override
  void dispose() {
    title.dispose();
    target.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormPanel(
    title: 'Nova meta',
    busy: busy,
    error: error,
    onSubmit: () => submit(() async {
      final amount = Money.parse(target.text);
      final id = const Uuid().v4();
      await ref
          .read(goalsRepositoryProvider)
          .saveGoal(
            requestId: id,
            title: title.text,
            target: amount,
            purpose: purpose,
            priority: priority,
          );
      ref.invalidate(goalsSnapshotProvider);
      return id;
    }),
    children: [
      TextField(
        controller: title,
        maxLength: 80,
        decoration: const InputDecoration(
          labelText: 'Nome da meta',
          hintText: 'Ex.: reserva de emergência',
        ),
      ),
      TextField(
        controller: target,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Valor alvo',
          prefixText: 'R\$ ',
        ),
      ),
      DropdownButtonFormField<GoalPurpose>(
        initialValue: purpose,
        decoration: const InputDecoration(labelText: 'Tipo'),
        items: const [
          DropdownMenuItem(
            value: GoalPurpose.general,
            child: Text('Objetivo geral'),
          ),
          DropdownMenuItem(
            value: GoalPurpose.emergency,
            child: Text('Reserva de emergência'),
          ),
          DropdownMenuItem(
            value: GoalPurpose.purchase,
            child: Text('Compra planejada'),
          ),
        ],
        onChanged: (v) => setState(() => purpose = v!),
      ),
      DropdownButtonFormField<int>(
        initialValue: priority,
        decoration: const InputDecoration(labelText: 'Prioridade'),
        items: [
          for (var i = 1; i <= 5; i++)
            DropdownMenuItem(value: i, child: Text('$i')),
        ],
        onChanged: (v) => setState(() => priority = v!),
      ),
    ],
  );
}

class _ReserveForm extends ConsumerStatefulWidget {
  const _ReserveForm({required this.goalId, required this.add});
  final String goalId;
  final bool add;
  @override
  ConsumerState<_ReserveForm> createState() => _ReserveFormState();
}

class _ReserveFormState extends ConsumerState<_ReserveForm> with SubmitState {
  final amount = TextEditingController();
  String? accountId;
  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ref
      .watch(goalsSnapshotProvider)
      .maybeWhen(
        data: (snapshot) {
          accountId ??= snapshot.finance.activeAccounts.firstOrNull?.id;
          return FormPanel(
            title: widget.add ? 'Reservar dinheiro' : 'Liberar reserva',
            busy: busy,
            error: error,
            onSubmit: () => submit(() async {
              final value = Money.parse(amount.text);
              if (accountId == null) {
                throw StateError('Cadastre uma conta antes de reservar.');
              }
              await ref
                  .read(goalsRepositoryProvider)
                  .moveFunds(
                    requestId: const Uuid().v4(),
                    goalId: widget.goalId,
                    accountId: accountId!,
                    amount: widget.add ? value : Money(-value.cents),
                  );
              ref.invalidate(goalsSnapshotProvider);
              return true;
            }),
            children: [
              TextField(
                controller: amount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  prefixText: 'R\$ ',
                ),
              ),
              DropdownButtonFormField<String>(
                initialValue: accountId,
                decoration: const InputDecoration(labelText: 'Conta'),
                items: [
                  for (final a in snapshot.finance.activeAccounts)
                    DropdownMenuItem(value: a.id, child: Text(a.name)),
                ],
                onChanged: (v) => setState(() => accountId = v),
              ),
            ],
          );
        },
        orElse: () => const SizedBox.shrink(),
      );
}
