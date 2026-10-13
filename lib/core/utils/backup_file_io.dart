import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'app_timezone.dart';

/// Berkas cadangan `.rlb` untuk rulebook: kirim lewat share sheet, pulihkan via FilePicker.
///
/// Isi berkas tetap `FleetBackupCodec` (`FSBK1#RULEBOOK#...`); ekstensi hanya
/// membedakan berkas cadangan resmi dari JSON mentah yang bisa diedit manual.
class BackupFileIo {
  BackupFileIo._();

  static const String slug = 'rulebook';
  static const String fileExtension = 'rlb';
  static const String mimeType = 'application/octet-stream';

  /// `rulebook-YYYY-MM-DD.rlb`. Stempel memakai hari kalender zona terpilih (bukan zona perangkat).
  static String fileName({DateTime? now}) {
    final instant = (now ?? AppTimeZone.nowUtc()).toUtc();
    final stamp = AppTimeZone.zoneDateKey(
      instant,
      AppTimeZone.locationOrFallback(null),
    );
    return '$slug-$stamp.$fileExtension';
  }

  /// Menulis [payload] ke berkas sementara lalu membuka share sheet sistem.
  ///
  /// Di web berkas dibuat dari memori (tanpa path_provider).
  static Future<void> exportToShareSheet(
    String payload, {
    String? subject,
    DateTime? now,
  }) async {
    final name = fileName(now: now);
    final XFile xfile;
    if (kIsWeb) {
      xfile = XFile.fromData(
        Uint8List.fromList(utf8.encode(payload)),
        mimeType: mimeType,
        name: name,
      );
    } else {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$name');
      await file.writeAsString(payload);
      xfile = XFile(file.path, mimeType: mimeType, name: name);
    }
    await SharePlus.instance.share(
      ShareParams(
        files: [xfile],
        fileNameOverrides: [name],
        subject: subject,
      ),
    );
  }

  /// Memilih berkas `.rlb` / `.bak` dan mengembalikan isinya, atau `null` bila dibatalkan.
  static Future<String?> pickBackupContents() async {
    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const [fileExtension, 'bak'],
    );
    if (picked.isEmpty) return null;
    final bytes = await picked.first.readAsBytes();
    return utf8.decode(bytes, allowMalformed: true);
  }
}
