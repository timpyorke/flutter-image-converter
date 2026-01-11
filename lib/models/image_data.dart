import 'dart:typed_data';

/// Model representing an image data object
class ImageData {
  final String? path;
  final Uint8List? bytes;
  final String? name;
  final int? width;
  final int? height;
  final String? format;
  final int? sizeInBytes;

  ImageData({
    this.path,
    this.bytes,
    this.name,
    this.width,
    this.height,
    this.format,
    this.sizeInBytes,
  });

  ImageData copyWith({
    String? path,
    Uint8List? bytes,
    String? name,
    int? width,
    int? height,
    String? format,
    int? sizeInBytes,
  }) {
    return ImageData(
      path: path ?? this.path,
      bytes: bytes ?? this.bytes,
      name: name ?? this.name,
      width: width ?? this.width,
      height: height ?? this.height,
      format: format ?? this.format,
      sizeInBytes: sizeInBytes ?? this.sizeInBytes,
    );
  }

  String get sizeDisplay {
    if (sizeInBytes == null) return 'Unknown';
    final kb = sizeInBytes! / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(2)} KB';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(2)} MB';
  }

  String get dimensionsDisplay {
    if (width == null || height == null) return 'Unknown';
    return '$width x $height';
  }
}
