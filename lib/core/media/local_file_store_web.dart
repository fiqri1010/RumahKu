import 'dart:convert';
import 'dart:typed_data';

/// Web-safe local media store using data URIs so thumbnails & uploads work
/// inside SQLite WASM without `dart:io`.
Future<String> saveLocalMediaBytes({
  required String fileName,
  required Uint8List bytes,
  required String mimeType,
}) async {
  final b64 = base64Encode(bytes);
  return 'data:$mimeType;base64,$b64';
}

Future<Uint8List?> readLocalMediaBytes(String localPath) async {
  if (!localPath.startsWith('data:')) return null;
  final commaIndex = localPath.indexOf(',');
  if (commaIndex == -1) return null;
  return base64Decode(localPath.substring(commaIndex + 1));
}
