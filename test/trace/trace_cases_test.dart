// §TRACE case evidence — one test per TC in docs/trace/flows.yaml (title prefix = TC id).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rulebook/core/models/rule_category.dart';
import 'package:rulebook/core/models/severance_calculator_models.dart';
import 'package:rulebook/core/models/sop_guide.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/core/storage/rules_database.dart';
import 'package:rulebook/core/theme/app_theme.dart';
import 'package:rulebook/core/utils/app_timezone.dart';
import 'package:rulebook/core/utils/rule_l10n_extension.dart';
import 'package:rulebook/core/utils/validators.dart';
import 'package:rulebook/features/catalog/widgets/rulebook_share_dialog.dart';
import 'package:rulebook/l10n/app_localizations.dart';
import 'package:rulebook/l10n/fallback_framework_delegates.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LocalStorageService> _storage([Map<String, Object> initial = const {}]) async {
  SharedPreferences.setMockInitialValues(initial);
  return LocalStorageService(await SharedPreferences.getInstance());
}

Future<ProviderContainer> _container([Map<String, Object> initial = const {}]) async {
  final storage = await _storage(initial);
  final c = ProviderContainer(overrides: [localStorageServiceProvider.overrideWithValue(storage)]);
  addTearDown(c.dispose);
  return c;
}

