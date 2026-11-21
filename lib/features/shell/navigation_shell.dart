import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/ui/app_icon.dart';
import '../../core/ui/app_scroll.dart';
import '../../core/ui/glass_bar.dart';
import '../../core/ui/press_scale.dart';
import '../../l10n/app_localizations.dart';

/// Five-tab bottom navigation with frosted glass chrome overlaying content.
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final destinations = [
      (
        iconName: 'nav_rules',
        activeIconName: 'nav_rules_active',
        label: l10n.navCatalogShort,
      ),
      (
        iconName: 'nav_calculator',
        activeIconName: 'nav_calculator_active',
        label: l10n.navSimulationShort,
      ),
      (
        iconName: 'nav_sop',
        activeIconName: 'nav_sop_active',
        label: l10n.navSopShort,
      ),
      (
        iconName: 'nav_compliance',
        activeIconName: 'nav_compliance_active',
        label: l10n.navComplianceShort,
      ),
      (
        iconName: 'nav_bookmarks',
        activeIconName: 'nav_bookmarks_active',
        label: l10n.navBookmarks,
      ),
    ];

    return Scaffold(
      backgroundColor: c.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          navigationShell,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GlassBar(
              blurSigma: 22,
              opacity: isDark ? 0.78 : 0.82,
              borderSide: BarBorderSide.none,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.xl),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.xl),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: AppColors.hairlineBorder(context),
                      width: 0.5,
                    ),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: MediaQuery.withClampedTextScaling(
                    maxScaleFactor: 1.15,
                    child: SizedBox(
                      height: AppScroll.shellNavContentHeight,
                      child: Row(
                        children: [
                          for (var i = 0; i < destinations.length; i++)
                            _NavCell(
                              iconName: destinations[i].iconName,
                              activeIconName: destinations[i].activeIconName,
                              label: destinations[i].label,
                              selected: navigationShell.currentIndex == i,
                              onTap: () {
                                HapticFeedback.selectionClick();
                                _onTap(i);
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavCell extends StatelessWidget {
  const _NavCell({
    required this.iconName,
    required this.activeIconName,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String iconName;
  final String activeIconName;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final fg = selected ? c.onBrandSoft : c.textMuted;

    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: PressScale(
          scale: 0.93,
          haptic: false,
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: AppMotion.fast,
                curve: AppMotion.ease,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? c.brandSoft.withValues(alpha: 0.85)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: AppIcon(
                  selected ? activeIconName : iconName,
                  size: 23,
                  color: fg,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: fg,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
