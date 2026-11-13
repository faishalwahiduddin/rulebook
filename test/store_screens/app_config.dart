// Per-app hook for the store screen harness (store_screens_test.dart).
// install-harness.sh never overwrites this file. Checklist:
// tools/gen-store-scaffold/flutter_harness/README.md.
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rulebook/core/demo/store_demo.dart';
import 'package:rulebook/core/providers/app_providers.dart';
import 'package:rulebook/core/router/app_router.dart';
import 'package:rulebook/core/storage/local_storage_service.dart';
import 'package:rulebook/core/utils/app_timezone.dart';
import 'package:rulebook/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Splash hands off after 750 ms.
const kStoreSplash = Duration(seconds: 1);

Future<void> storeSetUpAll() async {
  AppTimeZone.initAppTimeZones();
  AppTimeZone.cachedDeviceZone = 'Asia/Jakarta';
  PackageInfo.setMockInitialValues(
    appName: 'RuleBook',
    packageName: 'id.faishal.rulebook',
    version: '1.0.0',
    buildNumber: '1',
    buildSignature: '',
  );
}

/// Same state main() produces under STORE_DEMO.
Future<Widget> storeBuildApp(String lang) async {
  SharedPreferences.setMockInitialValues({
    'locale': lang,
    'onboarding_completed': true,
  });
  final storage = await LocalStorageService.init();
  await StoreDemoSeeder.seedIfNeeded(storage);
  return ProviderScope(
    overrides: [localStorageServiceProvider.overrideWithValue(storage)],
    child: const RuleBookApp(),
  );
}

Future<void> storeGo(WidgetTester tester, String route) async =>
    appRouter.go(route);

Future<void> storeAfterNavigate(
    WidgetTester tester, int slide, String action) async {
  if (action.isNotEmpty) {
    throw UnimplementedError('rulebook has no slide actions (got "$action")');
  }
}
