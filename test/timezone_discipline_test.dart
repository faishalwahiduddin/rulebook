import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guard TZ-2 (platform contract): stored instants are UTC, everything a
/// human reads or types is shown in the SELECTED zone (Settings manual zone,
/// or the device zone while on Auto), through
/// `lib/core/utils/app_timezone.dart`. Breaking it fails silently on a dev
/// machine: `DateTime.now()`, `.toLocal()` and `DateFormat(...)` all use the
/// DEVICE zone, which is Asia/Jakarta on the laptop and something else on a
/// user's phone — off by hours, and by a whole day between 00:00 and the
/// zone offset after midnight.
///
/// A WIB-hardcoded helper (`toWib()`/`formatWib*()`, `+7h` offset) must never
/// appear: a phone in New York must show New York times, not Jakarta's.
/// Display goes through `AppTimeZone` in the selected zone.
///
/// Dart's own parsers (`DateTime.parse`/`tryParse`) are banned outside the
/// helper too: a string without `Z`/offset is read as DEVICE-local. Use
/// `AppTimeZone.parseUtc()`, which also rejects impossible dates instead of
/// rolling them.
///
/// Stepping days with `.add`/`.subtract(Duration(days: n))` is banned too:
/// on a zone wall clock it skips or repeats a calendar day across a DST
/// switch. Use `AppTimeZone.dayRangeUtc`.
///
/// Instant reads use `package:clock` (`clock.now()`), not `DateTime.now()`,
/// so tests can freeze time — but the value is still only an instant. Any
/// line below that keeps a `DateTime.now()` is allowlisted PER LINE with its
/// reason, never per file, so a new offender in the same file is caught.
///
/// Line scan, not an AST: a COMMENT quoting a forbidden call is caught too.
/// That is deliberate — describe the anti-pattern in words, or allowlist it.
/// Known gap: reading `.day`/`.hour` off a device-zone `DateTime` is not
/// detectable by a line scan; that is what code review and the TZ=UTC run of
/// the test suite are for.
class _ForbiddenPattern {
  final RegExp pattern;
  final String why;
  const _ForbiddenPattern(this.pattern, this.why);
}

/// Excluded ENTIRELY: the helper itself, the only file allowed to resolve
/// zones, format in a zone, or parse raw values into UTC.
const _allowedFiles = {'lib/core/utils/app_timezone.dart'};

final _forbidden = <_ForbiddenPattern>[
  _ForbiddenPattern(
    RegExp(r'\.toLocal\s*\('),
    'uses the DEVICE zone -- display through AppTimeZone.format*() in the '
        'selected zone from lib/core/utils/app_timezone.dart',
  ),
  _ForbiddenPattern(
    // Also the named constructors: DateFormat.yMMMd(...), DateFormat.Hm(...).
    RegExp(r'\bDateFormat\s*(?:\(|\.\w+\s*\()'),
    'DateFormat from package:intl renders in the device zone -- use '
        'AppTimeZone.format*()',
  ),
  _ForbiddenPattern(
    RegExp(r'DateTime\.now\s*\(\s*\)'),
    'DateTime.now() cannot be frozen by package:clock -- use '
        'AppTimeZone.nowUtc()/clock.now() for instants, or allowlist it '
        'with a reason',
  ),
  _ForbiddenPattern(
    RegExp(r'DateTime\.(?:try)?[Pp]arse\s*\('),
    "Dart's parser reads a string without Z/offset as DEVICE-local and rolls "
        'impossible dates over -- use AppTimeZone.parseUtc()',
  ),
  _ForbiddenPattern(
    RegExp(r'\.(?:add|subtract)\s*\(\s*(?:const\s+)?Duration\s*\(\s*days\s*:'),
    'a 24h step skips or repeats a calendar day across DST on a zone wall '
        'clock -- use AppTimeZone.dayRangeUtc',
  ),
  _ForbiddenPattern(
    RegExp(
      r'\b(?:toWib|nowWib|todayWib|wibDateKey|wibDayRangeUtc|wibRangeUtc|'
      r'wibMonthRangeUtc|wibInputToUtc|utcToWibInput|formatWib\w*|kWib\w*|'
      r'wib_time)\b',
    ),
    'the WIB-hardcoded helper is deleted -- display through AppTimeZone in '
        'the selected zone, store UTC',
  ),
];

class _AllowlistEntry {
  final String file;
  final RegExp match;
  final String why;
  const _AllowlistEntry(this.file, this.match, this.why);
}

/// The exact reason for every remaining exception. Empty today: the only
/// timestamp write (`exported_at` in `local_storage_service.dart`) goes
/// through `AppTimeZone.encodeForPrefs(AppTimeZone.nowUtc())`, so nothing
/// needs an exception. Keep the mechanism — a future offender must justify
/// itself per line here.
const _instantReason =
    'pure instant handling, zone-independent (instants '
    'are compared/stored as UTC, only display is zoned)';

final _allowlist = <_AllowlistEntry>[
];

bool _isAllowlisted(String relPath, String line) =>
    _allowlist.any((a) => a.file == relPath && a.match.hasMatch(line));

