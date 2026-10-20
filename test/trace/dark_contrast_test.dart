// §TRACE dark-mode guard: every screen's text keeps contrast >= 4.5 on its surface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/router/app_router.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/core/storage/rules_database.dart';
import 'package:rulebook/core/utils/app_timezone.dart';
import 'package:rulebook/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contrast_scan.dart';

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);

  testWidgets('FLOW-SET-01-T05 tema gelap: semua teks di 9 layar utama terbaca (kontras >= 4.5)', (tester) async {
    tester.view.physicalSize = const Size(900, 1900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({'locale': 'id', 'onboarding_completed': true, 'theme_mode': 'dark'});
    final storage = await LocalStorageService.init();
    await tester.pumpWidget(ProviderScope(
      overrides: [localStorageServiceProvider.overrideWithValue(storage)],
      child: const RuleBookApp(),
    ));
    await tester.pumpAndSettle();
    final routes = [
      '/', '/rule/${RulesDatabase.rules.first.id}', '/calculator', '/sop',
      '/sop/${RulesDatabase.sopGuides.first.id}', '/checklist',
      '/checklist/${RulesDatabase.checklists.first.id}', '/bookmarks', '/settings',
    ];
    final issues = <String>[];
    for (final r in routes) {
      appRouter.go(r);
      await tester.pumpAndSettle();
      issues.addAll(scanContrast(tester).map((i) => '$r $i'));
    }
    expect(issues, isEmpty);
  });
}
