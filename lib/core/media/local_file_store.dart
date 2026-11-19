import 'dart:typed_data';

import 'package:rumahku/core/media/local_file_store_web.dart'
    if (dart.library.io) 'package:rumahku/core/media/local_file_store_io.dart'
    as impl;

/// Saves compressed attachment bytes locally across native (filesystem) and
/// web (data URI / in-memory) targets without breaking Web builds.
Future<String> saveLocalMediaBytes({
  required String fileName,
  required Uint8List bytes,
  required String mimeType,
}) =>
    impl.saveLocalMediaBytes(
      fileName: fileName,
      bytes: bytes,
      mimeType: mimeType,
    );

/// Reads local attachment bytes for UI display or background cloud upload.
Future<Uint8List?> readLocalMediaBytes(String localPath) =>
    impl.readLocalMediaBytes(localPath);
