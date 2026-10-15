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

class FleetAppConfig {
  final String appName;
  final String tagline;
  final Color primaryColor;
  final Color darkColor;
  final Color accentColor;
  final IconData fallbackIcon;
  final String skipLabel;
  final String nextLabel;
  final String getStartedLabel;
  final String defaultBadgeText;
  final String privacyHeadline;
  final String privacyDetail;
  final List<FleetSlideItem> slides;

  const FleetAppConfig({
    required this.appName,
    required this.tagline,
    required this.primaryColor,
    required this.darkColor,
    required this.accentColor,
    required this.fallbackIcon,
    this.skipLabel = 'Lewati',
    this.nextLabel = 'Lanjut',
    this.getStartedLabel = 'Mulai Sekarang',
    this.defaultBadgeText = '100% Offline & Cepat',
    this.privacyHeadline = 'Privasi & Offline Terjamin',
    this.privacyDetail =
        'Semua data tersimpan aman di perangkat Anda tanpa pelacak.',
    required this.slides,
  });

  static final FleetAppConfig current = FleetAppConfig(
    appName: 'RulebookGo',
    tagline: 'Pencatat skor board game, aturan main, timer giliran & riwayat.',
    primaryColor: const Color(0xFF1E3A5F),
    darkColor: const Color(0xFF0F172A),
    accentColor: const Color(0xFFF59E0B),
    fallbackIcon: Icons.gavel_rounded,
    slides: const [
    FleetSlideItem(
      headline: 'Buku saku aturan',
      subtext: 'Lalu lintas, SOP, regulasi',
      icon: Icons.menu_book_rounded,
      badgeText: '100% Offline & Privat',
    ),
    FleetSlideItem(
      headline: 'Kalkulator',
      subtext: 'Hitung cepat sesuai aturan',
      icon: Icons.search_rounded,
      badgeText: 'Ringan & Responsif',
    ),
    FleetSlideItem(
      headline: 'Checklist',
      subtext: 'Patuhi langkah demi langkah',
      icon: Icons.bookmark_rounded,
      badgeText: 'Tanpa Iklan & Tanpa Akun',
    ),
    FleetSlideItem(
      headline: 'Offline',
      subtext: 'Tanpa internet',
      icon: Icons.offline_pin_rounded,
      badgeText: 'Data Tersimpan di Perangkat',
    ),
    ],
  );
}
