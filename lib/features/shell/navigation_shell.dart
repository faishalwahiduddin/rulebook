import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../l10n/app_localizations.dart';

/// The five-tab bottom navigation. Destinations carry short, human labels and
/// the bespoke [AppIcon] family so the bar reads clean at 360dp.
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
    final c = AppColors.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: c.surface,
          border: Border(top: BorderSide(color: c.border)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: [
            NavigationDestination(
              icon: AppIcon(AppIconData.book, color: c.textMuted),
              selectedIcon: AppIcon(AppIconData.book, color: c.onBrandSoft),
              label: l10n.navCatalogShort,
            ),
            NavigationDestination(
              icon: AppIcon(AppIconData.calculator, color: c.textMuted),
              selectedIcon: AppIcon(AppIconData.calculator, color: c.onBrandSoft),
              label: l10n.navSimulationShort,
            ),
            NavigationDestination(
              icon: AppIcon(AppIconData.shield, color: c.textMuted),
              selectedIcon: AppIcon(AppIconData.shield, color: c.onBrandSoft),
              label: l10n.navSopShort,
            ),
            NavigationDestination(
              icon: AppIcon(AppIconData.checklist, color: c.textMuted),
              selectedIcon: AppIcon(AppIconData.checklist, color: c.onBrandSoft),
              label: l10n.navComplianceShort,
            ),
            NavigationDestination(
              icon: AppIcon(AppIconData.bookmark, color: c.textMuted),
              selectedIcon: AppIcon(AppIconData.bookmarkFilled, color: c.onBrandSoft),
              label: l10n.navBookmarks,
            ),
          ],
        ),
      ),
    );
  }
}
