import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/theme/app_colors.dart';
import 'package:rulebook/core/ui/app_icon.dart';

import '../support/real_fonts.dart';

Set<String> _iconNamesUsedInLib() {
  final names = <String>{};
  final literal = RegExp(r"""AppIcon\(\s*'([a-z0-9_]+)'""");
  final ternary = RegExp(r"""AppIcon\(\s*[^,]+?\s*\?\s*'([a-z0-9_]+)'\s*:\s*'([a-z0-9_]+)'""");
  final svgArg = RegExp(r"""(iconName|activeIconName):\s*'([a-z0-9_]+)'""");

  for (final f in Directory('lib').listSync(recursive: true)) {
    if (f is! File || !f.path.endsWith('.dart')) continue;
    final src = f.readAsStringSync();
    for (final m in literal.allMatches(src)) {
      names.add(m.group(1)!);
    }
    for (final m in ternary.allMatches(src)) {
      names
        ..add(m.group(1)!)
        ..add(m.group(2)!);
    }
    for (final m in svgArg.allMatches(src)) {
      names.add(m.group(2)!);
    }
  }
  return names;
}

List<String> _allIconFiles() {
  final files = Directory('assets/icons')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.svg'))
      .map((f) => f.uri.pathSegments.last.replaceAll('.svg', ''))
      .toList()
    ..sort();
  return files;
}

void main() {
  group('icon set', () {
    test('every icon used in lib/ exists in assets/icons', () {
      final used = _iconNamesUsedInLib();
      expect(used, isNotEmpty);
      for (final name in used) {
        expect(File('assets/icons/$name.svg').existsSync(), isTrue,
            reason: 'missing assets/icons/$name.svg');
      }
      // Nav uses a pair for every tab.
      for (final tab in ['rules', 'calculator', 'sop', 'compliance', 'bookmarks']) {
        expect(used, containsAll(['nav_$tab', 'nav_${tab}_active']));
      }
    });

    test('every svg follows the spec and parses', () async {
      final names = _allIconFiles();
      expect(names, isNotEmpty);
      for (final name in names) {
        final src = File('assets/icons/$name.svg').readAsStringSync();
        expect(RegExp(r'^[a-z0-9_]+$').hasMatch(name), isTrue, reason: name);
        expect(src, contains('viewBox="0 0 24 24"'), reason: name);
        final root = RegExp(r'<svg[^>]*>').firstMatch(src)!.group(0)!;
        expect(RegExp(r'(?<!-)width=').hasMatch(root), isFalse, reason: name);
        expect(RegExp(r'(?<!-)height=').hasMatch(root), isFalse, reason: name);
        expect(root, isNot(contains('transform')), reason: name);
        for (final banned in ['<style', '<text', '<image']) {
          expect(src, isNot(contains(banned)), reason: '$name has $banned');
        }
        final info = await vg.loadPicture(SvgStringLoader(src), null);
        expect(info.size, const Size(24, 24), reason: name);
        info.picture.dispose();
      }
    });
  });

  testWidgets('icon preview sheet (light + dark)', (tester) async {
    await loadRealRoboto();
    final names = _allIconFiles();
    const cellW = 170.0;
    const perRow = 6;
    final rows = (names.length / perRow).ceil();
    final panelH = rows * 100.0 + 24;
    tester.view.physicalSize = Size(cellW * perRow + 24, panelH * 2);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    Widget panel(Color bg, Color fg) => Container(
          color: bg,
          height: panelH,
          padding: const EdgeInsets.all(12),
          child: Wrap(
            children: [
              for (final n in names)
                SizedBox(
                  width: cellW,
                  height: 96,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcon(n, size: 28, color: fg),
                      const SizedBox(height: 8),
                      Text(
                        n,
                        style: TextStyle(
                          color: fg,
                          fontSize: 10,
                          fontFamily: 'Roboto',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                panel(AppColors.light.background, AppColors.light.brand),
                panel(AppColors.dark.background, AppColors.dark.brand),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/icon_sheet.png'),
    );
  });
}
