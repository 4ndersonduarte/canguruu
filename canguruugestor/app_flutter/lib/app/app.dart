import '../shared/presentation/brand_icon.dart';
import '../shared/presentation/brand_background.dart';
import 'dart:async';
import '../features/schedule/presentation/schedule_page.dart';
import '../features/cards/presentation/cards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../core/civil_date.dart';
import '../features/finance/presentation/accounts_page.dart';
import '../features/finance/presentation/categories_page.dart';
import '../features/finance/presentation/dashboard_page.dart';
import '../features/finance/presentation/movements_page.dart';
import '../features/backup/presentation/settings_page.dart';
import '../features/goals/presentation/goals_page.dart';
import 'providers.dart';
import 'theme.dart';

class CanguruuApp extends ConsumerStatefulWidget {
  const CanguruuApp({super.key});
  @override
  ConsumerState<CanguruuApp> createState() => _CanguruuAppState();
}

class _CanguruuAppState extends ConsumerState<CanguruuApp>
    with WidgetsBindingObserver {
  late final GoRouter router = GoRouter(
    routes: [
      for (final page in <(String, Widget)>[
        ('/', const DashboardPage()),
        ('/accounts', const AccountsPage()),
        ('/cards', const CardsPage()),
        ('/schedule', const SchedulePage()),
        ('/movements', const MovementsPage()),
        ('/categories', const CategoriesPage()),
        ('/settings', const SettingsPage()),
        ('/goals', const GoalsPage()),
      ])
        GoRoute(
          path: page.$1,
          pageBuilder: (_, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: _Shell(path: state.uri.path, child: page.$2),
          ),
        ),
    ],
  );
  Timer? timer;
  late CivilDate today;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    today = ref.read(clockProvider).today;
    timer = Timer.periodic(const Duration(minutes: 1), (_) => refreshDate());
  }

  void refreshDate() {
    final next = ref.read(clockProvider).today;
    if (today != next) {
      today = next;
      ref.invalidate(snapshotProvider);
      ref.invalidate(cardsSnapshotProvider);
      ref.invalidate(scheduleSnapshotProvider);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshDate();
      ref.invalidate(snapshotProvider);
      ref.invalidate(cardsSnapshotProvider);
      ref.invalidate(scheduleSnapshotProvider);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Canguruu · Finanças',
    debugShowCheckedModeBanner: false,
    theme: canguruuTheme(),
    locale: const Locale('pt', 'BR'),
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    supportedLocales: const [Locale('pt', 'BR')],
    routerConfig: router,
  );
}

class _Shell extends StatelessWidget {
  const _Shell({required this.path, required this.child});
  final String path;
  final Widget child;
  static const destinations = [
    ('/', 'Visão geral', Icons.space_dashboard_outlined),
    ('/accounts', 'Contas', Icons.account_balance_wallet_outlined),
    ('/cards', 'Cartões', Icons.credit_card_outlined),
    ('/schedule', 'Agenda', Icons.event_note_outlined),
    ('/movements', 'Histórico', Icons.swap_vert_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 1000;
    final selected = destinations.indexWhere((d) => d.$1 == path);
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              Container(
                width: 232,
                decoration: const BoxDecoration(
                  color: CanguruuColors.paper,
                  border: Border(right: BorderSide(color: CanguruuColors.line)),
                ),
                child: Material(
                  color: CanguruuColors.paper,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 26, 20, 30),
                        child: _Brand(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 10,
                        ),
                        child: Text(
                          'MINHAS FINANÇAS',
                          style: TextStyle(
                            fontSize: 10,
                            color: CanguruuColors.muted,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                      for (final destination in [
                        ...destinations,
                        ('/categories', 'Categorias', Icons.grid_view_outlined),
                        ('/goals', 'Metas', Icons.track_changes_outlined),
                      ])
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 4,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            selected: path == destination.$1,
                            selectedTileColor: CanguruuColors.yellow,
                            leading: CanguruuIcon(destination.$3, size: 21),
                            title: Text(
                              destination.$2,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () => context.go(destination.$1),
                          ),
                        ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          selected: path == '/settings',
                          selectedTileColor: CanguruuColors.offWhite,
                          leading: const CanguruuIcon(
                            Icons.tune_rounded,
                            size: 21,
                          ),
                          title: const Text(
                            'Preferências',
                            style: TextStyle(fontSize: 13),
                          ),
                          onTap: () => context.go('/settings'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(26, 0, 26, 24),
                        child: Text(
                          'SEU RITMO. SEU FUTURO.',
                          style: TextStyle(
                            fontSize: 9,
                            color: CanguruuColors.muted,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: CanguruuBackground(
                child: Column(
                  children: [
                    Container(
                      height: 76,
                      padding: EdgeInsets.symmetric(horizontal: wide ? 36 : 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: CanguruuColors.line),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (!wide)
                            const _Brand()
                          else
                            const Text(
                              'Meu espaço financeiro',
                              style: TextStyle(
                                fontSize: 12,
                                color: CanguruuColors.muted,
                              ),
                            ),
                          const Spacer(),
                          if (wide)
                            const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Row(
                                children: [
                                  CanguruuIcon(
                                    Icons.lock_outline_rounded,
                                    size: 14,
                                    color: CanguruuColors.muted,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Dados neste dispositivo',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: CanguruuColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          IconButton(
                            tooltip: 'Preferências e backup',
                            onPressed: () => context.go('/settings'),
                            icon: const CanguruuIcon(
                              Icons.tune_rounded,
                              size: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: NavigationBar(
                  animationDuration: Duration.zero,
                  height: 76,
                  backgroundColor: CanguruuColors.ink,
                  surfaceTintColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  selectedIndex: selected < 0 ? 0 : selected,
                  labelTextStyle: WidgetStateProperty.resolveWith(
                    (states) => TextStyle(
                      fontSize: 10,
                      color: states.contains(WidgetState.selected)
                          ? CanguruuColors.yellow
                          : Colors.white70,
                    ),
                  ),
                  onDestinationSelected: (index) =>
                      context.go(destinations[index].$1),
                  destinations: destinations
                      .map(
                        (d) => NavigationDestination(
                          icon: CanguruuIcon(d.$3, color: Colors.white70),
                          selectedIcon: CanguruuIcon(
                            d.$3,
                            color: CanguruuColors.yellow,
                          ),
                          label: d.$2,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    widthFactor: 1,
    child: SvgPicture.asset(
      'assets/brand/canguruu.svg',
      width: 104,
      height: 70,
      semanticsLabel: 'Logo Canguruu',
    ),
  );
}
