import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> saveLocalMediaBytes({
  required String fileName,
  required Uint8List bytes,
  required String mimeType,
}) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final mediaDir = Directory(p.join(docsDir.path, 'rumahku_media'));
  if (!await mediaDir.exists()) {
    await mediaDir.create(recursive: true);
  }
  final filePath = p.join(mediaDir.path, fileName);
  final file = File(filePath);
  await file.writeAsBytes(bytes, flush: true);
  return filePath;
}

Future<Uint8List?> readLocalMediaBytes(String localPath) async {
  final file = File(localPath);
  if (!await file.exists()) return null;
  return file.readAsBytes();
}
