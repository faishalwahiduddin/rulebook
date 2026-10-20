// §TRACE regressions: app start through the splash and opening a rule detail
// must not throw (both used to modify/read inherited state during build).
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/router/app_router.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/core/storage/rules_database.dart';
import 'package:rulebook/core/utils/app_timezone.dart';
import 'package:rulebook/features/catalog/widgets/read_badge.dart';
import 'package:rulebook/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _boot(WidgetTester tester) async {
  tester.view.physicalSize = const Size(900, 1900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues({'locale': 'id', 'onboarding_completed': true});
  final storage = await LocalStorageService.init();
  await tester.pumpWidget(ProviderScope(
    overrides: [localStorageServiceProvider.overrideWithValue(storage)],
    child: const RuleBookApp(),
  ));
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(tester.element(find.byType(RuleBookApp)));
}

void main() {
  setUpAll(AppTimeZone.initAppTimeZones);

  testWidgets('FLOW-RUL-01-T05 aplikasi dibuka lewat splash sampai katalog tanpa exception', (tester) async {
    await _boot(tester);
    expect(tester.takeException(), isNull);
    expect(find.text('Semua'), findsWidgets);
  });

  testWidgets('FLOW-RUL-01-T06 membuka detail aturan menandai dibaca tanpa mengubah provider saat build', (tester) async {
    final c = await _boot(tester);
    final id = RulesDatabase.rules.first.id;
    appRouter.go('/rule/$id');
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(c.read(readRuleIdsProvider), contains(id));
  });
}
