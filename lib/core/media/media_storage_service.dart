import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:rumahku/core/media/local_file_store.dart';

class ProcessedMedia {
  const ProcessedMedia({
    required this.localPath,
    required this.mimeType,
    required this.fileSizeBytes,
  });

  final String localPath;
  final String mimeType;
  final int fileSizeBytes;
}

typedef LocalMediaSaver = Future<String> Function({
  required String fileName,
  required Uint8List bytes,
  required String mimeType,
});

typedef LocalMediaReader = Future<Uint8List?> Function(String localPath);

/// Compresses photos to max 1280px JPEG (~150-250 KB) so thousands of item
/// photos fit comfortably inside Supabase's 1 GB Free Tier Storage.
class MediaStorageService {
  MediaStorageService({
    LocalMediaSaver? saver,
    LocalMediaReader? reader,
  })  : _saver = saver ?? saveLocalMediaBytes,
        _reader = reader ?? readLocalMediaBytes;

  final LocalMediaSaver _saver;
  final LocalMediaReader _reader;

  static const int maxDimensionPx = 1280;
  static const int jpegQuality = 80;

  Future<ProcessedMedia> compressAndSaveImage({
    required String attachmentId,
    required Uint8List rawBytes,
  }) async {
    final compressed = kIsWeb
        ? _compressImageSync(rawBytes)
        : await Isolate.run(() => _compressImageSync(rawBytes));

    final localPath = await _saver(
      fileName: '$attachmentId.jpg',
      bytes: compressed,
      mimeType: 'image/jpeg',
    );
    return ProcessedMedia(
      localPath: localPath,
      mimeType: 'image/jpeg',
      fileSizeBytes: compressed.length,
    );
  }

  Future<Uint8List?> readBytes(String localPath) => _reader(localPath);

  static Uint8List _compressImageSync(Uint8List rawBytes) {
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) return rawBytes;

    img.Image resized = decoded;
    if (decoded.width > maxDimensionPx || decoded.height > maxDimensionPx) {
      if (decoded.width >= decoded.height) {
        resized = img.copyResize(decoded, width: maxDimensionPx);
      } else {
        resized = img.copyResize(decoded, height: maxDimensionPx);
      }
    }

    return Uint8List.fromList(img.encodeJpg(resized, quality: jpegQuality));
  }
}
