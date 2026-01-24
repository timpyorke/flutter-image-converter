import 'package:flutter/foundation.dart';
import 'package:flutter_image_converters/core/const/image_format.dart';
import 'package:image/image.dart' as img;

/// Isolate functions for heavy image processing operations
class ImageProcessingIsolate {
  /// Decode image in isolate
  static Future<img.Image?> decodeImage(Uint8List bytes) async {
    return compute(_decodeImageSync, bytes);
  }

  static img.Image? _decodeImageSync(Uint8List bytes) {
    final image = img.decodeImage(bytes);
    if (image == null) return null;
    return img.bakeOrientation(image);
  }

  /// Convert image in isolate
  static Future<Uint8List> convertImage(ConvertImageParams params) async {
    return compute(_convertImageSync, params);
  }

  static Uint8List _convertImageSync(ConvertImageParams params) {
    final image = img.decodeImage(params.imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Fix EXIF orientation first
    var processedImage = img.bakeOrientation(image);

    // Apply user-specified rotation if any
    if (params.rotation != 0) {
      processedImage = img.copyRotate(processedImage, angle: params.rotation);
    }

    Uint8List convertedBytes;

    switch (params.targetFormat) {
      case ImageFormat.jpg:
        convertedBytes = Uint8List.fromList(
          img.encodeJpg(processedImage, quality: params.quality),
        );
        break;
      case ImageFormat.png:
        convertedBytes = Uint8List.fromList(img.encodePng(processedImage));
        break;
      case ImageFormat.webp:
        try {
          convertedBytes = Uint8List.fromList(
            img.encodeJpg(processedImage, quality: params.quality),
          );
        } catch (e) {
          convertedBytes = Uint8List.fromList(img.encodePng(processedImage));
        }
        break;
      case ImageFormat.bmp:
        convertedBytes = Uint8List.fromList(img.encodeBmp(processedImage));
        break;
    }

    return convertedBytes;
  }

  /// Resize image in isolate
  static Future<ResizeImageResult> resizeImage(ResizeImageParams params) async {
    return compute(_resizeImageSync, params);
  }

  static ResizeImageResult _resizeImageSync(ResizeImageParams params) {
    final image = img.decodeImage(params.imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Fix orientation
    final orientedImage = img.bakeOrientation(image);

    int newWidth = params.width ?? orientedImage.width;
    int newHeight = params.height ?? orientedImage.height;

    if (params.maintainAspectRatio) {
      if (params.width != null && params.height == null) {
        newHeight = (orientedImage.height * params.width! / orientedImage.width)
            .round();
      } else if (params.height != null && params.width == null) {
        newWidth = (orientedImage.width * params.height! / orientedImage.height)
            .round();
      }
    }

    final resized = img.copyResize(
      orientedImage,
      width: newWidth,
      height: newHeight,
      interpolation: img.Interpolation.linear,
    );

    Uint8List resizedBytes;
    if (params.format?.toLowerCase() == 'png') {
      resizedBytes = Uint8List.fromList(img.encodePng(resized));
    } else {
      resizedBytes = Uint8List.fromList(img.encodeJpg(resized, quality: 90));
    }

    return ResizeImageResult(
      bytes: resizedBytes,
      width: resized.width,
      height: resized.height,
    );
  }

  /// Create thumbnail in isolate
  static Future<Uint8List> createThumbnail(ThumbnailParams params) async {
    return compute(_createThumbnailSync, params);
  }

  static Uint8List _createThumbnailSync(ThumbnailParams params) {
    final image = img.decodeImage(params.imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Fix orientation
    final orientedImage = img.bakeOrientation(image);

    final thumbnail = img.copyResize(
      orientedImage,
      width: params.maxSize,
      height: params.maxSize,
      interpolation: img.Interpolation.linear,
    );

    return Uint8List.fromList(img.encodeJpg(thumbnail, quality: 70));
  }
}

/// Parameters for convert image operation
class ConvertImageParams {
  final Uint8List imageBytes;
  final ImageFormat targetFormat;
  final int quality;
  final int rotation; // Rotation in degrees (0, 90, 180, 270)

  ConvertImageParams({
    required this.imageBytes,
    required this.targetFormat,
    required this.quality,
    this.rotation = 0,
  });
}

/// Parameters for resize image operation
class ResizeImageParams {
  final Uint8List imageBytes;
  final int? width;
  final int? height;
  final bool maintainAspectRatio;
  final String? format;

  ResizeImageParams({
    required this.imageBytes,
    this.width,
    this.height,
    required this.maintainAspectRatio,
    this.format,
  });
}

/// Result from resize operation
class ResizeImageResult {
  final Uint8List bytes;
  final int width;
  final int height;

  ResizeImageResult({
    required this.bytes,
    required this.width,
    required this.height,
  });
}

/// Parameters for thumbnail creation
class ThumbnailParams {
  final Uint8List imageBytes;
  final int maxSize;

  ThumbnailParams({required this.imageBytes, this.maxSize = 200});
}
