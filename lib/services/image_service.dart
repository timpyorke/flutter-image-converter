import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_converters/models/resize_setting.dart';
import 'package:image_picker/image_picker.dart';
import '../models/image_data.dart';
import '../models/conversion_settings.dart';
import '../core/utils/image_cache.dart';
import 'image_processing_isolate.dart';

/// Service for handling image operations
class ImageService {
  final ImagePicker _picker = ImagePicker();
  final ImageCache _thumbnailCache = ImageCache();

  /// Pick an image from gallery
  Future<ImageData?> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return null;

      final bytes = await pickedFile.readAsBytes();
      final image = await ImageProcessingIsolate.decodeImage(bytes);

      if (image == null) return null;

      return ImageData(
        path: pickedFile.path,
        bytes: bytes,
        name: pickedFile.name,
        width: image.width,
        height: image.height,
        format: _getFormatFromPath(pickedFile.path),
        sizeInBytes: bytes.length,
      );
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  /// Pick multiple images from gallery
  Future<List<ImageData>> pickMultipleImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isEmpty) return [];

      final List<ImageData> images = [];

      for (final pickedFile in pickedFiles) {
        try {
          final bytes = await pickedFile.readAsBytes();
          final image = await ImageProcessingIsolate.decodeImage(bytes);

          if (image != null) {
            images.add(
              ImageData(
                path: pickedFile.path,
                bytes: bytes,
                name: pickedFile.name,
                width: image.width,
                height: image.height,
                format: _getFormatFromPath(pickedFile.path),
                sizeInBytes: bytes.length,
              ),
            );
          }
        } catch (e) {
          // Skip images that fail to load
          debugPrint('Failed to load image ${pickedFile.name}: $e');
        }
      }

      return images;
    } catch (e) {
      throw Exception('Failed to pick images: $e');
    }
  }

  /// Convert image to specified format
  Future<ImageData> convertImage(
    ImageData sourceImage,
    ConversionSettings settings,
  ) async {
    try {
      if (sourceImage.bytes == null) {
        throw Exception('Source image bytes are null');
      }

      final convertedBytes = await ImageProcessingIsolate.convertImage(
        ConvertImageParams(
          imageBytes: sourceImage.bytes!,
          targetFormat: settings.targetFormat,
          quality: settings.quality,
        ),
      );

      return sourceImage.copyWith(
        bytes: convertedBytes,
        format: settings.targetFormat.extension,
        sizeInBytes: convertedBytes.length,
        name: _changeFileExtension(
          sourceImage.name ?? 'image',
          settings.targetFormat.extension,
        ),
      );
    } catch (e) {
      throw Exception('Failed to convert image: $e');
    }
  }

  /// Resize image
  Future<ImageData> resizeImage(
    ImageData sourceImage,
    ResizeSettings settings,
  ) async {
    try {
      if (sourceImage.bytes == null) {
        throw Exception('Source image bytes are null');
      }

      final result = await ImageProcessingIsolate.resizeImage(
        ResizeImageParams(
          imageBytes: sourceImage.bytes!,
          width: settings.width,
          height: settings.height,
          maintainAspectRatio: settings.maintainAspectRatio,
          format: sourceImage.format,
        ),
      );

      return sourceImage.copyWith(
        bytes: result.bytes,
        width: result.width,
        height: result.height,
        sizeInBytes: result.bytes.length,
      );
    } catch (e) {
      throw Exception('Failed to resize image: $e');
    }
  }

  /// Save image to device
  Future<String> saveImage(ImageData imageData, String directory) async {
    try {
      if (imageData.bytes == null) {
        throw Exception('No image data to save');
      }
      final format = imageData.format ?? 'jpg';
      final fileName =
          imageData.name ??
          'image_${DateTime.now().millisecondsSinceEpoch}.$format';
      final filePath = '$directory/$fileName';
      final file = File(filePath);

      await file.writeAsBytes(imageData.bytes!);

      return filePath;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  /// Get or create thumbnail for image (with caching)
  Future<Uint8List> getThumbnail(
    ImageData imageData, {
    int maxSize = 200,
  }) async {
    if (imageData.bytes == null) {
      throw Exception('No image data for thumbnail');
    }

    // Generate cache key based on image path and size
    final cacheKey = '${imageData.path}_$maxSize';

    // Check cache first
    final cached = _thumbnailCache.get(cacheKey);
    if (cached != null) {
      return cached;
    }

    // Generate thumbnail in isolate
    final thumbnail = await ImageProcessingIsolate.createThumbnail(
      ThumbnailParams(imageBytes: imageData.bytes!, maxSize: maxSize),
    );

    // Cache the thumbnail
    _thumbnailCache.put(cacheKey, thumbnail);

    return thumbnail;
  }

  /// Clear thumbnail cache
  void clearThumbnailCache() {
    _thumbnailCache.clear();
  }

  String _getFormatFromPath(String path) {
    final extension = path.split('.').last.toLowerCase();
    return extension;
  }

  String _changeFileExtension(String fileName, String newExtension) {
    final parts = fileName.split('.');
    if (parts.length > 1) {
      parts.removeLast();
    }
    return '${parts.join('.')}.$newExtension';
  }
}