/// Every `.dart` file under [dir], as a path relative to [root].
List<String> _dartFilesUnder(Directory dir, String root) {
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.path.substring(root.length + 1).replaceAll(r'\', '/'))
      .toList()
    ..sort();
}

List<String> _findOffenders(String root, List<String> relPaths) {
  final offenders = <String>[];
  for (final rel in relPaths) {
    if (_allowedFiles.contains(rel)) continue;
    final lines = File('$root/$rel').readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (_isAllowlisted(rel, line)) continue;
      for (final f in _forbidden) {
        if (f.pattern.hasMatch(line)) {
          offenders.add('$rel:${i + 1} -- ${f.why}\n    ${line.trim()}');
        }
      }
    }
  }
  return offenders;
}

void main() {
  final root = Directory.current.path;
  final libDir = Directory('$root/lib');

  test('no lib/ file reads or shows time outside app_timezone.dart', () {
    final files = _dartFilesUnder(libDir, root);
    // Sanity: if this is ~0 the scan targets the wrong directory and the
    // rest passes vacuously.
    expect(files.length, greaterThan(30));
    expect(files, contains('lib/core/utils/app_timezone.dart'));
    expect(files, isNot(contains('lib/core/utils/wib_time.dart')));

    final offenders = _findOffenders(root, files);
    expect(
      offenders,
      isEmpty,
      reason: 'Unsafe time handling found:\n\n${offenders.join('\n')}\n',
    );
  });

  test('every allowlist entry points at a line that really exists', () {
    for (final entry in _allowlist) {
      final path = '$root/${entry.file}';
      expect(File(path).existsSync(), isTrue, reason: '${entry.file} missing');
      final lines = File(path).readAsLinesSync();
      final hits = lines.where((l) => entry.match.hasMatch(l)).length;
      expect(
        hits,
        greaterThan(0),
        reason: 'allowlist ${entry.file} (${entry.match.pattern}) matches no '
            'line -- the site moved or was removed; drop the dead entry',
      );
      // Also must still be a forbidden-pattern line, otherwise the entry is
      // dead weight that could later mask a real offender.
      final stillForbidden = lines
          .where((l) => entry.match.hasMatch(l))
          .any((l) => _forbidden.any((f) => f.pattern.hasMatch(l)));
      expect(stillForbidden, isTrue,
          reason: 'allowlist ${entry.file} (${entry.match.pattern}) no longer '
              'matches a forbidden pattern -- drop it');
      expect(entry.why.length, greaterThan(15), reason: 'reason too short');
      expect(_instantReason.length, greaterThan(15));
    }
  });

  test('FORBIDDEN patterns really catch offenders (negative control)', () {
    const regressions = [
      'final createdAt = DateTime.now();',
      'final jam = raw.toLocal();',
      "DateFormat('dd/MM/yyyy').format(instant);",
      'DateFormat.yMMMd(locale).format(instant);',
      "DateFormat.Hm().format(instant);",
      "final d = DateTime.parse(json['created_at']);",
      'final d = DateTime.tryParse(raw.toString());',
      'checkDate = checkDate.subtract(const Duration(days: 1));',
      'final d = weekStart.add(Duration(days: i));',
      'final w = toWib(instant);',
      "final s = formatWibTime(instant);",
      "import 'package:rulebook/core/utils/wib_time.dart';",
      'final r = wibDayRangeUtc(date);',
      'return wibInputToUtc(input);',
    ];
    for (final line in regressions) {
      final caught = _forbidden.any((f) => f.pattern.hasMatch(line));
      expect(caught, isTrue, reason: 'not caught by any pattern: $line');
    }
  });

  test('safe lookalikes are not flagged', () {
    const safe = [
      'final d = DateTime(2026, 1, 1);',
      'final d = DateTime(date.year, date.month, date.day - 1);',
      'await Future.delayed(const Duration(milliseconds: 300));',
      'final label = AppTimeZone.formatTime(instant, loc);',
      'final now = clock.now().toUtc();',
      "final key = AppTimeZone.zoneDateKey(instant, loc);",
      'final r = AppTimeZone.dayRangeUtc(loc, day);',
      "final ok = AppTimeZone.isValidZoneName(name);",
      "final stored = AppTimeZone.encodeForPrefs(AppTimeZone.nowUtc());",
    ];
    for (final line in safe) {
      final caught = _forbidden.any((f) => f.pattern.hasMatch(line));
      expect(caught, isFalse, reason: 'false positive: $line');
    }
  });

  test('a new offender in any file is still caught (per line)', () {
    const victim = 'lib/features/settings/settings_screen.dart';
    final dir = Directory.systemTemp.createTempSync('tz_guard_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final fixture = File('${dir.path}/$victim')
      ..createSync(recursive: true)
      ..writeAsStringSync([
        "    final label = DateFormat('dd/MM').format(createdAt);",
        '    final seen = DateTime.now();',
        '    final w = toWib(instant);',
      ].join('\n'));
    expect(fixture.existsSync(), isTrue);

    final offenders = _findOffenders(dir.path, [victim]);
    expect(offenders, hasLength(3));
  });
}
