import 'dart:convert';
import 'dart:typed_data';

/// Codec kustom untuk berkas cadangan dan pemulihan armada faishal.id.
/// Format biner terenkapsulasi:
/// `FSBK1#<APP_TAG>#<CHECKSUM_HEX>#<BASE64_OBFUSCATED_PAYLOAD>`
///
/// Menolak format JSON mentah untuk mencegah pengeditan manual yang ceroboh atau korupsi data.
class FleetBackupCodec {
  static const String prefix = 'FSBK1';

  static final Uint8List _defaultSalt =
      Uint8List.fromList(utf8.encode('faishal_salt_fleet_backup_v1'));

  /// Menghitung CRC-32 dari bytes data dengan salt.
  static int _computeCrc32(Uint8List bytes, Uint8List salt) {
    var crc = 0xFFFFFFFF;
    final combined = Uint8List(bytes.length + salt.length);
    combined.setRange(0, bytes.length, bytes);
    combined.setRange(bytes.length, combined.length, salt);

    for (var i = 0; i < combined.length; i++) {
      final b = combined[i];
      crc ^= b;
      for (var j = 0; j < 8; j++) {
        if ((crc & 1) != 0) {
          crc = (crc >>> 1) ^ 0xEDB88320;
        } else {
          crc = crc >>> 1;
        }
      }
    }
    return (crc ^ 0xFFFFFFFF) & 0xFFFFFFFF;
  }

  /// Obfuskasi simetris deterministik menggunakan bitwise XOR scrambling berjenjang.
  static Uint8List _maskBytes(Uint8List input, String key) {
    final keyBytes = utf8.encode(key);
    final output = Uint8List(input.length);
    for (var i = 0; i < input.length; i++) {
      final k = keyBytes[i % keyBytes.length];
      final shift = (i * 7 + 0x5A) & 0xFF;
      output[i] = input[i] ^ k ^ shift;
    }
    return output;
  }

  /// Mengubah map data menjadi format string cadangan kustom.
  static String encode({
    required String appTag,
    required Map<String, dynamic> data,
  }) {
    final jsonStr = json.encode(data);
    final rawBytes = Uint8List.fromList(utf8.encode(jsonStr));
    final checksum = _computeCrc32(rawBytes, _defaultSalt);
    final checksumHex = checksum.toRadixString(16).padLeft(8, '0');

    final maskedBytes = _maskBytes(rawBytes, appTag);
    final base64Payload = base64.encode(maskedBytes);

    return '$prefix#$appTag#$checksumHex#$base64Payload';
  }

  /// Membaca string cadangan kustom dan memvalidasi keutuhan serta asal aplikasi.
  static Map<String, dynamic> decode({
    required String appTag,
    required String encoded,
  }) {
    final trimmed = encoded.trim();

    // Deteksi jika pengguna mencoba mengunggah JSON mentah
    if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
      throw const FormatException(
        'Format JSON mentah tidak didukung untuk mencegah manipulasi data. '
        'Gunakan berkas atau kode cadangan resmi.',
      );
    }

    final parts = trimmed.split('#');
    if (parts.length != 4 || parts[0] != prefix) {
      throw const FormatException('Format cadangan tidak dikenali atau rusak.');
    }

    final fileAppTag = parts[1];
    if (fileAppTag != appTag) {
      throw FormatException(
        'Berkas cadangan ini milik aplikasi "$fileAppTag", bukan "$appTag".',
      );
    }

    final expectedChecksumHex = parts[2];
    final base64Payload = parts[3];

    final Uint8List maskedBytes;
    try {
      maskedBytes = base64.decode(base64Payload);
    } catch (e) {
      throw const FormatException('Data cadangan rusak (gagal decode Base64).');
    }

    final unmaskedBytes = _maskBytes(maskedBytes, appTag);
    final actualChecksum = _computeCrc32(unmaskedBytes, _defaultSalt);
    final actualChecksumHex = actualChecksum.toRadixString(16).padLeft(8, '0');

    if (actualChecksumHex.toLowerCase() != expectedChecksumHex.toLowerCase()) {
      throw const FormatException(
        'Integritas data cadangan tidak valid (checksum mismatch). '
        'Data mungkin telah dimodifikasi atau rusak.',
      );
    }

    final decodedJsonStr = utf8.decode(unmaskedBytes);
    final dynamic decodedObj = json.decode(decodedJsonStr);
    if (decodedObj is! Map<String, dynamic>) {
      throw const FormatException('Struktur isi data cadangan tidak sah.');
    }

    return decodedObj;
  }
}
