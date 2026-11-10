import 'dart:ui' as ui;

import '../storage/local_storage_service.dart';

/// True only for store-screenshot captures
/// (`--dart-define=STORE_DEMO=true`). Real builds never seed.
const bool kStoreDemo = bool.fromEnvironment('STORE_DEMO');

/// Language forced for the seed + UI during store captures (`--dart-define=STORE_DEMO_LOCALE=en`).
const String kStoreDemoLocale = String.fromEnvironment('STORE_DEMO_LOCALE');

/// Rules the demo reader has already opened (feeds the reader badge).
const Set<String> kStoreDemoReadRuleIds = {
  'traffic-01',
  'traffic-02',
  'traffic-04',
  'labor-01',
  'labor-03',
  'privacy-01',
  'consumer-02',
};

/// Bookmarks, notes and in-progress audits for a lived-in first impression.
class StoreDemoSeeder {
  StoreDemoSeeder._();

  static const _seededKey = 'rulebook_store_demo_seeded_v1';

  static Future<void> seedIfNeeded(LocalStorageService storage) async {
    if (!kStoreDemo) return;
    final prefs = storage.prefs;
    if (prefs.getBool(_seededKey) ?? false) return;

    // Skip onboarding (splash reads this flag).
    await prefs.setBool('onboarding_completed', true);

    await storage.saveBookmarks({
      'traffic-01',
      'labor-03',
      'privacy-02',
      'safety-01',
      'consumer-02',
    });

    final lang =
        (kStoreDemoLocale.isNotEmpty ? kStoreDemoLocale : prefs.getString('locale')) ??
        ui.PlatformDispatcher.instance.locale.languageCode;
    final notes = _notes[lang] ?? _notes['en']!;
    await storage.saveNote('traffic-01', notes[0]);
    await storage.saveNote('labor-03', notes[1]);

    for (final entry in _checked.entries) {
      for (final itemId in entry.value) {
        await storage.toggleChecklistItem(entry.key, itemId);
      }
    }

    await prefs.setBool(_seededKey, true);
  }
}

const _checked = {
  'chk-kendaraan': ['v1', 'v2', 'v3', 'v4', 'v5'],
  'chk-pekerja': ['l1', 'l2', 'l3', 'l4'],
  'chk-k3': ['s1', 's2', 's4'],
  'chk-pdp': ['p1', 'p2', 'p4', 'p5'],
};

const _notes = {
  'id': [
    'Ingat: batas di tol dalam kota 60 km/jam, cek rambu sebelum masuk.',
    'Hitung ulang lembur bulan lalu dengan HRD, selisih sekitar 2 jam.',
  ],
  'en': [
    'Reminder: check the posted limit before entering the city toll road.',
    'Recheck last month overtime with HR, about 2 hours difference.',
  ],
  'ar': [
    'تذكير: تحقق من السرعة المحددة قبل دخول الطريق السريع داخل المدينة.',
    'أعد التحقق من ساعات العمل الإضافي للشهر الماضي مع الموارد البشرية، فرق ساعتين تقريبًا.',
  ],
  'ja': ['メモ：市内の有料道路に入る前に制限速度の標識を確認する。', '先月の残業時間を人事と再確認する。約2時間の差がある。'],
  'zh': ['提醒：进入市区收费公路前先确认限速标志。', '与人事重新核对上月加班时长，相差约2小时。'],
  'es': [
    'Recordatorio: revisar el límite indicado antes de entrar a la autopista urbana.',
    'Volver a revisar con RR. HH. las horas extra del mes pasado, unas 2 horas de diferencia.',
  ],
};
