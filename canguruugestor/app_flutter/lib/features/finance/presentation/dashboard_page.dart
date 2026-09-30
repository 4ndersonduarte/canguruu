import '../../../shared/presentation/brand_heading.dart';
import '../../../shared/presentation/brand_icon.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../schedule/presentation/agenda_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/civil_date.dart';
import '../../../core/money.dart';
import '../../../shared/presentation/components.dart';
import '../../../shared/presentation/formatters.dart';
import '../domain/models.dart';
import '../../analysis/domain/models.dart';
import 'event_tile.dart';
import 'forms.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});
  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  CivilDate? selectedMonth;
  @override
  Widget build(BuildContext context) => FinanceView(
    builder: (snapshot) {
      final month = selectedMonth ?? snapshot.asOf.monthStart;
      final schedule = ref.watch(scheduleSnapshotProvider).valueOrNull;
      final analysis = FinancialAnalysis.calculate(finance: snapshot, schedule: schedule, month: month);
      final income = snapshot.incomeIn(month);
      final expense = snapshot.expenseIn(month);
      final result = income - expense;
      final hidden = ref.watch(hiddenAmountsProvider);
      final recent = snapshot.events
          .where((e) => e.date.monthStart == month)
          .take(5)
          .toList();
      return PageBody(
        children: [
          PageHeading(
            'Seu dinheiro',
            '',
            action: FilledButton.icon(
              onPressed: () => snapshot.activeAccounts.isEmpty
                  ? showAccountForm(context)
                  : showMovementForm(context, snapshot),
              icon: const CanguruuIcon(Icons.add, size: 19),
              label: Text(
                snapshot.activeAccounts.isEmpty
                    ? 'Adicionar conta'
                    : 'Nova movimentação',
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final balanceCard = Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: CanguruuColors.ink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'SALDO DAS CONTAS',
                            style: TextStyle(
                              color: Color(0xFFBFC2B5),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: hidden
                              ? 'Mostrar valores'
                              : 'Ocultar valores',
                          onPressed: () =>
                              ref.read(hiddenAmountsProvider.notifier).state =
                                  !hidden,
                          icon: CanguruuIcon(
                            hidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        formatMoney(snapshot.balance, hidden: hidden),
                        style: CanguruuType.amount.copyWith(
                          color: Colors.white,
                          fontSize: 34,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: CanguruuColors.yellow,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${snapshot.accounts.length} ${snapshot.accounts.length == 1 ? 'conta' : 'contas'}',
                            style: const TextStyle(
                              color: Color(0xFFBFC2B5),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              final quick = Card(
                color: CanguruuColors.paper,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Movimentar',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _QuickAction(
                            'Receita',
                            Icons.south_west,
                            () => snapshot.activeAccounts.isEmpty
                                ? showAccountForm(context)
                                : showMovementForm(
                                    context,
                                    snapshot,
                                    kind: MovementKind.income,
                                  ),
                          ),
                          _QuickAction(
                            'Despesa',
                            Icons.north_east,
                            () => snapshot.activeAccounts.isEmpty
                                ? showAccountForm(context)
                                : showMovementForm(context, snapshot),
                          ),
                          if (snapshot.activeAccounts.length >= 2)
                            _QuickAction(
                              'Transferir',
                              Icons.swap_horiz,
                              () => showMovementForm(
                                context,
                                snapshot,
                                kind: MovementKind.transfer,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
              if (constraints.maxWidth < 800) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [balanceCard, const SizedBox(height: 16), quick],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: balanceCard),
                  const SizedBox(width: 20),
                  Expanded(flex: 6, child: quick),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CanguruuHeading(
                  'Seu mês',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                tooltip: 'Mês anterior',
                onPressed: month.year == 1900 && month.month == 1
                    ? null
                    : () => setState(() => selectedMonth = month.inMonth(-1)),
                icon: const CanguruuIcon(Icons.chevron_left),
              ),
              Text(
                DateFormat('MMM yyyy', 'pt_BR').format(month.dateTime),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              IconButton(
                tooltip: 'Próximo mês',
                onPressed: month == snapshot.asOf.monthStart
                    ? null
                    : () => setState(() => selectedMonth = month.inMonth(1)),
                icon: const CanguruuIcon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final cards = [
                _Metric(
                  'Receitas',
                  income,
                  'Entradas registradas no mês',
                  hidden,
                  CanguruuColors.green,
                ),
                _Metric(
                  'Despesas',
                  expense,
                  'Consumo líquido de estornos',
                  hidden,
                  CanguruuColors.red,
                ),
                _Metric(
                  'Resultado do mês',
                  result,
                  'Receitas menos despesas',
                  hidden,
                  CanguruuColors.ink,
                  yellow: true,
                ),
              ];
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: cards
                    .map(
                      (card) => SizedBox(
                        width: constraints.maxWidth < 650
                            ? constraints.maxWidth
                            : (constraints.maxWidth - 32) / 3,
                        child: card,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 28),
          if (snapshot.events.isNotEmpty && !hidden) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _BalanceChart(snapshot: snapshot, month: month),
              ),
            ),
            const SizedBox(height: 28),
          ],
          if (snapshot.cardDebts.isNotEmpty) ...[
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _Metric(
                  'Dívida dos cartões',
                  snapshot.cardDebt,
                  'Inclui todas as parcelas contratadas',
                  hidden,
                  CanguruuColors.red,
                ),
                _Metric(
                  'Patrimônio registrado',
                  snapshot.netWorth,
                  'Contas menos dívidas dos cartões',
                  hidden,
                  CanguruuColors.ink,
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: () => context.go('/cards'),
              icon: const CanguruuIcon(Icons.credit_card_outlined),
              label: const Text('Ver cartões'),
            ),
            const SizedBox(height: 20),
          ],
          if (analysis.recommendations.isNotEmpty) ...[
            _RecommendationCard(recommendation: analysis.recommendations.first),
            const SizedBox(height: 24),
          ],
          const AgendaSummary(),
          SectionLabel(
            'Últimas movimentações',
            trailing: TextButton(
              onPressed: () => context.go('/movements'),
              child: const Text('Ver histórico →'),
            ),
          ),
          if (recent.isEmpty)
            EmptyCard(
              icon: Icons.receipt_long_outlined,
              title: snapshot.accounts.isEmpty
                  ? 'Vamos começar?'
                  : 'Nenhuma movimentação',
              message: snapshot.accounts.isEmpty
                  ? 'Adicione uma conta ou carteira com seu saldo atual.'
                  : 'Seus registros deste mês aparecerão aqui.',
              action: snapshot.accounts.isEmpty
                  ? FilledButton(
                      onPressed: () => showAccountForm(context),
                      child: const Text('Cadastrar conta'),
                    )
                  : null,
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
                    for (var i = 0; i < recent.length; i++) ...[
                      EventTile(event: recent[i], snapshot: snapshot),
                      if (i < recent.length - 1) const Divider(height: 1),
                    ],
                  ],
                ),
              ),
            ),
          if (snapshot.accounts.any((a) => a.balance.cents < 0)) ...[
            const SizedBox(height: 18),
            const Text(
              'Há contas com saldo negativo. Confira os registros e os valores disponíveis antes de novas saídas.',
              style: TextStyle(color: CanguruuColors.red),
            ),
          ],
          const SizedBox(height: 24),
          const ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text('Sobre os valores', style: TextStyle(fontSize: 12)),
            childrenPadding: EdgeInsets.only(bottom: 16),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Os totais consideram os dados cadastrados. Saldo inicial e transferências não entram como receitas ou despesas. Despesas descontam os estornos. O resultado do mês é a diferença entre receitas e despesas.',
                style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
              ),
              SizedBox(height: 8),
              Text(
                'A dívida dos cartões inclui todas as parcelas contratadas. O patrimônio registrado é o saldo das contas menos essa dívida.',
                style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
              ),
            ],
          ),
        ],
      );
    },
  );
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.recommendation});
  final Recommendation recommendation;
  @override
  Widget build(BuildContext context) => Card(
    color: CanguruuColors.yellowWash,
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CanguruuIcon(Icons.auto_awesome_outlined, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Canguruu percebeu', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                Text(recommendation.decision, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 5),
                Text(recommendation.explanation, style: const TextStyle(color: CanguruuColors.muted)),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 6, children: [
                  for (final factor in recommendation.factors)
                    Text(factor, style: const TextStyle(fontSize: 11, color: CanguruuColors.muted)),
                ]),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
class _QuickAction extends StatelessWidget {
  const _QuickAction(this.label, this.icon, this.onPressed);
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: CanguruuColors.yellowWash,
            shape: BoxShape.circle,
          ),
          child: CanguruuIcon(icon, size: 20),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric(
    this.title,
    this.value,
    this.caption,
    this.hidden,
    this.color, {
    this.yellow = false,
  });
  final String title;
  final Money value;
  final String caption;
  final bool hidden;
  final Color color;
  final bool yellow;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: yellow ? CanguruuColors.yellowWash : CanguruuColors.paper,
      border: Border.all(color: CanguruuColors.line),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tooltip(
          message: caption,
          child: Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 18),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            formatMoney(value, hidden: hidden),
            style: CanguruuType.amount,
          ),
        ),
      ],
    ),
  );
}

