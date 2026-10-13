import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

/// Super-minimal gamifikasi: menghitung butir aturan yang pernah dibuka.
/// State in-memory (tanpa codegen, tanpa backend) — satu angka + satu
/// badge, tanpa XP/level engine.
class ReadRuleIds extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  void mark(String id) {
    if (id.isEmpty || state.contains(id)) return;
    state = {...state, id};
  }
}

final readRuleIdsProvider =
    NotifierProvider<ReadRuleIds, Set<String>>(ReadRuleIds.new);

/// Menandai satu aturan sebagai dibaca. Aman dipanggil berulang.
void markRuleRead(WidgetRef ref, String id) {
  ref.read(readRuleIdsProvider.notifier).mark(id);
}

String _tierFor(int count, AppLocalizations l10n) {
  if (count >= 30) return l10n.tierExpert;
  if (count >= 15) return l10n.tierScholar;
  if (count >= 5) return l10n.tierLearner;
  if (count >= 1) return l10n.tierReader;
  return l10n.tierNew;
}

/// Badge "Aturan Dibaca" — tampil di bawah filter katalog.
class ReadBadge extends ConsumerWidget {
  final int total;
  const ReadBadge({super.key, required this.total});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.watch(readRuleIdsProvider);
    final count = read.length;
    final progress = total <= 0 ? 0.0 : (count / total).clamp(0.0, 1.0);
    final c = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final tier = _tierFor(count, l10n);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_book_outlined, size: 20, color: c.brand),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l10n.readBadgeTitle}  $count/$total  •  $tier',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: c.brand.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(c.brand),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.readBadgeShareTooltip,
            icon: const Icon(Icons.share_outlined, size: 20),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(
                  text:
                      '${l10n.readBadgeTitle} $count/$total • $tier #RuleBook',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
