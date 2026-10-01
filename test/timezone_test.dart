import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rulebook/core/utils/app_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

// Must pass under both `TZ=UTC flutter test` and `TZ=Asia/Jakarta
// flutter test`: every instant here is built with `DateTime.utc` or
// `TZDateTime`, never with a device-zone constructor or `DateTime.now()`.
// Wall-clock "now" comes from `package:clock`, frozen with `withClock`.
void main() {
  late tz.Location jakarta;
  late tz.Location newYork;

  setUpAll(() {
    AppTimeZone.initAppTimeZones();
    jakarta = tz.getLocation('Asia/Jakarta');
    newYork = tz.getLocation('America/New_York');
  });

  group('zone resolution', () {
    test('curated zones all resolve', () {
      for (final z in kCuratedZones) {
        expect(AppTimeZone.isValidZoneName(z.iana), isTrue, reason: z.iana);
      }
    });

    test('garbage names are rejected (§VAL)', () {
      expect(AppTimeZone.isValidZoneName('Mars/Olympus'), isFalse);
      expect(AppTimeZone.isValidZoneName(''), isFalse);
      expect(AppTimeZone.isValidZoneName('GMT+7'), isFalse);
    });

    test('unknown zone falls back to Jakarta, never throws', () {
      expect(
        AppTimeZone.locationOrFallback('Mars/Olympus').name,
        'Asia/Jakarta',
      );
      expect(AppTimeZone.locationOrFallback(null).name, 'Asia/Jakarta');
    });

    test('device zone override is honored in tests', () async {
      AppTimeZone.debugDeviceZoneOverride = 'America/New_York';
      addTearDown(() => AppTimeZone.debugDeviceZoneOverride = null);
      expect(await AppTimeZone.getDeviceZoneName(), 'America/New_York');
    });

    test('device zone falls back to Jakarta when unreadable', () async {
      AppTimeZone.debugDeviceZoneOverride = 'Mars/Olympus';
      addTearDown(() => AppTimeZone.debugDeviceZoneOverride = null);
      // No override accepted + no platform channel in tests → fallback.
      expect(await AppTimeZone.getDeviceZoneName(), 'Asia/Jakarta');
    });
  });

  group('DST spring-forward (America/New_York 2024-03-10)', () {
    test('01:59 + 1 minute = 03:00, never 02:xx', () {
      final ny = newYork;
      final before = tz.TZDateTime(ny, 2024, 3, 10, 1, 59);
      final after = before.add(const Duration(minutes: 1));
      expect(after.hour, 3);
      expect(after.minute, 0);
      expect(after.day, 10);
    });

    test('offsetFor is DST-aware per instant, never cached', () {
      final ny = newYork;
      expect(
        AppTimeZone.offsetFor(DateTime.utc(2024, 1, 15, 12), ny),
        const Duration(hours: -5),
      );
      expect(
        AppTimeZone.offsetFor(DateTime.utc(2024, 7, 15, 12), ny),
        const Duration(hours: -4),
      );
      // Jakarta has no DST: same offset winter and summer.
      expect(
        AppTimeZone.offsetFor(DateTime.utc(2024, 1, 15, 12), jakarta),
        const Duration(hours: 7),
      );
      expect(
        AppTimeZone.offsetFor(DateTime.utc(2024, 7, 15, 12), jakarta),
        const Duration(hours: 7),
      );
    });

    test('offset labels follow the instant', () {
      expect(
        AppTimeZone.offsetLabel('America/New_York', DateTime.utc(2024, 1, 15)),
        'GMT-5',
      );
      expect(
        AppTimeZone.offsetLabel('America/New_York', DateTime.utc(2024, 7, 15)),
        'GMT-4',
      );
      expect(
        AppTimeZone.offsetLabel('Asia/Jakarta', DateTime.utc(2024, 7, 15)),
        'GMT+7',
      );
      expect(
        AppTimeZone.offsetLabel('Etc/UTC', DateTime.utc(2024, 7, 15)),
        'GMT+0',
      );
    });
  });

  group('prefs round-trip stays UTC across zones', () {
    test('encode → decode preserves the instant in Jakarta and New York', () {
      withClock(Clock.fixed(DateTime.utc(2026, 8, 20, 18, 30)), () {
        final now = AppTimeZone.nowUtc();
        final stored = AppTimeZone.encodeForPrefs(now);
        expect(stored, '2026-08-20T18:30:00.000Z');

        final inJakarta = AppTimeZone.decodeToZone(stored, jakarta);
        expect((inJakarta.hour, inJakarta.minute), (1, 30));
        expect((inJakarta.day, inJakarta.month), (21, 8));

        // EDT (UTC-4) in August: still the 20th over there.
        final inNy = AppTimeZone.decodeToZone(stored, newYork);
        expect((inNy.hour, inNy.minute), (14, 30));
        expect((inNy.day, inNy.month), (20, 8));

        // Same instant, different calendar days per zone.
        expect(AppTimeZone.zoneDateKey(now, jakarta), '2026-08-21');
        expect(AppTimeZone.zoneDateKey(now, newYork), '2026-08-20');
      });
    });

    test('todayKey follows the frozen clock in each zone', () {
      withClock(Clock.fixed(DateTime.utc(2026, 8, 20, 18, 30)), () {
        expect(AppTimeZone.todayKey(jakarta), '2026-08-21');
        expect(AppTimeZone.todayKey(newYork), '2026-08-20');
      });
    });

    test('decodeToZone throws loud on garbage, never guesses', () {
      expect(
        () => AppTimeZone.decodeToZone('not a date', jakarta),
        throwsFormatException,
      );
    });
  });

  group('dayRangeUtc half-open windows', () {
    test('Jakarta day: 17:00Z previous day .. 17:00Z', () {
      final r = AppTimeZone.dayRangeUtc(jakarta, DateTime.utc(2026, 8, 21));
      expect(r.startUtc, DateTime.utc(2026, 8, 20, 17));
      expect(r.endUtc, DateTime.utc(2026, 8, 21, 17));
      expect(r.endUtc.difference(r.startUtc), const Duration(hours: 24));
      // Half-open: the last millisecond still belongs to the day...
      expect(
        AppTimeZone.zoneDateKey(
          r.endUtc.subtract(const Duration(milliseconds: 1)),
          jakarta,
        ),
        '2026-08-21',
      );
      // ...and the edge itself is already tomorrow.
      expect(AppTimeZone.zoneDateKey(r.endUtc, jakarta), '2026-08-22');
    });

    test('DST spring-forward day is 23h, edges on zone midnights', () {
      final r =
          AppTimeZone.dayRangeUtc(newYork, DateTime.utc(2024, 3, 10));
      // Midnight EST (UTC-5) .. next midnight EDT (UTC-4).
      expect(r.startUtc, DateTime.utc(2024, 3, 10, 5));
      expect(r.endUtc, DateTime.utc(2024, 3, 11, 4));
      expect(r.endUtc.difference(r.startUtc), const Duration(hours: 23));
    });

    test('month boundary: Jan 31 hands over to Feb 1 cleanly', () {
      final r = AppTimeZone.dayRangeUtc(jakarta, DateTime.utc(2026, 1, 31));
      expect(r.startUtc, DateTime.utc(2026, 1, 30, 17));
      expect(r.endUtc, DateTime.utc(2026, 1, 31, 17));
      expect(AppTimeZone.zoneDateKey(r.endUtc, jakarta), '2026-02-01');
    });
  });

  group('parseUtc semantics preserved', () {
    test('Z and offsets parsed as is', () {
      expect(
        AppTimeZone.parseUtc('2026-08-21T05:00:00.000Z', zone: jakarta),
        DateTime.utc(2026, 8, 21, 5, 0),
      );
      expect(
        AppTimeZone.parseUtc('2026-08-21T12:00:00+0700', zone: jakarta),
        DateTime.utc(2026, 8, 21, 5),
      );
    });

    test('naive strings are UTC, never device-local', () {
      expect(
        AppTimeZone.parseUtc('2026-08-21T05:00:00', zone: jakarta),
        DateTime.utc(2026, 8, 21, 5, 0),
      );
    });

    test('bare date is midnight in the given zone', () {
      // Jakarta midnight = 17:00Z the day before.
      expect(
        AppTimeZone.parseUtc('2026-01-15', zone: jakarta),
        DateTime.utc(2026, 1, 14, 17, 0, 0),
      );
      // New York midnight in January (EST, UTC-5) = 05:00Z same day.
      expect(
        AppTimeZone.parseUtc('2026-01-15', zone: newYork),
        DateTime.utc(2026, 1, 15, 5, 0, 0),
      );
    });

    test('impossible dates return null on every path', () {
      expect(AppTimeZone.parseUtc('2026-02-30', zone: jakarta), isNull);
      expect(AppTimeZone.parseUtc('2026-02-30T10:00:00Z', zone: jakarta), isNull);
      expect(AppTimeZone.parseUtc('2026-02-30T10:00:00', zone: jakarta), isNull);
    });

    test('epoch-ms and short digit strings', () {
      const ms = 1755752400000;
      final expected = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
      expect(AppTimeZone.parseUtc(ms, zone: jakarta), expected);
      expect(AppTimeZone.parseUtc('$ms', zone: jakarta), expected);
      expect(AppTimeZone.parseUtc('20260115', zone: jakarta), isNull);
    });
  });

  group('zone input round-trip', () {
    test('typed wall clock → UTC → wall clock, including across DST', () {
      final ny = newYork;
      // Winter: EST (UTC-5).
      expect(
        AppTimeZone.zoneInputToUtc('2026-01-15T10:00', ny),
        '2026-01-15T15:00:00.000Z',
      );
      // Summer: EDT (UTC-4) — same wall clock, different instant.
      expect(
        AppTimeZone.zoneInputToUtc('2026-07-15T10:00', ny),
        '2026-07-15T14:00:00.000Z',
      );
      final instant = DateTime.utc(2026, 7, 15, 14, 0);
      expect(AppTimeZone.utcToZoneInput(instant, ny), '2026-07-15T10:00');
      // Invalid input never rolls over.
      expect(AppTimeZone.zoneInputToUtc('2026-01-15T24:00', ny), isNull);
      expect(AppTimeZone.zoneInputToUtc('2026-02-30T10:00', ny), isNull);
    });
  });

  group('formatting', () {
    test('time is always 24-hour, never AM/PM', () {
      final s = AppTimeZone.formatTime(
        DateTime.utc(2026, 8, 21, 6, 45),
        jakarta,
      );
      expect(s, '13:45');
    });

    test('Jakarta midnight is 00:00, not 12:00', () {
      expect(
        AppTimeZone.formatTime(DateTime.utc(2026, 8, 20, 17, 0), jakarta),
        '00:00',
      );
    });

    test('same instant shows the right wall clock per zone', () {
      final instant = DateTime.utc(2026, 1, 15, 12, 0);
      expect(AppTimeZone.formatTime(instant, jakarta), '19:00');
      // EST (UTC-5) in January.
      expect(AppTimeZone.formatTime(instant, newYork), '07:00');
    });
  });

  group('backup exported_at stays UTC, displays zoned', () {
    test('encodeForPrefs output ends in Z and decodes per zone', () {
      withClock(Clock.fixed(DateTime.utc(2026, 8, 20, 18, 30)), () {
        final stored =
            AppTimeZone.encodeForPrefs(AppTimeZone.nowUtc());
        expect(stored.endsWith('Z'), isTrue);
        expect(AppTimeZone.zoneDateKey(
          AppTimeZone.parseUtc(stored, zone: jakarta)!,
          jakarta,
        ), '2026-08-21');
        expect(AppTimeZone.zoneDateKey(
          AppTimeZone.parseUtc(stored, zone: newYork)!,
          newYork,
        ), '2026-08-20');
      });
    });
  });
}
