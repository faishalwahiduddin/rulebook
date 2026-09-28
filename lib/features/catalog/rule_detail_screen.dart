import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/rule_item.dart';
import '../../core/providers/app_providers.dart';
import '../../core/utils/validators.dart';

class RuleDetailScreen extends ConsumerStatefulWidget {
  final RuleItem rule;

  const RuleDetailScreen({super.key, required this.rule});

  @override
  ConsumerState<RuleDetailScreen> createState() => _RuleDetailScreenState();
}

class _RuleDetailScreenState extends ConsumerState<RuleDetailScreen> {
  late TextEditingController _noteController;
  String? _noteError;
  bool _isSavingNote = false;

  @override
  void initState() {
    super.initState();
    final storage = ref.read(localStorageServiceProvider);
    final savedNote = storage.getNote(widget.rule.id) ?? '';
    _noteController = TextEditingController(text: savedNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _saveNote() async {
    final text = _noteController.text.trim();
    if (text.isEmpty) {
      await ref.read(ruleNotesProvider.notifier).deleteNote(widget.rule.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan dihapus.')),
        );
      }
      return;
    }

    final err = AppValidators.validateNoteText(text);
    if (err != null) {
      setState(() => _noteError = err);
      return;
    }

    setState(() => _isSavingNote = true);
    try {
      await ref.read(ruleNotesProvider.notifier).saveNote(widget.rule.id, text);
      if (mounted) {
        setState(() => _noteError = null);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil disimpan!')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSavingNote = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBookmarked = ref.watch(bookmarksProvider).contains(widget.rule.id);
    final allRules = ref.watch(allRulesProvider);
    final relatedRules = allRules
        .where((r) => r.category == widget.rule.category && r.id != widget.rule.id)
        .take(3)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rule.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Salin Ringkasan',
            onPressed: () {
              final text = '📖 ${widget.rule.title}\n'
                  'Dasar Hukum: ${widget.rule.legalBasis}\n'
                  'Intisari: ${widget.rule.summary}\n'
                  'Sanksi/Hak: ${widget.rule.penaltyOrRight}\n\n'
                  'Aplikasi RuleBook (https://rulebook.faishal.id)';
              _copyToClipboard(text, 'Ringkasan aturan berhasil disalin!');
            },
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AppColors.accent : Colors.white,
            ),
            tooltip: isBookmarked ? 'Hapus Simpanan' : 'Simpan Aturan',
            onPressed: () {
              ref.read(bookmarksProvider.notifier).toggleBookmark(widget.rule.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Category Badge & Legal Basis
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: widget.rule.category.tagColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.rule.category.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: widget.rule.category.tagColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.gavel, size: 16, color: AppColors.accent),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.rule.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.menu_book, size: 14, color: Color(0xFF94A3B8)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.rule.legalBasis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Sanksi atau Hak Card
                Card(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: AppColors.danger.withValues(alpha: 0.3)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sanksi / Hak Resmi',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.danger,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.rule.penaltyOrRight,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Full Explanation Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Penjelasan Intisari',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.rule.fullExplanation,
                          style: const TextStyle(fontSize: 13, color: Color(0xFFCBD5E1), height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Key DOs and DONTs
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Panduan Praktis di Lapangan',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        const SizedBox(height: 14),
                        ...widget.rule.keyDos.map((doItem) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.check_circle, size: 18, color: AppColors.success),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(doItem, style: const TextStyle(fontSize: 13, color: Color(0xFFE2E8F0))),
                                  ),
                                ],
                              ),
                            )),
                        const Divider(color: AppColors.border, height: 20),
                        ...widget.rule.keyDonts.map((dontItem) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.cancel, size: 18, color: AppColors.danger),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(dontItem, style: const TextStyle(fontSize: 13, color: Color(0xFFE2E8F0))),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Personal Note Section (§VAL)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.edit_note, size: 20, color: AppColors.primaryLight),
                            SizedBox(width: 8),
                            Text(
                              'Catatan Pribadi',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _noteController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tuliskan catatan kasus, tanggal kejadian, atau pengingat...',
                            errorText: _noteError,
                          ),
                          onChanged: (val) {
                            if (_noteError != null) {
                              setState(() => _noteError = AppValidators.validateNoteText(val));
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: _isSavingNote ? null : _saveNote,
                            icon: const Icon(Icons.save, size: 16),
                            label: const Text('Simpan Catatan'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Related Rules in same category
                if (relatedRules.isNotEmpty) ...[
                  Text(
                    'Aturan Terkait dalam ${widget.rule.category.label}',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  ...relatedRules.map((rel) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(rel.category.icon, color: rel.category.tagColor, size: 20),
                        title: Text(rel.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                        subtitle: Text(rel.legalBasis, style: const TextStyle(fontSize: 11, color: AppColors.accent)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF64748B)),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RuleDetailScreen(rule: rel),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
