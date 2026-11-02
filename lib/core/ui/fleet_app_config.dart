import 'package:flutter/material.dart';

class FleetSlideItem {
  final String headline;
  final String subtext;
  final IconData? icon;
  final String? badgeText;

  const FleetSlideItem({
    required this.headline,
    required this.subtext,
    this.icon,
    this.badgeText,
  });
}

/// Brand colours and icons shared by the splash and onboarding screens.
///
/// Every user-visible string (app name, tagline, slides, buttons) comes from
/// `AppLocalizations` so it follows the selected language.
class FleetAppConfig {
  final Color primaryColor;
  final Color darkColor;
  final Color accentColor;
  final IconData fallbackIcon;

  /// Icons for the four onboarding slides, in slide order.
  final List<IconData> slideIcons;

  const FleetAppConfig({
    required this.primaryColor,
    required this.darkColor,
    required this.accentColor,
    required this.fallbackIcon,
    required this.slideIcons,
  });

  static const FleetAppConfig current = FleetAppConfig(
    primaryColor: Color(0xFF1E3A5F),
    darkColor: Color(0xFF0F172A),
    accentColor: Color(0xFFF59E0B),
    fallbackIcon: Icons.gavel_rounded,
    slideIcons: [
      Icons.menu_book_rounded,
      Icons.search_rounded,
      Icons.bookmark_rounded,
      Icons.offline_pin_rounded,
    ],
  );
}
