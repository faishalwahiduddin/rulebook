import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_providers.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsAndPrivacy),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
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
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.offlineNoticeDetail,
                  style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            l10n.dataManagement,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.danger),
              title: Text(l10n.clearBookmarks, style: const TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: Text(l10n.deleteNotesBookmarksDesc, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.bgSurface,
                    title: Text(l10n.deleteAllDataConfirm, style: const TextStyle(color: Colors.white)),
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
          ),
          const SizedBox(height: 24),

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
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
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

          Text(
            l10n.aboutApplication,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}
