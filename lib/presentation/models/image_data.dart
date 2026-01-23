import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_data.freezed.dart';

/// Model representing an image data object
@freezed
class ImageData with _$ImageData {
  const ImageData._();

  const factory ImageData({
    String? path,
    Uint8List? bytes,
    String? name,
    int? width,
    int? height,
    String? format,
    int? sizeInBytes,
  }) = _ImageData;

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
