import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/models/rule_item.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/utils/app_timezone.dart';
import '../../../core/utils/web_download_helper.dart';
import '../../../l10n/app_localizations.dart';

enum RuleShareAspectRatio {
  feed('4:5 Feed', 4 / 5, 1080, 1350),
  story('9:16 Story', 9 / 16, 1080, 1920);

  final String label;
  final double ratio;
  final double width;
  final double height;

  const RuleShareAspectRatio(this.label, this.ratio, this.width, this.height);
}

enum RuleShareTheme {
  pactNavy(
    name: 'Pact Navy',
    gradient: [Color(0xFF0F172A), Color(0xFF1E293B)],
    accentColor: Color(0xFFF59E0B),
    badgeBackground: Color(0xFF334155),
    cardBackground: Color(0xFF1E293B),
    textColor: Colors.white,
    secondaryTextColor: Color(0xFF94A3B8),
  ),
  crimsonClause(
    name: 'Crimson Clause',
    gradient: [Color(0xFF450A0A), Color(0xFF1C1917)],
    accentColor: Color(0xFFEF4444),
    badgeBackground: Color(0xFF7F1D1D),
    cardBackground: Color(0xFF292524),
    textColor: Colors.white,
    secondaryTextColor: Color(0xFFA8A29E),
  ),
  emeraldShield(
    name: 'Emerald Shield',
    gradient: [Color(0xFF064E3B), Color(0xFF065F46)],
    accentColor: Color(0xFF10B981),
    badgeBackground: Color(0xFF047857),
    cardBackground: Color(0xFF064E3B),
    textColor: Colors.white,
    secondaryTextColor: Color(0xFFA7F3D0),
  ),
  slateMinimal(
    name: 'Slate Minimal',
    gradient: [Color(0xFF18181B), Color(0xFF27272A)],
    accentColor: Color(0xFF06B6D4),
    badgeBackground: Color(0xFF3F3F46),
    cardBackground: Color(0xFF27272A),
    textColor: Colors.white,
    secondaryTextColor: Color(0xFFA1A1AA),
  );

  final String name;
  final List<Color> gradient;
  final Color accentColor;
  final Color badgeBackground;
  final Color cardBackground;
  final Color textColor;
  final Color secondaryTextColor;

  const RuleShareTheme({
    required this.name,
    required this.gradient,
    required this.accentColor,
    required this.badgeBackground,
    required this.cardBackground,
    required this.textColor,
    required this.secondaryTextColor,
  });
}

class RulebookShareDialog extends StatefulWidget {
  final RuleItem rule;

  const RulebookShareDialog({super.key, required this.rule});

  static Future<void> show(BuildContext context, RuleItem rule) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => RulebookShareDialog(rule: rule),
    );
  }

  @override
  State<RulebookShareDialog> createState() => _RulebookShareDialogState();
}

class _RulebookShareDialogState extends State<RulebookShareDialog> {
  final GlobalKey _repaintKey = GlobalKey();
  RuleShareAspectRatio _aspectRatio = RuleShareAspectRatio.feed;
  RuleShareTheme _selectedTheme = RuleShareTheme.pactNavy;
  bool _isExporting = false;

  String get _shareText {
    final rule = widget.rule;
    return '📌 ${rule.title}\n'
        '⚖️ Dasar Hukum: ${rule.legalBasis}\n'
        '⚠️ Sanksi / Hak: ${rule.penaltyOrRight}\n\n'
        '📖 Ringkasan:\n${rule.summary}\n\n'
        'Telusuri ratusan aturan & SOP di RuleBook: https://rulebook.faishal.id';
  }

  Future<Uint8List?> _capturePngBytes() async {
    try {
      final boundary = _repaintKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing image: $e');
      return null;
    }
  }

  Future<void> _shareImage() async {
    setState(() => _isExporting = true);
    try {
      final bytes = await _capturePngBytes();
      if (bytes == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal membuat gambar kartu aturan')),
          );
        }
        return;
      }

      final safeRuleName = widget.rule.id.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
      final filename = 'rulebook_${safeRuleName}_${_aspectRatio.name}.png';

