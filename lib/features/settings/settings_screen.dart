import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan & Privasi'),
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.offline_pin_outlined, color: AppColors.primaryLight, size: 22),
                    SizedBox(width: 10),
                    Text(
                      '100% Offline & Privat',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Seluruh aturan hukum, SOP darurat, checklist audit, dan catatan pribadi tersimpan aman di perangkat lokal Anda tanpa pengiriman data ke server luar.',
                  style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Manajemen Data Lokal',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.danger),
              title: const Text('Hapus Catatan & Bookmark', style: TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: const Text('Mengosongkan semua simpanan dan catatan lokal', style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.bgSurface,
                    title: const Text('Hapus Semua Data?', style: TextStyle(color: Colors.white)),
                    content: const Text(
                      'Tindakan ini akan menghapus semua bookmark dan catatan aturan yang Anda buat.',
                      style: TextStyle(color: Color(0xFF94A3B8)),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
                        child: const Text('Hapus'),
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
                      const SnackBar(content: Text('Semua data bookmark dan catatan telah dibersihkan.')),
                    );
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Disclaimer Hukum & Batasan',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.gavel, color: AppColors.accent, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Pernyataan Penyangkalan (Disclaimer)',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'RuleBook adalah aplikasi buku saku digital independen yang ditujukan semata-mata untuk literasi hukum dan edukasi masyarakat. Konten aplikasi bukan merupakan nasihat hukum formal (legal counsel). Untuk kasus perdata atau pidana resmi, disarankan berkonsultasi langsung dengan advokat berizin atau lembaga bantuan hukum terakreditasi.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8), height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Tentang Aplikasi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildAboutRow('Aplikasi', AppConstants.appName),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Versi', '${AppConstants.appVersion}+1'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Ekosistem', 'Utility & Knowledge Fleet'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Subdomain', 'rulebook.faishal.id'),
                  const Divider(color: AppColors.border, height: 24),
                  _buildAboutRow('Application ID', 'id.faishal.rulebook'),
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