Future<void> _pumpShare(WidgetTester tester, String ruleId) async {
  final rule = RulesDatabase.findRule(ruleId)!;
  await tester.binding.setSurfaceSize(const Size(900, 1800));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.lightTheme,
    locale: const Locale('id'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      FallbackMaterialLocalizationsDelegate(),
      FallbackWidgetsLocalizationsDelegate(),
      FallbackCupertinoLocalizationsDelegate(),
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SingleChildScrollView(child: RulebookShareDialog(rule: rule))),
  ));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);
  final firstRule = RulesDatabase.rules.first;

  group('FLOW-RUL-01 katalog & butir aturan', () {
    test('FLOW-RUL-01-T01 kategori Lalu Lintas hanya memuat butir lalu lintas yang lengkap', () async {
      final c = await _container();
      c.read(selectedCategoryProvider.notifier).selectCategory(RuleCategory.traffic);
      final rules = c.read(filteredRulesProvider);
      expect(rules, isNotEmpty);
      for (final r in rules) {
        expect(r.category, RuleCategory.traffic);
        expect(r.title.trim(), isNotEmpty);
        expect(r.summary.trim(), isNotEmpty);
        expect(r.legalBasis.trim(), isNotEmpty);
        expect(r.penaltyOrRight.trim(), isNotEmpty);
      }
    });

    test('FLOW-RUL-01-T02 deep link ke id aturan yang tidak ada ditolak (layar tidak ditemukan)', () {
      expect(RulesDatabase.findRule('tidak-ada-123'), isNull);
    });

    test('FLOW-RUL-01-T03 kategori Semua menampilkan seluruh butir dan id unik', () async {
      final c = await _container();
      final all = c.read(filteredRulesProvider);
      expect(all.length, RulesDatabase.rules.length);
      expect(all.map((r) => r.id).toSet().length, all.length);
      for (final cat in RuleCategory.values.where((x) => x != RuleCategory.all && x != RuleCategory.ethics)) {
        expect(all.where((r) => r.category == cat), isNotEmpty, reason: '$cat kosong');
      }
    });

    test('FLOW-RUL-01-T04 id null / kosong pada tiga jenis konten tidak membuat crash', () {
      expect(RulesDatabase.findRule(null), isNull);
      expect(RulesDatabase.findSop(''), isNull);
      expect(RulesDatabase.findChecklist(null), isNull);
      expect(RulesDatabase.findRule(firstRule.id), same(firstRule));
    });
  });

  group('FLOW-RUL-02 pencarian instan', () {
    test('FLOW-RUL-02-T01 kata kunci "helm" menemukan aturan helm SNI', () async {
      final c = await _container();
      c.read(searchQueryProvider.notifier).setQuery('helm');
      final hits = c.read(filteredRulesProvider);
      expect(hits, isNotEmpty);
      expect(hits.any((r) => r.title.contains('Helm')), isTrue);
    });

    test('FLOW-RUL-02-T02 kueri lebih dari 60 karakter ditolak dan kueri lama dipertahankan', () async {
      final c = await _container();
      c.read(searchQueryProvider.notifier).setQuery('helm');
      c.read(searchQueryProvider.notifier).setQuery('x' * 61);
      expect(c.read(searchQueryProvider), 'helm');
      expect(AppValidators.validateSearchQuery('x' * 61), 'errorSearchQueryTooLong');
    });

    test('FLOW-RUL-02-T03 kueri hanya spasi dianggap kosong dan menampilkan semua aturan', () async {
      final c = await _container();
      c.read(searchQueryProvider.notifier).setQuery('   ');
      expect(c.read(filteredRulesProvider).length, RulesDatabase.rules.length);
      expect(AppValidators.validateSearchQuery('x' * 60), isNull);
    });

    test('FLOW-RUL-02-T04 kueri yang cocok di kategori lain menghasilkan 0 dan bisa diatur ulang', () async {
      final c = await _container();
      c.read(selectedCategoryProvider.notifier).selectCategory(RuleCategory.labor);
      c.read(searchQueryProvider.notifier).setQuery('helm');
      expect(c.read(filteredRulesProvider), isEmpty);
      c.read(searchQueryProvider.notifier).clear();
      expect(c.read(filteredRulesProvider), isNotEmpty);
    });

    test('FLOW-RUL-02-T05 nomor pasal mencocokkan dasar hukum, tanpa membedakan huruf besar', () async {
      final c = await _container();
      c.read(searchQueryProvider.notifier).setQuery('PASAL 291');
      final hits = c.read(filteredRulesProvider);
      expect(hits, isNotEmpty);
      expect(hits.every((r) =>
          '${r.title} ${r.summary} ${r.legalBasis} ${r.keywords.join(' ')}'.toLowerCase().contains('pasal 291')), isTrue);
    });
  });

  group('FLOW-RUL-03 bagikan butir aturan', () {
    testWidgets('FLOW-RUL-03-T01 pratinjau kartu memuat judul dan dasar hukum butir', (tester) async {
      await _pumpShare(tester, firstRule.id);
      final l10n = AppLocalizations.of(tester.element(find.byType(RulebookShareDialog)))!;
      expect(find.textContaining(firstRule.localizedTitle(l10n)), findsWidgets);
      expect(find.textContaining(firstRule.legalBasis), findsWidgets);
    });

    test('FLOW-RUL-03-T02 butir yang tidak ada tidak dapat dibuka untuk dibagikan', () {
      expect(RulesDatabase.findRule('../etc/passwd'), isNull);
    });

    test('FLOW-RUL-03-T03 semua butir di 8 bahasa punya judul dan sanksi tidak kosong untuk kartu', () async {
      for (final code in ['id', 'en', 'ar', 'jv', 'su', 'zh', 'ja', 'es']) {
        final l10n = await AppLocalizations.delegate.load(Locale(code));
        for (final r in RulesDatabase.rules) {
          expect(r.localizedTitle(l10n).trim(), isNotEmpty, reason: '${r.id}/$code');
          expect(r.localizedPenalty(l10n).trim(), isNotEmpty, reason: '${r.id}/$code');
        }
      }
    });

    testWidgets('FLOW-RUL-03-T04 Salin Teks menaruh judul, dasar hukum, dan tautan app di clipboard', (tester) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.setData') copied = (call.arguments as Map)['text'] as String?;
        return null;
      });
      addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
      await _pumpShare(tester, firstRule.id);
      await tester.tap(find.text('Salin Teks'));
      await tester.pump();
      expect(copied, isNotNull);
      expect(copied, contains(firstRule.legalBasis));
      expect(copied, contains('https://rulebook.faishal.id'));
      expect(find.text('Teks aturan berhasil disalin'), findsOneWidget);
    });
  });

  group('FLOW-BKM-01 simpan aturan & catatan', () {
    test('FLOW-BKM-01-T01 bookmark tersimpan ke perangkat dan terbaca ulang', () async {
      final c = await _container();
      await c.read(bookmarksProvider.notifier).toggleBookmark(firstRule.id);
      expect(c.read(bookmarksProvider), {firstRule.id});
      expect(c.read(localStorageServiceProvider).isBookmarked(firstRule.id), isTrue);
      await c.read(ruleNotesProvider.notifier).saveNote(firstRule.id, '  Perpanjang SIM  ');
      expect(c.read(ruleNotesProvider)[firstRule.id], 'Perpanjang SIM');
    });

    test('FLOW-BKM-01-T02 id aturan kosong dan catatan kosong ditolak', () async {
      final s = await _storage();
      expect(() => s.toggleBookmark('  '), throwsArgumentError);
      expect(() => s.saveNote(firstRule.id, '   '), throwsArgumentError);
      expect(s.getBookmarks(), isEmpty);
    });

    test('FLOW-BKM-01-T03 catatan tepat 500 karakter diterima, 501 ditolak', () async {
      final s = await _storage();
      expect(await s.saveNote(firstRule.id, 'a' * 500), isTrue);
      expect(() => s.saveNote(firstRule.id, 'a' * 501), throwsArgumentError);
      expect(s.getNote(firstRule.id)!.length, 500);
    });

    test('FLOW-BKM-01-T04 bookmark ganda tidak dobel dan ketuk dua kali melepas simpanan', () async {
      final c = await _container({'rulebook_bookmarked_ids': [firstRule.id, firstRule.id]});
      expect(c.read(bookmarksProvider).length, 1);
      await c.read(bookmarksProvider.notifier).toggleBookmark(firstRule.id);
      expect(c.read(bookmarksProvider), isEmpty);
      await c.read(bookmarksProvider.notifier).toggleBookmark(firstRule.id);
      await c.read(bookmarksProvider.notifier).toggleBookmark(firstRule.id);
      expect(c.read(bookmarksProvider), isEmpty);
    });
  });

  group('FLOW-CAL-01 kalkulator', () {
    test('FLOW-CAL-01-T01 pesangon efisiensi 3 tahun 6 bulan sesuai PP 35/2021', () {
      final reason = SeveranceCalculatorEngine.reasons.firstWhere((r) => r.id == 'efisiensi_cegah',
          orElse: () => SeveranceCalculatorEngine.reasons.first);
      final res = SeveranceCalculatorEngine.calculate(
          monthlyWage: 6500000, tenureYears: 3, tenureMonths: 6, reason: reason);
      expect(res.basePesangonMonths, 4);
      expect(res.baseUpmkMonths, 2);
      expect(res.totalSeverancePay, 4 * 6500000 * reason.pesangonFactor + 2 * 6500000 * reason.upmkFactor);
      expect(AppValidators.validateSalary('6500000'), isNull);
      expect(AppValidators.validateOvertimeHours('4'), isNull);
    });

    test('FLOW-CAL-01-T02 gaji di bawah Rp100.000, jam lembur 0, dan masa kerja negatif ditolak', () {
      expect(AppValidators.validateSalary('99999'), 'errorSalaryMin');
      expect(AppValidators.validateSalary(''), 'errorSalaryRequired');
      expect(AppValidators.validateOvertimeHours('0'), 'errorOvertimeHoursMin');
      expect(AppValidators.validateOvertimeHours('abc'), 'errorOvertimeHoursInvalid');
      expect(AppValidators.validateTenureYears('-1'), 'errorTenureYearsMin');
    });

    test('FLOW-CAL-01-T03 batas masa kerja: 11 bulan = 1 bulan, 8 tahun = 9 bulan, UPMK 24 tahun = 10', () {
      expect(SeveranceCalculatorEngine.getBasePesangonMonths(0, 11), 1);
      expect(SeveranceCalculatorEngine.getBasePesangonMonths(1, 0), 2);
      expect(SeveranceCalculatorEngine.getBasePesangonMonths(8, 0), 9);
      expect(SeveranceCalculatorEngine.getBaseUpmkMonths(2), 0);
      expect(SeveranceCalculatorEngine.getBaseUpmkMonths(24), 10);
      expect(AppValidators.validateOvertimeHours('100'), isNull);
      expect(AppValidators.validateOvertimeHours('100.5'), 'errorOvertimeHoursMax');
      expect(AppValidators.validateTenureMonths('11'), isNull);
      expect(AppValidators.validateTenureMonths('12'), 'errorTenureMonthsRange');
    });

    test('FLOW-CAL-01-T04 gaji berformat "Rp 5.000.000" dibersihkan; di atas Rp1 miliar ditolak', () {
      expect(AppValidators.validateSalary('Rp 5.000.000'), isNull);
      expect(AppValidators.validateSalary('1.000.000.001'), 'errorSalaryMax');
      expect(AppValidators.validateSalary('Rp ---'), 'errorSalaryInvalid');
      expect(AppValidators.validateTenureMonths(''), isNull);
    });
  });

  group('FLOW-SOP-01 SOP darurat', () {
    test('FLOW-SOP-01-T01 setiap SOP punya langkah bernomor, dasar hukum, dan kontak darurat', () {
      expect(RulesDatabase.sopGuides, isNotEmpty);
      for (final s in RulesDatabase.sopGuides) {
        expect(s.steps, isNotEmpty, reason: s.id);
        expect(s.legalBasis.trim(), isNotEmpty, reason: s.id);
        expect(s.emergencyContacts, isNotEmpty, reason: s.id);
        expect(RulesDatabase.findSop(s.id), same(s));
      }
    });

    test('FLOW-SOP-01-T02 tautan SOP yang tidak ada ditolak', () {
      expect(RulesDatabase.findSop('sop-hoaks'), isNull);
    });

    test('FLOW-SOP-01-T03 kategori tanpa SOP dan kueri tanpa hasil menghasilkan daftar kosong', () async {
      final c = await _container();
      c.read(selectedCategoryProvider.notifier).selectCategory(RuleCategory.ethics);
      expect(c.read(filteredSopGuidesProvider).where((s) => s.category != RuleCategory.ethics), isEmpty);
      c.read(selectedCategoryProvider.notifier).selectCategory(RuleCategory.all);
      c.read(searchQueryProvider.notifier).setQuery('zzzz-tidak-ada');
      expect(c.read(filteredSopGuidesProvider), isEmpty);
    });

    test('FLOW-SOP-01-T04 SOP dengan kategori tak dikenal di data tersimpan jatuh ke kategori default', () {
      final json = RulesDatabase.sopGuides.first.toJson()..['category'] = 'kategori-hilang';
      final restored = SopGuide.fromJson(json);
      expect(restored.category, RuleCategory.traffic);
      expect(restored.steps.length, RulesDatabase.sopGuides.first.steps.length);
    });
  });

  group('FLOW-AUD-01 audit kepatuhan', () {
    final chk = RulesDatabase.checklists.first;

    test('FLOW-AUD-01-T01 centang butir audit tersimpan dan terbaca ulang', () async {
      final c = await _container();
      await c.read(checklistStateProvider.notifier).toggleItem(chk.id, chk.items.first.id);
      expect(c.read(checklistStateProvider)[chk.id], {chk.items.first.id});
      expect(c.read(localStorageServiceProvider).getCheckedItems(chk.id), {chk.items.first.id});
    });

    test('FLOW-AUD-01-T02 tautan modul audit yang tidak ada ditolak', () {
      expect(RulesDatabase.findChecklist('audit-palsu'), isNull);
    });

    test('FLOW-AUD-01-T03 semua butir tercentang = 100%, reset mengosongkan', () async {
      final c = await _container();
      for (final i in chk.items) {
        await c.read(checklistStateProvider.notifier).toggleItem(chk.id, i.id);
      }
      expect(c.read(checklistStateProvider)[chk.id]!.length, chk.items.length);
      await c.read(checklistStateProvider.notifier).resetAll(chk.id);
      expect(c.read(checklistStateProvider)[chk.id], isEmpty);
    });

    test('FLOW-AUD-01-T04 ketuk dua kali melepas centang; modul lain tidak terpengaruh', () async {
      final other = RulesDatabase.checklists[1];
      final c = await _container();
      await c.read(checklistStateProvider.notifier).toggleItem(other.id, other.items.first.id);
      await c.read(checklistStateProvider.notifier).toggleItem(chk.id, chk.items.first.id);
      await c.read(checklistStateProvider.notifier).toggleItem(chk.id, chk.items.first.id);
      expect(c.read(checklistStateProvider)[chk.id], isEmpty);
      expect(c.read(checklistStateProvider)[other.id], {other.items.first.id});
    });
  });

  group('FLOW-SET-01 pengaturan & cadangan', () {
    setUp(() => PackageInfo.setMockInitialValues(
        appName: 'RuleBook', packageName: 'id.faishal.rulebook', version: '1.0.7', buildNumber: '8', buildSignature: ''));

    test('FLOW-SET-01-T01 ekspor lalu pulihkan cadangan .rlb mengembalikan bookmark dan catatan', () async {
      final s = await _storage();
      await s.saveBookmarks({firstRule.id});
      await s.saveNote(firstRule.id, 'Catatan');
      final backup = await s.exportBackupJson();
      await s.clearAllData();
      expect(await s.restoreFromBackup(backup), isTrue);
      expect(s.getBookmarks(), {firstRule.id});
      expect(s.getNote(firstRule.id), 'Catatan');
    });

    test('FLOW-SET-01-T02 berkas cadangan JSON mentah atau rusak ditolak tanpa mengubah data', () async {
      final s = await _storage();
      await s.saveBookmarks({firstRule.id});
      expect(await s.restoreFromBackup('{"bookmarks":["x"]}'), isFalse);
      expect(await s.restoreFromBackup('FSBK1#RULEBOOK#bukan-base64'), isFalse);
      expect(s.getBookmarks(), {firstRule.id});
    });

    test('FLOW-SET-01-T03 hapus semua data menghapus simpanan tetapi mempertahankan bahasa dan tema', () async {
      final s = await _storage({'locale': 'id', 'theme_mode': 'dark'});
      await s.saveBookmarks({firstRule.id});
      await s.saveNote(firstRule.id, 'x');
      await s.toggleChecklistItem('chk', 'a');
      await s.clearAllData();
      expect(s.getBookmarks(), isEmpty);
      expect(s.getAllNotes(), isEmpty);
      expect(s.getCheckedItems('chk'), isEmpty);
      expect(s.prefs.getString('locale'), 'id');
      expect(s.getThemeMode(), ThemeMode.dark);
    });

    test('FLOW-SET-01-T04 nilai tema korup di penyimpanan jatuh ke mode sistem', () async {
      final s = await _storage({'theme_mode': 'ungu'});
      expect(s.getThemeMode(), ThemeMode.system);
      await s.saveThemeMode(ThemeMode.light);
      expect(s.getThemeMode(), ThemeMode.light);
    });
  });
}