      if (kIsWeb) {
        downloadFileWeb(bytes, filename, 'image/png');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gambar kartu aturan berhasil diunduh')),
          );
        }
      } else {
        // ignore: deprecated_member_use
        await Share.shareXFiles(
          [
            XFile.fromData(
              bytes,
              name: filename,
              mimeType: 'image/png',
            ),
          ],
          text: _shareText,
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: _shareText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Teks aturan berhasil disalin ke clipboard'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final rule = widget.rule;

    return Dialog(
      backgroundColor: c.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 720),
        child: Column(
          children: [
            // Modal header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
              child: Row(
                children: [
                  AppIcon(AppIconData.scale, size: 22, color: c.brand),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Bagikan Kartu Aturan',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: AppIcon(AppIconData.close, size: 20, color: c.textMuted),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Aspect ratio selector
                    SegmentedButton<RuleShareAspectRatio>(
                      segments: RuleShareAspectRatio.values
                          .map(
                            (r) => ButtonSegment(
                              value: r,
                              label: Text(
                                r.label,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      selected: {_aspectRatio},
                      onSelectionChanged: (selected) {
                        setState(() => _aspectRatio = selected.first);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Theme selector chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: RuleShareTheme.values.map((thm) {
                          final isSelected = _selectedTheme == thm;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: thm.gradient,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(thm.name),
                                ],
                              ),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() => _selectedTheme = thm);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Preview Card with RepaintBoundary
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.18),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: RepaintBoundary(
                          key: _repaintKey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: _aspectRatio.ratio,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: _selectedTheme.gradient,
                                  ),
                                ),
                                padding: const EdgeInsets.all(22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Bar: App Badge & Category
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedTheme.accentColor.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: _selectedTheme.accentColor.withValues(alpha: 0.5),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              AppIcon(
                                                AppIconData.scale,
                                                size: 13,
                                                color: _selectedTheme.accentColor,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                'RULEBOOK',
                                                style: TextStyle(
                                                  color: _selectedTheme.accentColor,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 10,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedTheme.badgeBackground,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            rule.category.localizedLabel(l10n).toUpperCase(),
                                            style: TextStyle(
                                              color: _selectedTheme.secondaryTextColor,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 14),

                                    // Legal Basis citation
                                    Row(
                                      children: [
                                        AppIcon(
                                          AppIconData.book,
                                          size: 12,
                                          color: _selectedTheme.secondaryTextColor,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            rule.legalBasis,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: _selectedTheme.secondaryTextColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    // Rule Title
                                    Text(
                                      rule.title,
                                      maxLines: _aspectRatio == RuleShareAspectRatio.feed ? 2 : 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: _selectedTheme.textColor,
                                        fontSize: _aspectRatio == RuleShareAspectRatio.feed ? 18 : 20,
                                        fontWeight: FontWeight.w800,
                                        height: 1.25,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Sanksi / Konsekuensi Box (Warning highlight)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _selectedTheme.accentColor.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: _selectedTheme.accentColor.withValues(alpha: 0.4),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: AppIcon(
                                              AppIconData.warning,
                                              size: 15,
                                              color: _selectedTheme.accentColor,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'KONSEKUENSI & SANKSI',
                                                  style: TextStyle(
                                                    color: _selectedTheme.accentColor,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  rule.penaltyOrRight,
                                                  maxLines: _aspectRatio == RuleShareAspectRatio.feed ? 2 : 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: _selectedTheme.textColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Ringkasan Aturan
                                    Text(
                                      rule.summary,
                                      maxLines: _aspectRatio == RuleShareAspectRatio.feed ? 3 : 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: _selectedTheme.secondaryTextColor,
                                        fontSize: 12,
                                        height: 1.45,
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Do / Don't Quick Tips
                                    if (rule.keyDos.isNotEmpty) ...[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '✓ ',
                                            style: TextStyle(
                                              color: Color(0xFF10B981),
                                              fontWeight: FontWeight.w900,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              rule.keyDos.first,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: _selectedTheme.textColor.withValues(alpha: 0.9),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                    if (rule.keyDonts.isNotEmpty) ...[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '✕ ',
                                            style: TextStyle(
                                              color: Color(0xFFEF4444),
                                              fontWeight: FontWeight.w900,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              rule.keyDonts.first,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: _selectedTheme.textColor.withValues(alpha: 0.9),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],

                                    const Spacer(),

                                    // Card Footer
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: _selectedTheme.secondaryTextColor.withValues(alpha: 0.2),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Diverifikasi: ${AppTimeZone.formatDate(AppTimeZone.nowUtc(), AppTimeZone.locationOrFallback(null))}',
                                            style: TextStyle(
                                              color: _selectedTheme.secondaryTextColor.withValues(alpha: 0.7),
                                              fontSize: 9,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'rulebook.faishal.id',
                                            style: TextStyle(
                                              color: _selectedTheme.accentColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  OutlinedButton.icon(
                    icon: AppIcon(AppIconData.copy, size: 16, color: c.textPrimary),
                    label: const Text('Salin Teks'),
                    onPressed: _copyText,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: c.brand,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: _isExporting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.share_rounded, size: 18),
                      label: Text(
                        _isExporting
                            ? 'Menyiapkan...'
                            : (kIsWeb ? 'Unduh Gambar' : 'Bagikan Kartu Aturan'),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onPressed: _isExporting ? null : _shareImage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
