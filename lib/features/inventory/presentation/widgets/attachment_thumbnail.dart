import 'dart:typed_data';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumahku/core/providers.dart';

/// Displays a locally stored attachment image across native and Web platforms.
class AttachmentThumbnail extends ConsumerWidget {
  const AttachmentThumbnail({
    super.key,
    required this.localPath,
    this.width = 96,
    this.height = 96,
    this.borderRadius = 12,
  });

  final String? localPath;
  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = localPath;
    if (path == null || path.isEmpty) {
      return _placeholder(context);
    }

    final media = ref.watch(mediaStorageServiceProvider);
    return FutureBuilder<Uint8List?>(
      future: media.readBytes(path),
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null || bytes.isEmpty) {
          return _placeholder(context);
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.memory(
            bytes,
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _placeholder(context),
          ),
        );
      },
    );
  }

  Widget _placeholder(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        Icons.image_outlined,
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}
