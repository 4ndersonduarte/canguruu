import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/forms.dart';
import '../../../app/providers.dart';
import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import '../domain/models.dart';

Future<void> showAccountForm(BuildContext context) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => const AccountForm(),
);
Future<void> showMovementForm(
  BuildContext context,
  FinanceSnapshot snapshot, {
  MovementKind kind = MovementKind.expense,
}) => showDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (_) => MovementForm(snapshot: snapshot, initialKind: kind),
);
Future<void> showCategoryForm(BuildContext context, FinanceSnapshot snapshot) =>
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CategoryForm(snapshot: snapshot),
    );

class AccountForm extends ConsumerStatefulWidget {
  const AccountForm({super.key});
  @override
  ConsumerState<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends ConsumerState<AccountForm>
    with SubmitState<AccountForm> {
  final name = TextEditingController();
  final balance = TextEditingController(text: '0,00');
  AccountKind kind = AccountKind.bank;
  late CivilDate date = ref.read(clockProvider).today;
  @override
  void dispose() {
    name.dispose();
    balance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormPanel(
    title: 'Adicionar conta',
    busy: busy,
    error: error,
    children: [
      TextField(
        key: const Key('account-name'),
        controller: name,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        maxLength: 80,
        decoration: const InputDecoration(
          labelText: 'Nome da conta',
          hintText: 'Ex.: Conta principal',
        ),
      ),
      SegmentedButton<AccountKind>(
        segments: const [
          ButtonSegment(
            value: AccountKind.bank,
            label: Text('Conta bancária'),
            icon: CanguruuIcon(Icons.account_balance_outlined),
          ),
          ButtonSegment(
            value: AccountKind.wallet,
            label: Text('Carteira'),
            icon: CanguruuIcon(Icons.wallet_outlined),
          ),
        ],
        selected: {kind},
        onSelectionChanged: (v) => setState(() => kind = v.single),
      ),
      TextField(
        key: const Key('opening-balance'),
        controller: balance,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        decoration: const InputDecoration(
          labelText: 'Saldo inicial',
          prefixText: 'R\$ ',
        ),
      ),
      DateField(
        date: date,
        label: 'Data do saldo',
        onChanged: (v) => setState(() => date = v),
      ),
      const Text(
        'Informe quanto havia na conta nesta data. Esse saldo não será contado como receita.',
        style: TextStyle(fontSize: 12),
      ),
    ],
    onSubmit: () => submit(
      () => ref
          .read(actionsProvider)
          .createAccount(
            requestId: requestId,
            name: name.text,
            kind: kind,
            openingBalance: Money.parse(balance.text),
            openedOn: date,
          ),
    ),
  );
}

class MovementForm extends ConsumerStatefulWidget {
  const MovementForm({
    super.key,
    required this.snapshot,
    required this.initialKind,
  });
  final FinanceSnapshot snapshot;
  final MovementKind initialKind;
  @override
  ConsumerState<MovementForm> createState() => _MovementFormState();
}

class _MovementFormState extends ConsumerState<MovementForm>
    with SubmitState<MovementForm> {
  final description = TextEditingController();
  final amount = TextEditingController();
  late MovementKind kind = widget.initialKind;
  late String accountId = widget.snapshot.activeAccounts.first.id;
  String? destinationId;
  String? categoryId;
  late CivilDate date = ref.read(clockProvider).today;
  @override
  void dispose() {
    description.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accounts = widget.snapshot.activeAccounts;
    final categories = widget.snapshot.categories
        .where((c) => !c.archived && c.kind == kind)
        .toList();
    return FormPanel(
      title: 'Nova movimentação',
      busy: busy,
      error: error,
      submitLabel: 'Registrar movimentação',
      children: [
        SegmentedButton<MovementKind>(
          showSelectedIcon: false,
          segments: [
            const ButtonSegment(
              value: MovementKind.income,
              label: Text('Receita'),
            ),
            const ButtonSegment(
              value: MovementKind.expense,
              label: Text('Despesa'),
            ),
            ButtonSegment(
              value: MovementKind.transfer,
              label: const Text('Transferir'),
              enabled: accounts.length >= 2,
            ),
          ],
          selected: {kind},
          onSelectionChanged: (v) => setState(() {
            kind = v.single;
            categoryId = null;
            destinationId = null;
          }),
        ),
        TextField(
          key: const Key('movement-amount'),
          controller: amount,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
            labelText: 'Valor',
            prefixText: 'R\$ ',
            hintText: '0,00',
          ),
        ),
        TextField(
          key: const Key('movement-description'),
          controller: description,
          maxLength: 160,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Descrição',
            hintText: 'O que você está registrando?',
          ),
        ),
        DropdownButtonFormField<String>(
          key: const Key('movement-account'),
          initialValue: accountId,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: kind == MovementKind.transfer
                ? 'Conta de origem'
                : 'Conta',
          ),
          items: accounts
              .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
              .toList(),
          onChanged: (v) => setState(() {
            accountId = v!;
            if (destinationId == v) destinationId = null;
          }),
        ),
        if (kind == MovementKind.transfer)
          DropdownButtonFormField<String>(
            key: ValueKey('destination-$accountId'),
            initialValue: destinationId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Conta de destino'),
            items: accounts
                .where((a) => a.id != accountId)
                .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                .toList(),
            onChanged: (v) => setState(() => destinationId = v),
          )
        else
          DropdownButtonFormField<String>(
            key: ValueKey('category-${kind.name}'),
            initialValue: categoryId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Categoria'),
            items: categories
                .map(
                  (c) => DropdownMenuItem(
                    value: c.id,
                    child: Text(
                      widget.snapshot.categoryName(c.id),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() => categoryId = v),
          ),
        DateField(date: date, onChanged: (v) => setState(() => date = v)),
        if (kind == MovementKind.transfer)
          const Text(
            'A transferência move dinheiro entre suas contas. Ela não aumenta receitas ou despesas.',
            style: TextStyle(fontSize: 12),
          ),
      ],
      onSubmit: () => submit(
        () => ref
            .read(actionsProvider)
            .record(
              requestId: requestId,
              kind: kind,
              amount: Money.parse(amount.text),
              date: date,
              description: description.text,
              accountId: accountId,
              destinationId: kind == MovementKind.transfer
                  ? destinationId
                  : null,
              categoryId: kind == MovementKind.transfer ? null : categoryId,
            ),
      ),
    );
  }
}

class CategoryForm extends ConsumerStatefulWidget {
  const CategoryForm({super.key, required this.snapshot});
  final FinanceSnapshot snapshot;
  @override
  ConsumerState<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends ConsumerState<CategoryForm>
    with SubmitState<CategoryForm> {
  final name = TextEditingController();
  MovementKind kind = MovementKind.expense;
  String? parentId;
  CostNature nature = CostNature.variable;
  bool essential = false;
  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormPanel(
    title: 'Nova categoria',
    busy: busy,
    error: error,
    children: [
      TextField(
        controller: name,
        maxLength: 80,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Nome da categoria'),
      ),
      SegmentedButton<MovementKind>(
        segments: const [
          ButtonSegment(value: MovementKind.expense, label: Text('Despesa')),
          ButtonSegment(value: MovementKind.income, label: Text('Receita')),
        ],
        selected: {kind},
        onSelectionChanged: (v) => setState(() {
          kind = v.single;
          parentId = null;
        }),
      ),
      DropdownButtonFormField<String>(
        key: ValueKey(kind),
        initialValue: parentId ?? '',
        isExpanded: true,
        decoration: const InputDecoration(labelText: 'Categoria principal'),
        items: [
          const DropdownMenuItem(
            value: '',
            child: Text('Nenhuma · categoria principal'),
          ),
          ...widget.snapshot.categories
              .where((c) => c.kind == kind && c.parentId == null && !c.archived)
              .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))),
        ],
        onChanged: (v) => setState(() => parentId = v == '' ? null : v),
      ),
      if (kind == MovementKind.expense) ...[
        SegmentedButton<CostNature>(
          segments: const [
            ButtonSegment(value: CostNature.fixed, label: Text('Custo fixo')),
            ButtonSegment(
              value: CostNature.variable,
              label: Text('Custo variável'),
            ),
          ],
          selected: {nature},
          onSelectionChanged: (v) => setState(() => nature = v.single),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Despesa essencial'),
          value: essential,
          onChanged: (v) => setState(() => essential = v),
        ),
      ],
    ],
    onSubmit: () => submit(
      () => ref
          .read(repositoryProvider)
          .createCategory(
            requestId: requestId,
            name: name.text,
            kind: kind,
            parentId: parentId,
            costNature: kind == MovementKind.income
                ? CostNature.variable
                : nature,
            essential: kind == MovementKind.expense && essential,
          ),
    ),
  );
}
