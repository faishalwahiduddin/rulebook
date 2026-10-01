import 'package:flutter/material.dart';

/// RuleBook color system.
///
/// Two layers live here:
///  1. [AppPalette] — raw, brand-anchored hues (never used directly by screens).
///  2. [AppColors]  — semantic tokens resolved per brightness. Screens read
///     these through `AppColors.of(context)` so a single source of truth drives
///     both light and dark themes.
///
/// The palette is intentionally restrained (Swiss-modern): one indigo brand
/// hue, a slate neutral ramp, and a small set of category accents used only as
/// categorical signifiers — never as decoration.
class AppPalette {
  AppPalette._();

  // Brand — indigo (law & knowledge).
  static const Color indigo50 = Color(0xFFEEF2FF);
  static const Color indigo100 = Color(0xFFE0E7FF);
  static const Color indigo300 = Color(0xFFA5B4FC);
  static const Color indigo400 = Color(0xFF818CF8);
  static const Color indigo500 = Color(0xFF6366F1);
  static const Color indigo600 = Color(0xFF4F46E5);
  static const Color indigo700 = Color(0xFF4338CA);
  static const Color indigo800 = Color(0xFF3730A3);
  static const Color indigo900 = Color(0xFF312E81);

  // Neutrals — slate ramp.
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF080C17);

  // Feedback.
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald400 = Color(0xFF34D399);

  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber400 = Color(0xFFFBBF24);

  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red400 = Color(0xFFF87171);

  // Categorical accents (dark-theme variants are lightened for contrast).
  static const Color sky600 = Color(0xFF0284C7);
  static const Color sky400 = Color(0xFF38BDF8);
  static const Color violet600 = Color(0xFF7C3AED);
  static const Color violet400 = Color(0xFFA78BFA);
  static const Color pink600 = Color(0xFFDB2777);
  static const Color pink400 = Color(0xFFF472B6);
}

