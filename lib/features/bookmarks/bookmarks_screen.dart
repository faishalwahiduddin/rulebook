import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/app_providers.dart';
import '../catalog/rule_detail_screen.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarksProvider);
    final allRules = ref.watch(allRulesProvider);
    final bookmarkedRules = allRules.where((r) => bookmarkedIds.contains(r.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aturan Tersimpan'),
      ),
      body: bookmarkedRules.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bookmark_border, size: 40, color: AppColors.accent),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum Ada Aturan Tersimpan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Tekan ikon bookmark pada aturan untuk menyimpannya ke daftar akses cepat offline.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: bookmarkedRules.length,
              itemBuilder: (context, index) {
                final item = bookmarkedRules[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: item.category.tagColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.category.icon, color: item.category.tagColor, size: 22),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            item.summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1)),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.legalBasis,
                            style: const TextStyle(fontSize: 11, color: AppColors.accent, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.bookmark_remove, color: AppColors.danger, size: 20),
                        tooltip: 'Hapus dari Tersimpan',
                        onPressed: () {
                          ref.read(bookmarksProvider.notifier).toggleBookmark(item.id);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RuleDetailScreen(rule: item),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
