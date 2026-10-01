import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/bookmarks/bookmarks_screen.dart';
import '../../features/calculator/penalty_calculator_screen.dart';
import '../../features/catalog/catalog_screen.dart';
import '../../features/catalog/rule_detail_screen.dart';
import '../../features/checklist/checklist_detail_screen.dart';
import '../../features/checklist/checklist_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/shell/navigation_shell.dart';
import '../../features/sop/sop_detail_screen.dart';
import '../../features/sop/sop_screen.dart';
import '../storage/rules_database.dart';
import '../../l10n/app_localizations.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Route location helpers so screens never hand-write path strings.
class AppRoutes {
  AppRoutes._();
  static const catalog = '/';
  static const calculator = '/calculator';
  static const sop = '/sop';
  static const checklist = '/checklist';
  static const bookmarks = '/bookmarks';
  static const settings = '/settings';

  static String rule(String id) => '/rule/$id';
  static String sopDetail(String id) => '/sop/$id';
  static String checklistDetail(String id) => '/checklist/$id';
}

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.catalog,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const CatalogScreen(),
              routes: [
                GoRoute(
                  path: 'rule/:id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final rule = RulesDatabase.findRule(state.pathParameters['id']);
                    if (rule == null) {
                      return const _MissingContentScreen(kind: _MissingKind.rule);
                    }
                    return RuleDetailScreen(rule: rule);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calculator',
              builder: (context, state) => const PenaltyCalculatorScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/sop',
              builder: (context, state) => const SopScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final sop = RulesDatabase.findSop(state.pathParameters['id']);
                    if (sop == null) {
                      return const _MissingContentScreen(kind: _MissingKind.sop);
                    }
                    return SopDetailScreen(sop: sop);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/checklist',
              builder: (context, state) => const ChecklistScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final checklist = RulesDatabase.findChecklist(state.pathParameters['id']);
                    if (checklist == null) {
                      return const _MissingContentScreen(kind: _MissingKind.checklist);
                    }
                    return ChecklistDetailScreen(checklist: checklist);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookmarks',
              builder: (context, state) => const BookmarksScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

enum _MissingKind { rule, sop, checklist }

/// Friendly fallback when a deep link points at content that no longer exists.
class _MissingContentScreen extends ConsumerWidget {
  final _MissingKind kind;
  const _MissingContentScreen({required this.kind});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off_rounded,
                  size: 40, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(
                l10n.missingTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.missingDesc,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => context.go(AppRoutes.catalog),
                child: Text(l10n.backToRules),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