class _BalanceChart extends StatelessWidget {
  const _BalanceChart({required this.snapshot, required this.month});
  final FinanceSnapshot snapshot;
  final CivilDate month;
  @override
  Widget build(BuildContext context) {
    final end = month == snapshot.asOf.monthStart
        ? snapshot.asOf
        : month.inMonth(1).addDays(-1);
    final values = [
      for (var day = 1; day <= end.day; day++)
        snapshot.balanceOn(CivilDate(month.year, month.month, day)).cents,
    ];
    final minimum = values.reduce(math.min);
    final maximum = values.reduce(math.max);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Evolução do saldo',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        const Text(
          'Saldo ao fim do dia',
          style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 24,
          runSpacing: 8,
          children: [
            Text(
              'Maior: ${formatMoney(Money(maximum))}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Menor: ${formatMoney(Money(minimum))}',
              style: const TextStyle(fontSize: 12, color: CanguruuColors.muted),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Semantics(
          label:
              'Saldo de ${month.display} a ${end.display}. Inicial ${formatMoney(Money(values.first))}. Final ${formatMoney(Money(values.last))}.',
          child: SizedBox(
            height: 130,
            width: double.infinity,
            child: CustomPaint(painter: _LinePainter(values)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              month.display,
              style: const TextStyle(fontSize: 11, color: CanguruuColors.muted),
            ),
            Text(
              end.display,
              style: const TextStyle(fontSize: 11, color: CanguruuColors.muted),
            ),
          ],
        ),
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter(this.values);
  final List<int> values;
  @override
  void paint(Canvas canvas, Size size) {
    final min = values.reduce(math.min).toDouble();
    final max = values.reduce(math.max).toDouble();
    final range = max == min ? 1.0 : max - min;
    final grid = Paint()
      ..color = CanguruuColors.line
      ..strokeWidth = 1;
    for (var i = 0; i <= 3; i++) {
      final y = 8 + (size.height - 16) * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * i / (values.length - 1);
      final y = max == min
          ? size.height / 2
          : size.height - 8 - (values[i] - min) / range * (size.height - 16);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(
        Offset(x, y),
        values.length == 1 ? 5 : 2.5,
        Paint()..color = CanguruuColors.ink,
      );
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = CanguruuColors.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => oldDelegate.values != values;
}
