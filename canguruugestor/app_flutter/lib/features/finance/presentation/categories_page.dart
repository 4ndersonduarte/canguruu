import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../shared/presentation/components.dart';
import '../domain/models.dart';
import 'forms.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});
  @override
  Widget build(BuildContext context) => FinanceView(
    builder: (snapshot) => PageBody(
      children: [
        PageHeading(
          'Categorias',
          'Organize o que entra e entenda o que sai.',
          action: FilledButton.icon(
            onPressed: () => showCategoryForm(context, snapshot),
            icon: const CanguruuIcon(Icons.add, size: 18),
            label: const Text('Nova categoria'),
          ),
        ),
        for (final kind in [MovementKind.expense, MovementKind.income]) ...[
          SectionLabel(kind == MovementKind.expense ? 'Despesas' : 'Receitas'),
          Card(
            child: Column(
              children: [
                for (final category in snapshot.categories.where(
                  (c) => c.kind == kind && c.parentId == null,
                )) ...[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 7,
                    ),
                    leading: CanguruuIcon(
                      kind == MovementKind.expense
                          ? Icons.north_east
                          : Icons.south_west,
                    ),
                    title: Text(
                      category.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: kind == MovementKind.expense
                        ? Text(
                            '${category.costNature == CostNature.fixed ? 'Custo fixo' : 'Custo variável'}${category.essential ? ' · Essencial' : ''}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: CanguruuColors.muted,
                            ),
                          )
                        : null,
                  ),
                  for (final child in snapshot.categories.where(
                    (c) => c.parentId == category.id,
                  ))
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 62,
                        right: 24,
                      ),
                      leading: const CanguruuIcon(
                        Icons.subdirectory_arrow_right,
                        size: 18,
                      ),
                      title: Text(child.name),
                      subtitle: kind == MovementKind.expense
                          ? Text(
                              '${child.costNature == CostNature.fixed ? 'Custo fixo' : 'Custo variável'}${child.essential ? ' · Essencial' : ''}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: CanguruuColors.muted,
                              ),
                            )
                          : null,
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        const Text(
          'As classificações são guardadas em cada lançamento, preservando o histórico para as próximas análises.',
          style: TextStyle(color: CanguruuColors.muted, fontSize: 12),
        ),
      ],
    ),
  );
}
