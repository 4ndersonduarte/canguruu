import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/civil_date.dart';
import '../../../core/failure.dart';
import '../../../core/money.dart';
import '../../../shared/presentation/forms.dart';
import '../../../shared/presentation/formatters.dart';
import '../../cards/domain/models.dart';
import '../../finance/domain/models.dart';
import '../domain/models.dart';
import '../domain/services/recurrence_rules.dart';

String scheduleKindLabel(ScheduleKind kind) => switch (kind) {
  ScheduleKind.income => 'Receita',
  ScheduleKind.expense => 'Despesa',
  ScheduleKind.transfer => 'Transferência',
  ScheduleKind.cardPurchase => 'Compra no cartão',
};
String frequencyLabel(RepeatFrequency frequency) => switch (frequency) {
  RepeatFrequency.daily => 'Diária',
  RepeatFrequency.weekly => 'Semanal',
  RepeatFrequency.monthly => 'Mensal',
  RepeatFrequency.yearly => 'Anual',
};
Future<void> showScheduleForm(
  BuildContext context,
  FinanceSnapshot finance,
  List<CreditCard> cards, {
  bool recurring = false,
  ScheduledOccurrence? occurrence,
  RecurrenceVersion? rule,
}) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => ScheduleForm(
    finance: finance,
    cards: cards,
    recurring: recurring,
    occurrence: occurrence,
    rule: rule,
  ),
);

