import '../../../shared/presentation/brand_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../shared/presentation/components.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool busy = false;
  String? status;
  bool failed = false;

  Future<void> execute(Future<String?> Function() action) async {
    if (busy) return;
    setState(() {
      busy = true;
      status = null;
      failed = false;
    });
    try {
      final message = await action();
      if (mounted) setState(() => status = message);
    } catch (error) {
      if (mounted) {
        setState(() {
          status = friendlyError(error);
          failed = true;
        });
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => FinanceView(
    builder: (snapshot) => PageBody(
      children: [
        const PageHeading(
          'Seu espaço, suas escolhas',
          'Organização e cuidado com os seus registros.',
        ),
        const SectionLabel('Cópia de segurança'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: CanguruuColors.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const CanguruuIcon(Icons.folder_copy_outlined),
                ),
                const SizedBox(height: 20),
                Text(
                  'Seus dados ficam neste dispositivo.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Exporte uma cópia para guardar seu histórico ou levá-lo a outro dispositivo. No navegador, limpar os dados do site remove os registros locais.',
                ),
                const SizedBox(height: 8),
                const Text(
                  'O arquivo contém seus registros sem senha. Guarde-o em um local privado.',
                  style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: busy
                          ? null
                          : () => execute(() async {
                              final content = await ref
                                  .read(repositoryProvider)
                                  .exportBackup();
                              final stamp = ref
                                  .read(clockProvider)
                                  .utcNow
                                  .toUtc()
                                  .toIso8601String()
                                  .replaceAll(':', '-');
                              final saved = await ref
                                  .read(backupFilesProvider)
                                  .saveBackup(content, 'canguruu-$stamp.json');
                              return saved
                                  ? 'Cópia exportada. Confira o arquivo na pasta escolhida ou nos downloads.'
                                  : null;
                            }),
                      icon: const CanguruuIcon(
                        Icons.download_outlined,
                        size: 19,
                      ),
                      label: const Text('Exportar cópia'),
                    ),
                    OutlinedButton.icon(
                      onPressed: busy
                          ? null
                          : () => execute(() async {
                              final content = await ref
                                  .read(backupFilesProvider)
                                  .pickBackup();
                              if (content == null) return null;
                              final repository = ref.read(repositoryProvider);
                              final summary = await repository.inspectBackup(
                                content,
                              );
                              if (!context.mounted) return null;
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text('Restaurar esta cópia?'),
                                  content: Text(
                                    'Cópia de ${summary.createdAt.toLocal().day.toString().padLeft(2, '0')}/${summary.createdAt.toLocal().month.toString().padLeft(2, '0')}/${summary.createdAt.toLocal().year}, com ${summary.accounts} contas, ${summary.cards} cartões, ${summary.scheduled} previsões e ${summary.events} movimentações.\n\nEla substituirá os dados atuais: ${snapshot.accounts.length} contas, ${snapshot.cardNames.length} cartões e ${snapshot.events.length} movimentações deste dispositivo. Exporte os dados atuais antes, se quiser preservá-los.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    FilledButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      child: const Text(
                                        'Substituir e restaurar',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmed != true) return null;
                              await repository.restoreBackup(content);
                              return 'Cópia restaurada. Saldos e histórico foram atualizados.';
                            }),
                      icon: const CanguruuIcon(Icons.restore_rounded, size: 19),
                      label: const Text('Restaurar cópia'),
                    ),
                  ],
                ),
                if (busy)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: LinearProgressIndicator(),
                  ),
                if (status != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      status!,
                      style: TextStyle(
                        color: failed
                            ? CanguruuColors.red
                            : CanguruuColors.green,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        const SectionLabel('Organização'),
        Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            leading: const CanguruuIcon(Icons.grid_view_outlined),
            title: const Text('Categorias e subcategorias'),
            subtitle: const Text(
              'Ajuste a organização das suas receitas e despesas.',
            ),
            trailing: const CanguruuIcon(Icons.chevron_right),
            onTap: () => context.go('/categories'),
          ),
        ),
        const SizedBox(height: 28),
        const SectionLabel('Sobre este aplicativo'),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Canguruu · Finanças pessoais',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text('Versão 0.4.0 · Seus dados neste dispositivo.'),
                  SizedBox(height: 8),
                  Text(
                    'Moeda: Real brasileiro · Calendário: São Paulo',
                    style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Metas e reservas locais já estão disponíveis; planejamento e projeções avançadas entram nas próximas etapas.',
                    style: TextStyle(fontSize: 12, color: CanguruuColors.muted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
