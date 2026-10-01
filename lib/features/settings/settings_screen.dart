import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/timezone_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icons.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/app_timezone.dart';
import '../../core/widgets/app_ui.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const Map<String, ({String name, String nativeName})> _languages = {
    'id': (name: 'Indonesian', nativeName: 'Bahasa Indonesia'),
    'en': (name: 'English', nativeName: 'English'),
    'ar': (name: 'Arabic', nativeName: 'العربية'),
    'jv': (name: 'Javanese', nativeName: 'Basa Jawa'),
    'su': (name: 'Sundanese', nativeName: 'Basa Sunda'),
    'zh': (name: 'Chinese', nativeName: '中文 (简体)'),
    'ja': (name: 'Japanese', nativeName: '日本語'),
    'es': (name: 'Spanish', nativeName: 'Español'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final currentLocale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final langCode = currentLocale.languageCode;

    return Scaffold(
      appBar: appBar(context),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm,
            AppSpacing.lg, AppSpacing.xxxl),
        children: [
          // What this app does with your data: nothing, because it never
          // leaves the phone.
          AppCard(
            color: c.brandSoft.withValues(alpha: 0.4),
            borderColor: c.border,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(AppIconData.shield, size: 20, color: c.brand),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.offlineAndPrivate,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.offlineNoticeDetail,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: c.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.appearance, icon: AppIconData.sun),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Row(
                  children: [
                    AppIcon(AppIconData.moon, size: 18, color: c.textMuted),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        l10n.theme,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.system,
                          tooltip: l10n.themeSystem,
                          icon: AppIcon(AppIconData.auto,
                              size: 15, color: c.textMuted),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          tooltip: l10n.themeLight,
                          icon: AppIcon(AppIconData.sun,
                              size: 15, color: c.textMuted),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          tooltip: l10n.themeDark,
                          icon: AppIcon(AppIconData.moon,
                              size: 15, color: c.textMuted),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (selected) => ref
                          .read(themeModeProvider.notifier)
                          .setThemeMode(selected.first),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.language, icon: AppIconData.globe),
          AppCard(
            onTap: () => _showLanguageSheet(context, ref, currentLocale),
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                AppIcon(AppIconData.globe, size: 18, color: c.textMuted),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _languages[langCode]?.nativeName ?? langCode,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _languages[langCode]?.name ?? langCode,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: c.textMuted),
                      ),
                    ],
                  ),
                ),
                AppIcon(AppIconData.chevronRight, size: 16, color: c.textFaint),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.timezone, icon: AppIconData.clock),
          Semantics(
            button: true,
            label: l10n.timezone,
            child: AppCard(
              key: const Key('btn-timezone-picker'),
              onTap: () => _showTimezoneSheet(context, ref),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  AppIcon(AppIconData.clock, size: 18, color: c.textMuted),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      _currentTimezoneLabel(ref, l10n),
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  AppIcon(AppIconData.chevronRight,
                      size: 16, color: c.textFaint),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.dataManagement, icon: AppIconData.layers),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    final jsonStr = ref
                        .read(localStorageServiceProvider)
                        .exportBackupJson();
                    Clipboard.setData(ClipboardData(text: jsonStr));
                    final l = AppLocalizations.of(context)!;
                    final cc = AppColors.of(context);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text(l.backupCopiedSnackbar),
                        backgroundColor: cc.success,
                      ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        AppIcon(AppIconData.download,
                            size: 18, color: c.brand),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.exportBackupJson,
                                style: theme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.copyBookmarkNotesClipboard,
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: c.textMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, color: c.divider),
                InkWell(
                  onTap: () => _confirmClearAll(context, ref),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        AppIcon(AppIconData.trash, size: 18, color: c.danger),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.clearBookmarks,
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(color: c.danger),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.deleteNotesBookmarksDesc,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: c.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.disclaimerTitle, icon: AppIconData.gavel),
          Text(
            l10n.disclaimerText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: c.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          SectionHeader(title: l10n.aboutApplication, icon: AppIconData.info),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                _aboutRow(l10n.application, AppConstants.appName),
                _divider(c),
                _aboutRow(l10n.version, '${AppConstants.appVersion}+1'),
                _divider(c),
                _aboutRow(l10n.subdomain, 'rulebook.faishal.id'),
                _divider(c),
                _aboutRow(l10n.applicationId, 'id.faishal.rulebook'),
                _divider(c),
                _aboutRow(l10n.licenseLabel, l10n.licenseValue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(AppColors c) => Divider(height: 1, color: c.divider);

  Widget _aboutRow(String label, String value) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final c = AppColors.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: c.textMuted),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                value,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: c.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmClearAll(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteAllDataConfirm),
        content: Text(l10n.deleteAllDataDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(localStorageServiceProvider).clearAllData();
      ref.invalidate(bookmarksProvider);
      ref.invalidate(ruleNotesProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.allBookmarksCleared)));
      }
    }
  }

    /// Current zone as one line: `Asia/Jakarta (WIB, GMT+7)` when manual,
  /// `Otomatis · Asia/Jakarta (GMT+7)` on Auto. Offsets are live per
  /// instant, so DST zones show the right value today.
  String _currentTimezoneLabel(WidgetRef ref, AppLocalizations l10n) {
    final now = AppTimeZone.nowUtc();
    final manual = ref.watch(timezoneProvider);
    if (manual != null) {
      return _zoneOptionLabel(manual, now);
    }
    final device = ref.watch(timezoneNameProvider);
    return '${l10n.timezoneAuto} · $device '
        '(${AppTimeZone.offsetLabel(device, now)})';
  }

  /// `Asia/Jakarta (WIB, GMT+7)` for short-labeled zones, else
  /// `America/New_York (GMT-4)` — same shape as the shalat pilot.
  String _zoneOptionLabel(String ianaName, DateTime now) {
    final offset = AppTimeZone.offsetLabel(ianaName, now);
    for (final z in kCuratedZones) {
      if (z.iana == ianaName && z.shortLabel != null) {
        return '$ianaName (${z.shortLabel}, $offset)';
      }
    }
    return '$ianaName ($offset)';
  }

  /// Time-zone picker mirroring the language sheet above: Auto (follow
  /// device) + the curated zones, each with its live GMT offset. Curated
  /// options only — no free-text IANA input (§VAL: nothing unvalidated
  /// ever reaches storage).
  void _showTimezoneSheet(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    final now = AppTimeZone.nowUtc();
    final current = ref.read(timezoneProvider);
    final device = ref.read(timezoneNameProvider);
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.sm),
                child: Text(
                  l10n.timezone,
                  style: Theme.of(ctx).textTheme.titleMedium,
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      dense: true,
                      title: Text(
                        '${l10n.timezoneAuto} · $device '
                        '(${AppTimeZone.offsetLabel(device, now)})',
                      ),
                      trailing: current == null
                          ? AppIcon(AppIconData.checkCircle,
                              size: 20, color: c.brand)
                          : null,
                      onTap: () {
                        ref.read(timezoneProvider.notifier).resetToAuto();
                        Navigator.pop(ctx);
                      },
                    ),
                    for (final zone in kCuratedZones)
                      ListTile(
                        dense: true,
                        title: Text(_zoneOptionLabel(zone.iana, now)),
                        trailing: zone.iana == current
                            ? AppIcon(AppIconData.checkCircle,
                                size: 20, color: c.brand)
                            : null,
                        onTap: () {
                          ref
                              .read(timezoneProvider.notifier)
                              .setZone(zone.iana);
                          Navigator.pop(ctx);
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageSheet(
      BuildContext context, WidgetRef ref, Locale currentLocale) {

    final l10n = AppLocalizations.of(context)!;
    final c = AppColors.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.sm),
                child: Text(
                  l10n.selectLanguage,
                  style: Theme.of(ctx).textTheme.titleMedium,
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: _languages.entries.map((entry) {
                    final isSelected = entry.key == currentLocale.languageCode;
                    return ListTile(
                      dense: true,
                      title: Text(entry.value.nativeName),
                      subtitle: Text(entry.value.name),
                      trailing: isSelected
                          ? AppIcon(AppIconData.checkCircle,
                              size: 20, color: c.brand)
                          : null,
                      onTap: () {
                        ref
                            .read(localeProvider.notifier)
                            .setLocale(Locale(entry.key));
                        Navigator.pop(ctx);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