class ScheduleForm extends ConsumerStatefulWidget {
  const ScheduleForm({
    super.key,
    required this.finance,
    required this.cards,
    this.recurring = false,
    this.occurrence,
    this.rule,
  });
  final FinanceSnapshot finance;
  final List<CreditCard> cards;
  final bool recurring;
  final ScheduledOccurrence? occurrence;
  final RecurrenceVersion? rule;
  @override
  ConsumerState<ScheduleForm> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends ConsumerState<ScheduleForm>
    with SubmitState<ScheduleForm> {
  PlannedEntry? get original => widget.occurrence?.entry ?? widget.rule?.entry;
  late final description = TextEditingController(
    text: original?.description ?? '',
  );
  late final amount = TextEditingController(
    text: original == null ? '' : editMoney(original!.amount),
  );
  late final interval = TextEditingController(
    text: '${widget.rule?.pattern.interval ?? 1}',
  );
  late final count = TextEditingController(
    text: widget.rule?.pattern.maxOccurrences?.toString() ?? '',
  );
  late ScheduleKind kind =
      original?.kind ??
      (widget.finance.activeAccounts.isEmpty
          ? ScheduleKind.cardPurchase
          : ScheduleKind.expense);
  late String? accountId = original == null
      ? widget.finance.activeAccounts.firstOrNull?.id
      : widget.finance.activeAccounts.any((a) => a.id == original!.accountId)
      ? original!.accountId
      : null;
  late String? destinationId =
      widget.finance.activeAccounts.any(
        (a) => a.id == original?.destinationId && a.id != accountId,
      )
      ? original?.destinationId
      : null;
  late String? cardId = original?.cardId ?? widget.cards.firstOrNull?.id;
  late String? categoryId =
      widget.finance.categories.any(
        (c) => c.id == original?.categoryId && !c.archived,
      )
      ? original?.categoryId
      : null;
  late CivilDate date =
      widget.occurrence?.date ??
      (widget.rule?.pattern.anchor.isAfter(ref.read(clockProvider).today) ==
              true
          ? widget.rule!.pattern.anchor
          : ref.read(clockProvider).today);
  late RepeatFrequency frequency =
      widget.rule?.pattern.frequency ?? RepeatFrequency.monthly;
  late bool lastDay = widget.rule?.pattern.lastDay ?? false;
  late bool hasEnd = widget.rule?.pattern.endOn != null;
  late CivilDate end = widget.rule?.pattern.endOn ?? date.addDays(90);
  bool get lockedKind => original != null;
  @override
  void dispose() {
    for (final c in [description, amount, interval, count]) {
      c.dispose();
    }
    super.dispose();
  }

  RecurrencePattern pattern() => RecurrencePattern(
    anchor: date,
    frequency: frequency,
    interval: int.tryParse(interval.text) ?? 0,
    lastDay: frequency == RepeatFrequency.monthly && lastDay,
    endOn: hasEnd ? end : null,
    maxOccurrences: count.text.trim().isEmpty
        ? null
        : int.tryParse(count.text) ?? 0,
  );
  PlannedEntry draft() {
    final expense =
        kind == ScheduleKind.expense || kind == ScheduleKind.cardPurchase;
    final sameCategory = original?.categoryId == categoryId;
    return PlannedEntry(
      kind: kind,
      description: description.text,
      amount: Money.parse(amount.text),
      accountId: kind == ScheduleKind.cardPurchase ? null : accountId,
      destinationId: kind == ScheduleKind.transfer ? destinationId : null,
      cardId: kind == ScheduleKind.cardPurchase ? cardId : null,
      categoryId: kind == ScheduleKind.transfer ? null : categoryId,
      costNature: expense && sameCategory ? original?.costNature : null,
      essential: expense && sameCategory ? original?.essential : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.finance.categories
        .where(
          (c) =>
              !c.archived &&
              c.kind ==
                  (kind == ScheduleKind.income
                      ? MovementKind.income
                      : MovementKind.expense),
        )
        .toList();
    List<(int, CivilDate)> preview = [];
    String? previewError;
    if (widget.recurring) {
      try {
        preview = RecurrenceRules.occurrences(
          RecurrenceVersion(
            id: 'preview',
            seriesId: 'preview',
            validFrom: date,
            entry: PlannedEntry(
              kind: kind,
              description: 'Prévia',
              amount: Money(1),
            ),
            pattern: pattern(),
          ),
          date.addDays(90),
        );
      } on FinanceFailure catch (e) {
        previewError = e.message;
      }
    }
    return FormPanel(
      title: widget.occurrence != null
          ? 'Editar esta previsão'
          : widget.rule != null
          ? 'Editar próximas ocorrências'
          : widget.recurring
          ? 'Nova recorrência'
          : 'Nova previsão',
      busy: busy,
      error: error,
      submitLabel: widget.occurrence != null || widget.rule != null
          ? 'Salvar alterações'
          : 'Salvar previsão',
      children: [
        DropdownButtonFormField<ScheduleKind>(
          initialValue: kind,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Tipo de previsão'),
          items: ScheduleKind.values
              .map(
                (k) => DropdownMenuItem(
                  value: k,
                  enabled: k == ScheduleKind.cardPurchase
                      ? widget.cards.isNotEmpty
                      : k == ScheduleKind.transfer
                      ? widget.finance.activeAccounts.length >= 2
                      : widget.finance.activeAccounts.isNotEmpty,
                  child: Text(scheduleKindLabel(k)),
                ),
              )
              .toList(),
          onChanged: lockedKind
              ? null
              : (v) => setState(() {
                  kind = v!;
                  categoryId = null;
                  destinationId = null;
                }),
        ),
        TextField(
          key: const Key('schedule-description'),
          controller: description,
          autofocus: true,
          maxLength: 160,
          decoration: const InputDecoration(
            labelText: 'Descrição da previsão',
            hintText: 'Ex.: Aluguel, salário, assinatura',
          ),
        ),
        TextField(
          key: const Key('schedule-amount'),
          controller: amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Valor previsto',
            prefixText: 'R\$ ',
          ),
        ),
        if (kind == ScheduleKind.cardPurchase)
          DropdownButtonFormField<String>(
            initialValue: cardId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Cartão da previsão'),
            items: widget.cards
                .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                .toList(),
            onChanged: (v) => setState(() => cardId = v),
          )
        else
          DropdownButtonFormField<String>(
            initialValue: accountId,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: kind == ScheduleKind.income
                  ? 'Conta de recebimento'
                  : 'Conta da previsão',
            ),
            items: widget.finance.activeAccounts
                .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                .toList(),
            onChanged: (v) => setState(() {
              accountId = v;
              if (destinationId == v) destinationId = null;
            }),
          ),
        if (kind == ScheduleKind.transfer)
          DropdownButtonFormField<String>(
            key: ValueKey('schedule-destination-$accountId'),
            initialValue: destinationId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Conta de destino'),
            items: widget.finance.activeAccounts
                .where((a) => a.id != accountId)
                .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                .toList(),
            onChanged: (v) => setState(() => destinationId = v),
          )
        else
          DropdownButtonFormField<String>(
            key: ValueKey('schedule-category-${kind.name}'),
            initialValue: categoryId,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Categoria da previsão',
            ),
            items: categories
                .map(
                  (c) => DropdownMenuItem(
                    value: c.id,
                    child: Text(
                      widget.finance.categoryName(c.id),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => categoryId = v),
          ),
        DateField(
          date: date,
          allowFuture: true,
          label: widget.recurring ? 'Primeira ocorrência' : 'Data prevista',
          onChanged: (v) => setState(() {
            date = v;
            if (end.isBefore(date)) end = date.addDays(90);
          }),
        ),
        if (widget.recurring) ...[
          DropdownButtonFormField<RepeatFrequency>(
            initialValue: frequency,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Frequência'),
            items: RepeatFrequency.values
                .map(
                  (f) => DropdownMenuItem(
                    value: f,
                    child: Text(frequencyLabel(f)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => frequency = v!),
          ),
          TextField(
            key: const Key('recurrence-interval'),
            controller: interval,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Repetir a cada',
              helperText: 'Quantidade de dias, semanas, meses ou anos',
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (frequency == RepeatFrequency.monthly)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'No último dia do mês',
                style: TextStyle(fontSize: 13),
              ),
              value: lastDay,
              onChanged: (v) => setState(() => lastDay = v),
            ),
          TextField(
            key: const Key('recurrence-count'),
            controller: count,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantidade de ocorrências',
              hintText: 'Sem limite definido',
            ),
            onChanged: (_) => setState(() {}),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text(
              'Definir data final',
              style: TextStyle(fontSize: 13),
            ),
            value: hasEnd,
            onChanged: (v) => setState(() => hasEnd = v!),
          ),
          if (hasEnd)
            DateField(
              date: end,
              allowFuture: true,
              label: 'Última data permitida',
              onChanged: (v) => setState(() => end = v),
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CanguruuColors.offWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confira as próximas datas',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                if (previewError != null)
                  Text(
                    previewError,
                    style: const TextStyle(color: CanguruuColors.red),
                  ),
                for (final item in preview.take(6))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      'Ocorrência ${item.$1} · ${item.$2.display}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                if (preview.isEmpty && previewError == null)
                  const Text(
                    'Nenhuma ocorrência nos 90 dias após a data inicial.',
                  ),
                if (preview.length > 6)
                  Text(
                    'Mais ${preview.length - 6} datas nesta janela.',
                    style: const TextStyle(fontSize: 11),
                  ),
              ],
            ),
          ),
        ],
        Text(
          widget.rule != null
              ? 'As previsões pendentes a partir da data escolhida serão substituídas. Realizadas e vencidas anteriores continuam no histórico. Uma série pausada permanecerá pausada.'
              : widget.occurrence != null
              ? 'Esta mudança vale somente para esta ocorrência. As outras datas da série serão preservadas.'
              : 'Previsões não alteram saldo nem dívida. Você confirma cada recebimento, pagamento ou compra quando acontecer.',
          style: const TextStyle(fontSize: 12, color: CanguruuColors.muted),
        ),
      ],
      onSubmit: () => submit(() {
        final repository = ref.read(scheduleRepositoryProvider);
        if (widget.occurrence != null) {
          return repository.editOccurrence(
            requestId: requestId,
            occurrenceId: widget.occurrence!.id,
            entry: draft(),
            date: date,
          );
        }
        if (widget.rule != null) {
          return repository.reviseSeries(
            requestId: requestId,
            seriesId: widget.rule!.seriesId,
            entry: draft(),
            pattern: pattern(),
          );
        }
        if (widget.recurring) {
          return repository.createSeries(
            requestId: requestId,
            entry: draft(),
            pattern: pattern(),
          );
        }
        return repository.createOneOff(
          requestId: requestId,
          entry: draft(),
          date: date,
        );
      }),
    );
  }
}

