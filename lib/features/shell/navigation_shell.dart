import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../l10n/app_localizations.dart';

class NavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShell({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          backgroundColor: AppColors.bgSurface,
          indicatorColor: AppColors.primary.withValues(alpha: 0.25),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.auto_stories_outlined),
              selectedIcon: const Icon(Icons.auto_stories, color: AppColors.primaryLight),
              label: l10n.navCatalogShort,
            ),
            NavigationDestination(
              icon: const Icon(Icons.calculate_outlined),
              selectedIcon: const Icon(Icons.calculate, color: AppColors.primaryLight),
              label: l10n.navSimulationShort,
            ),
            NavigationDestination(
              icon: const Icon(Icons.shield_outlined),
              selectedIcon: const Icon(Icons.shield, color: AppColors.accent),
              label: l10n.navSopShort,
            ),
            NavigationDestination(
              icon: const Icon(Icons.fact_check_outlined),
              selectedIcon: const Icon(Icons.fact_check, color: AppColors.success),
              label: l10n.navComplianceShort,
            ),
            NavigationDestination(
              icon: const Icon(Icons.bookmark_outline),
              selectedIcon: const Icon(Icons.bookmark, color: AppColors.primaryLight),
              label: l10n.navBookmarks,
            ),
          ],
        ),
      ),
    );
  }
}

