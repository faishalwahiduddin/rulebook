import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Scroll rhythm for shell vs pushed routes (glass tab bar clearance).
abstract final class AppScroll {
  /// Material navigation bar content height (excludes safe area).
  static const double shellNavContentHeight = 68;

  static const ScrollPhysics physics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  static double bottomClearance(
    BuildContext context, {
    bool underShellNav = true,
  }) {
    final safe = MediaQuery.paddingOf(context).bottom;
    if (!underShellNav) {
      return safe + AppSpacing.xxxl;
    }
    return safe + shellNavContentHeight + AppSpacing.xl + AppSpacing.lg;
  }

  static EdgeInsets listPadding(
    BuildContext context, {
    bool underShellNav = true,
    double top = AppSpacing.xs,
  }) {
    return EdgeInsets.fromLTRB(
      AppSpacing.lg,
      top,
      AppSpacing.lg,
      bottomClearance(context, underShellNav: underShellNav),
    );
  }

  static EdgeInsets pagePadding(
    BuildContext context, {
    bool underShellNav = true,
  }) {
    return EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.sm,
      AppSpacing.lg,
      bottomClearance(context, underShellNav: underShellNav),
    );
  }
}

/// iOS-style bounce on every scrollable in the app.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => AppScroll.physics;
}