Future<void> showSettleForm(
  BuildContext context,
  ScheduledOccurrence occurrence,
) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => SettleScheduleForm(occurrence: occurrence),
);

class SettleScheduleForm extends ConsumerStatefulWidget {
  const SettleScheduleForm({super.key, required this.occurrence});
  final ScheduledOccurrence occurrence;
  @override
  ConsumerState<SettleScheduleForm> createState() => _SettleScheduleFormState();
}

class _SettleScheduleFormState extends ConsumerState<SettleScheduleForm>
    with SubmitState<SettleScheduleForm> {
  late CivilDate date = ref.read(clockProvider).today;
  bool confirmCycle = false;
  @override
  Widget build(BuildContext context) => FormPanel(
    title: 'Confirmar realização',
    busy: busy,
    error: error,
    submitLabel: 'Confirmar lançamento',
    children: [
      Text(
        widget.occurrence.entry.description,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      ),
      Text(
        formatMoney(widget.occurrence.entry.amount),
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      ),
      Text(
        'Data prevista: ${widget.occurrence.date.display}',
        style: const TextStyle(color: CanguruuColors.muted),
      ),
      DateField(
        date: date,
        label: 'Data realizada',
        onChanged: (v) => setState(() {
          date = v;
          confirmCycle = false;
        }),
      ),
      if (widget.occurrence.entry.kind == ScheduleKind.cardPurchase &&
          date.isBefore(ref.read(clockProvider).today))
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: confirmCycle,
          title: const Text(
            'Conferi a atribuição aos ciclos de fatura, inclusive os já encerrados.',
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (v) => setState(() => confirmCycle = v!),
        ),
      const Text(
        'Confirme somente se já aconteceu. O valor integral será lançado na conta ou no cartão cadastrado. '
        'Se o valor mudou, edite a previsão antes de confirmar.',
        style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
      ),
    ],
    onSubmit: () => submit(
      () => ref
          .read(scheduleRepositoryProvider)
          .settle(
            requestId: requestId,
            occurrenceId: widget.occurrence.id,
            date: date,
            confirmClosedCycle: confirmCycle,
          ),
    ),
  );
}
