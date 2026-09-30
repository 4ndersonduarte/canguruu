import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/civil_date.dart';
import '../../../core/failure.dart';
import '../../../core/money.dart';
import '../../../shared/presentation/forms.dart';
import '../../../shared/presentation/formatters.dart';
import '../../finance/domain/models.dart';
import '../domain/models.dart';
import '../domain/services/card_rules.dart';

Future<void> showCardForm(BuildContext context) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => const CardForm(),
);
Future<void> showPurchaseForm(
  BuildContext context,
  FinanceSnapshot finance,
  CreditCard card,
) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => PurchaseForm(finance: finance, card: card),
);
Future<void> showPaymentForm(
  BuildContext context,
  FinanceSnapshot finance,
  CreditCard card,
  CardInvoice invoice,
) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => PaymentForm(finance: finance, card: card, invoice: invoice),
);

class CardForm extends ConsumerStatefulWidget {
  const CardForm({super.key});
  @override
  ConsumerState<CardForm> createState() => _CardFormState();
}

class _CardFormState extends ConsumerState<CardForm>
    with SubmitState<CardForm> {
  final name = TextEditingController();
  final limit = TextEditingController();
  final closing = TextEditingController(text: '10');
  final due = TextEditingController(text: '17');
  final debt = TextEditingController(text: '0,00');
  late CivilDate date = ref.read(clockProvider).today;
  ClosingPolicy policy = ClosingPolicy.next;
  @override
  void dispose() {
    for (final c in [name, limit, closing, due, debt]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormPanel(
    title: 'Adicionar cartão',
    busy: busy,
    error: error,
    children: [
      TextField(
        key: const Key('card-name'),
        controller: name,
        autofocus: true,
        maxLength: 80,
        decoration: const InputDecoration(
          labelText: 'Nome do cartão',
          hintText: 'Ex.: Meu cartão',
        ),
      ),
      TextField(
        key: const Key('card-limit'),
        controller: limit,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Limite total',
          prefixText: 'R\$ ',
        ),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              key: const Key('card-closing'),
              controller: closing,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Dia de fechamento'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              key: const Key('card-due'),
              controller: due,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Dia de vencimento'),
            ),
          ),
        ],
      ),
      DropdownButtonFormField<ClosingPolicy>(
        initialValue: policy,
        isExpanded: true,
        decoration: const InputDecoration(
          labelText: 'Compra no dia do fechamento',
        ),
        items: const [
          DropdownMenuItem(
            value: ClosingPolicy.next,
            child: Text('Vai para a próxima fatura'),
          ),
          DropdownMenuItem(
            value: ClosingPolicy.current,
            child: Text('Entra na fatura deste ciclo'),
          ),
        ],
        onChanged: (value) => setState(() => policy = value!),
      ),
      DateField(
        date: date,
        label: 'Início do acompanhamento',
        onChanged: (v) => setState(() => date = v),
      ),
      TextField(
        key: const Key('card-opening-debt'),
        controller: debt,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Dívida inicial',
          prefixText: 'R\$ ',
        ),
      ),
      const Text(
        'A dívida inicial vai integralmente para a primeira fatura calculada e não conta como nova despesa. '
        'Para dívidas distribuídas em várias faturas, comece com zero e registre as compras com suas datas e parcelas.',
        style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
      ),
    ],
    onSubmit: () => submit(
      () => ref
          .read(cardsRepositoryProvider)
          .createCard(
            requestId: requestId,
            name: name.text,
            totalLimit: Money.parse(limit.text),
            closingDay: int.tryParse(closing.text) ?? 0,
            dueDay: int.tryParse(due.text) ?? 0,
            policy: policy,
            openedOn: date,
            openingDebt: Money.parse(debt.text),
          ),
    ),
  );
}

