import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_providers.dart';
import '../../core/providers/locale_provider.dart';
import '../../core/providers/theme_provider.dart';
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

  static const Map<String, ({String title, String desc, String badge})> _licenseTexts = {
    'id': (
      title: 'Lisensi Penggunaan',
      desc: 'Bebas digunakan untuk keperluan personal dan non-profit.',
      badge: 'Personal & Non-Profit',
    ),
    'en': (
      title: 'Usage License',
      desc: 'Free to use for personal and non-profit use.',
      badge: 'Personal & Non-Profit',
    ),
    'ar': (
      title: 'ترخيص الاستخدام',
      desc: 'مجاني للاستخدام الشخصي وغير الربحي.',
      badge: 'شخصي وغير ربحي',
    ),
    'jv': (
      title: 'Lisensi Panganggo',
      desc: 'Bebas dienggo kanggo kaperluan pribadi lan non-profit.',
      badge: 'Pribadi & Non-Profit',
    ),
    'su': (
      title: 'Lisensi Pamakean',
      desc: 'Bebas dianggo pikeun kaperluan pribadi jeung non-profit.',
      badge: 'Pribadi & Non-Profit',
    ),
    'zh': (
      title: '使用许可',
      desc: '个人及非营利性用途免费使用。',
      badge: '个人与非营利',
    ),
    'ja': (
      title: '利用規約・ライセンス',
      desc: '個人および非営利目的での利用は無料です。',
      badge: '個人・非営利',
    ),
    'es': (
      title: 'Licencia de Uso',
      desc: 'Gratis para uso personal y sin fines de lucro.',
      badge: 'Personal y Sin Fines de Lucro',
    ),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final langCode = currentLocale.languageCode;
    final license = _licenseTexts[langCode] ?? _licenseTexts['en']!;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsAndPrivacy),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Section 1: Offline Notice
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.offline_pin_outlined, color: AppColors.primaryLight, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      l10n.offlineAndPrivate,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.offlineNoticeDetail,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section 2: Appearance & Theme
          const Text(
            'Tampilan & Tema',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.palette_outlined, color: AppColors.primaryLight, size: 20),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Mode Tema',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SegmentedButton<ThemeMode>(
                        segments: const [
                          ButtonSegment(
                            value: ThemeMode.system,
                            icon: Icon(Icons.brightness_auto, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.light,
                            icon: Icon(Icons.light_mode, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            icon: Icon(Icons.dark_mode, size: 16),
                          ),
                        ],
                        selected: {themeMode},
                        onSelectionChanged: (selected) {
                          ref.read(themeModeProvider.notifier).setThemeMode(selected.first);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section 3: Language Selection
          const Text(
            'Bahasa & Lokalisasi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.translate, color: AppColors.primaryLight),
              title: const Text('Pilihan Bahasa', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              subtitle: Text(
                '${_languages[langCode]?.nativeName ?? langCode} (${_languages[langCode]?.name ?? langCode})',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showLanguageModal(context, ref, currentLocale),
            ),
          ),
          const SizedBox(height: 24),

          // Section 4: Data Management
          Text(
            l10n.dataManagement,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.file_download_outlined, color: AppColors.success),
                  title: const Text('Ekspor Cadangan Data (JSON)', style: TextStyle(fontSize: 14)),
                  subtitle: const Text('Salin bookmark dan catatan ke clipboard', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                  trailing: const Icon(Icons.copy, size: 18),
                  onTap: () {
                    final jsonStr = ref.read(localStorageServiceProvider).exportBackupJson();
                    Clipboard.setData(ClipboardData(text: jsonStr));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cadangan data RuleBook berhasil disalin ke clipboard! 📋'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: AppColors.danger),
                  title: Text(l10n.clearBookmarks, style: const TextStyle(color: AppColors.danger, fontSize: 14)),
                  subtitle: Text(l10n.deleteNotesBookmarksDesc, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: isDark ? AppColors.bgSurface : Colors.white,
                        title: Text(l10n.deleteAllDataConfirm),
                        content: Text(
                          l10n.deleteAllDataDesc,
                          style: const TextStyle(color: Color(0xFF94A3B8)),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                            child: Text(l10n.delete),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await ref.read(localStorageServiceProvider).clearAllData();
                      ref.invalidate(bookmarksProvider);
                      ref.invalidate(ruleNotesProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.allBookmarksCleared)),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section 5: Legal & Disclaimer
          Text(
            l10n.disclaimerTitle,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.gavel, color: AppColors.accent, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        l10n.disclaimerTitle,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.disclaimerText,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section 6: About Application & Translated License
          Text(
            l10n.aboutApplication,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAboutRow(l10n.application, AppConstants.appName),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.version, '${AppConstants.appVersion}+1'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.ecosystem, 'Utility & Knowledge Fleet'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.subdomain, 'rulebook.faishal.id'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow(l10n.applicationId, 'id.faishal.rulebook'),
                  const Divider(color: AppColors.border, height: 24),
                  // License Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        license.title,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          license.badge,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    license.desc,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showLanguageModal(BuildContext context, WidgetRef ref, Locale currentLocale) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Pilih Bahasa / Select Language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  children: _languages.entries.map((entry) {
                    final isSelected = entry.key == currentLocale.languageCode;
                    return ListTile(
                      title: Text(entry.value.nativeName),
                      subtitle: Text(entry.value.name),
                      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
                      onTap: () {
                        ref.read(localeProvider.notifier).setLocale(Locale(entry.key));
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

  Widget _buildAboutRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