/// Semantic, brightness-resolved color tokens.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color brand;
  final Color onBrand;
  final Color brandSoft;
  final Color onBrandSoft;

  final Color background;
  final Color surface;
  final Color surfaceRaised;
  final Color surfaceSunken;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textFaint;

  final Color border;
  final Color borderStrong;
  final Color divider;

  final Color success;
  final Color successSoft;
  final Color warning;
  final Color warningSoft;
  final Color danger;
  final Color dangerSoft;

  final Color catTraffic;
  final Color catLabor;
  final Color catPrivacy;
  final Color catConsumer;
  final Color catSafety;
  final Color catEthics;

  const AppColors({
    required this.brand,
    required this.onBrand,
    required this.brandSoft,
    required this.onBrandSoft,
    required this.background,
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceSunken,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textFaint,
    required this.border,
    required this.borderStrong,
    required this.divider,
    required this.success,
    required this.successSoft,
    required this.warning,
    required this.warningSoft,
    required this.danger,
    required this.dangerSoft,
    required this.catTraffic,
    required this.catLabor,
    required this.catPrivacy,
    required this.catConsumer,
    required this.catSafety,
    required this.catEthics,
  });

  static const AppColors light = AppColors(
    brand: AppPalette.indigo600,
    onBrand: Color(0xFFFFFFFF),
    brandSoft: AppPalette.indigo50,
    onBrandSoft: AppPalette.indigo700,
    background: AppPalette.slate50,
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    surfaceSunken: AppPalette.slate100,
    textPrimary: AppPalette.slate900,
    textSecondary: AppPalette.slate600,
    textMuted: AppPalette.slate500,
    textFaint: AppPalette.slate400,
    border: AppPalette.slate200,
    borderStrong: AppPalette.slate300,
    divider: Color(0xFFEDF1F6),
    success: AppPalette.emerald600,
    successSoft: Color(0xFFECFDF5),
    warning: AppPalette.amber600,
    warningSoft: Color(0xFFFFFBEB),
    danger: AppPalette.red600,
    dangerSoft: Color(0xFFFEF2F2),
    catTraffic: AppPalette.sky600,
    catLabor: AppPalette.emerald600,
    catPrivacy: AppPalette.violet600,
    catConsumer: AppPalette.amber600,
    catSafety: AppPalette.red600,
    catEthics: AppPalette.pink600,
  );

  static const AppColors dark = AppColors(
    brand: AppPalette.indigo400,
    onBrand: AppPalette.slate950,
    brandSoft: Color(0xFF1C2143),
    onBrandSoft: AppPalette.indigo300,
    background: Color(0xFF0A0E1A),
    surface: Color(0xFF121726),
    surfaceRaised: Color(0xFF171D30),
    surfaceSunken: Color(0xFF0E1320),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFFC3CCDA),
    textMuted: Color(0xFF94A3B8),
    textFaint: Color(0xFF64748B),
    border: Color(0xFF27304A),
    borderStrong: Color(0xFF364159),
    divider: Color(0xFF1E263A),
    success: AppPalette.emerald400,
    successSoft: Color(0xFF0C2A22),
    warning: AppPalette.amber400,
    warningSoft: Color(0xFF2A2110),
    danger: AppPalette.red400,
    dangerSoft: Color(0xFF2C1518),
    catTraffic: AppPalette.sky400,
    catLabor: AppPalette.emerald400,
    catPrivacy: AppPalette.violet400,
    catConsumer: AppPalette.amber400,
    catSafety: AppPalette.red400,
    catEthics: AppPalette.pink400,
  );

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>() ?? light;

  @override
  AppColors copyWith({
    Color? brand,
    Color? onBrand,
    Color? brandSoft,
    Color? onBrandSoft,
    Color? background,
    Color? surface,
    Color? surfaceRaised,
    Color? surfaceSunken,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? textFaint,
    Color? border,
    Color? borderStrong,
    Color? divider,
    Color? success,
    Color? successSoft,
    Color? warning,
    Color? warningSoft,
    Color? danger,
    Color? dangerSoft,
    Color? catTraffic,
    Color? catLabor,
    Color? catPrivacy,
    Color? catConsumer,
    Color? catSafety,
    Color? catEthics,
  }) {
    return AppColors(
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      brandSoft: brandSoft ?? this.brandSoft,
      onBrandSoft: onBrandSoft ?? this.onBrandSoft,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      surfaceSunken: surfaceSunken ?? this.surfaceSunken,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      textFaint: textFaint ?? this.textFaint,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      divider: divider ?? this.divider,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      warning: warning ?? this.warning,
      warningSoft: warningSoft ?? this.warningSoft,
      danger: danger ?? this.danger,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      catTraffic: catTraffic ?? this.catTraffic,
      catLabor: catLabor ?? this.catLabor,
      catPrivacy: catPrivacy ?? this.catPrivacy,
      catConsumer: catConsumer ?? this.catConsumer,
      catSafety: catSafety ?? this.catSafety,
      catEthics: catEthics ?? this.catEthics,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      brand: mix(brand, other.brand),
      onBrand: mix(onBrand, other.onBrand),
      brandSoft: mix(brandSoft, other.brandSoft),
      onBrandSoft: mix(onBrandSoft, other.onBrandSoft),
      background: mix(background, other.background),
      surface: mix(surface, other.surface),
      surfaceRaised: mix(surfaceRaised, other.surfaceRaised),
      surfaceSunken: mix(surfaceSunken, other.surfaceSunken),
      textPrimary: mix(textPrimary, other.textPrimary),
      textSecondary: mix(textSecondary, other.textSecondary),
      textMuted: mix(textMuted, other.textMuted),
      textFaint: mix(textFaint, other.textFaint),
      border: mix(border, other.border),
      borderStrong: mix(borderStrong, other.borderStrong),
      divider: mix(divider, other.divider),
      success: mix(success, other.success),
      successSoft: mix(successSoft, other.successSoft),
      warning: mix(warning, other.warning),
      warningSoft: mix(warningSoft, other.warningSoft),
      danger: mix(danger, other.danger),
      dangerSoft: mix(dangerSoft, other.dangerSoft),
      catTraffic: mix(catTraffic, other.catTraffic),
      catLabor: mix(catLabor, other.catLabor),
      catPrivacy: mix(catPrivacy, other.catPrivacy),
      catConsumer: mix(catConsumer, other.catConsumer),
      catSafety: mix(catSafety, other.catSafety),
      catEthics: mix(catEthics, other.catEthics),
    );
  }
}