class PurchaseForm extends ConsumerStatefulWidget {
  const PurchaseForm({super.key, required this.finance, required this.card});
  final FinanceSnapshot finance;
  final CreditCard card;
  @override
  ConsumerState<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends ConsumerState<PurchaseForm>
    with SubmitState<PurchaseForm> {
  final description = TextEditingController();
  final total = TextEditingController();
  final count = TextEditingController(text: '1');
  String? categoryId;
  late CivilDate date = ref.read(clockProvider).today;
  late CivilDate billing = date;
  bool reconciled = false;
  bool showAll = false;
  @override
  void dispose() {
    description.dispose();
    total.dispose();
    count.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Money> values = [];
    List<BillingCycle> cycles = [];
    String? previewError;
    try {
      if (total.text.isNotEmpty) {
        values = CardRules.installments(
          Money.parse(total.text),
          int.tryParse(count.text) ?? 0,
        );
        cycles = CardRules.schedule(
          billing,
          values.length,
          widget.card.closingDay,
          widget.card.dueDay,
          widget.card.policy,
        );
      }
    } on FinanceFailure catch (e) {
      previewError = e.message;
    }
    final past =
        cycles.isNotEmpty &&
        cycles.first.closingOn.isBefore(ref.read(clockProvider).today);
    return FormPanel(
      title: 'Compra no cartão',
      busy: busy,
      error: error,
      submitLabel: 'Registrar compra',
      children: [
        Text(
          widget.card.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        TextField(
          key: const Key('purchase-total'),
          controller: total,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Valor total da compra',
            prefixText: 'R\$ ',
          ),
        ),
        TextField(
          key: const Key('purchase-description'),
          controller: description,
          maxLength: 160,
          decoration: const InputDecoration(labelText: 'Descrição da compra'),
        ),
        TextField(
          key: const Key('purchase-count'),
          controller: count,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(labelText: 'Número de parcelas'),
        ),
        DropdownButtonFormField<String>(
          initialValue: categoryId,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Categoria da compra'),
          items: widget.finance.categories
              .where((c) => !c.archived && c.kind == MovementKind.expense)
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
          label: 'Data da compra',
          onChanged: (v) => setState(() {
            date = v;
            billing = v;
            reconciled = false;
          }),
        ),
        DateField(
          date: billing,
          label: 'Processamento',
          onChanged: (v) => setState(() {
            billing = v;
            reconciled = false;
          }),
        ),
        if (previewError != null)
          Text(previewError, style: const TextStyle(color: CanguruuColors.red)),
        if (cycles.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: CanguruuColors.offWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confira as parcelas',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                for (
                  var i = 0;
                  i < (showAll ? values.length : values.length.clamp(0, 6));
                  i++
                )
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${i + 1}/${values.length} · ${formatMoney(values[i])} · vence ${cycles[i].dueOn.display}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                if (values.length > 6)
                  TextButton(
                    onPressed: () => setState(() => showAll = !showAll),
                    child: Text(
                      showAll
                          ? 'Mostrar menos'
                          : 'Ver todas as ${values.length} parcelas',
                    ),
                  ),
                Text(
                  'Fechamento inicial: ${cycles.first.closingOn.display}',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        if (past)
          CheckboxListTile(
            value: reconciled,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (v) => setState(() => reconciled = v!),
            title: const Text(
              'Conferi os ciclos encerrados e confirmo estas datas.',
              style: TextStyle(fontSize: 12),
            ),
          ),
        const Text(
          'O total contratado entra nas despesas na data da compra. As parcelas não geram novas despesas. '
          'As datas são calculadas pelas regras do cartão; confira com o emissor.',
          style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
        ),
      ],
      onSubmit: () => submit(
        () => ref
            .read(cardsRepositoryProvider)
            .purchase(
              requestId: requestId,
              cardId: widget.card.id,
              categoryId: categoryId ?? '',
              description: description.text,
              total: Money.parse(total.text),
              installments: int.tryParse(count.text) ?? 0,
              date: date,
              billingOn: billing,
              confirmClosedCycle: past && reconciled,
            ),
      ),
    );
  }
}

class PaymentForm extends ConsumerStatefulWidget {
  const PaymentForm({
    super.key,
    required this.finance,
    required this.card,
    required this.invoice,
  });
  final FinanceSnapshot finance;
  final CreditCard card;
  final CardInvoice invoice;
  @override
  ConsumerState<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends ConsumerState<PaymentForm>
    with SubmitState<PaymentForm> {
  late final amount = TextEditingController(
    text: editMoney(widget.invoice.balance),
  );
  late String accountId = widget.finance.activeAccounts.first.id;
  late CivilDate date = ref.read(clockProvider).today;
  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormPanel(
    title: 'Registrar pagamento',
    busy: busy,
    error: error,
    submitLabel: 'Confirmar pagamento',
    children: [
      Text(
        '${widget.card.name} · vence ${widget.invoice.dueOn.display}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      Text('Em aberto: ${formatMoney(widget.invoice.balance)}'),
      TextField(
        key: const Key('invoice-payment-amount'),
        controller: amount,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Valor pago',
          prefixText: 'R\$ ',
        ),
      ),
      DropdownButtonFormField<String>(
        initialValue: accountId,
        isExpanded: true,
        decoration: const InputDecoration(labelText: 'Conta do pagamento'),
        items: widget.finance.activeAccounts
            .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
            .toList(),
        onChanged: (v) => setState(() => accountId = v!),
      ),
      DateField(
        date: date,
        label: 'Data do pagamento',
        onChanged: (v) => setState(() => date = v),
      ),
      const Text(
        'Registre somente um pagamento já realizado. O saldo da conta e a dívida diminuem, sem gerar outra despesa. '
        'Pagamento parcial mantém o vencimento original.',
        style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
      ),
    ],
    onSubmit: () => submit(
      () => ref
          .read(cardsRepositoryProvider)
          .payInvoice(
            requestId: requestId,
            invoiceId: widget.invoice.id,
            accountId: accountId,
            amount: Money.parse(amount.text),
            date: date,
          ),
    ),
  );
}
