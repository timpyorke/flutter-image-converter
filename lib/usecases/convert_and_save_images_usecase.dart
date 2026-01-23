import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:permission_handler/permission_handler.dart';
import '../const/image_format.dart';
import '../models/image_data.dart';
import '../models/conversion_settings.dart';
import '../services/image_service.dart';

/// Use case for converting and saving images in the background
class ConvertAndSaveImagesUseCase {
  final ImageService imageService;

  ConvertAndSaveImagesUseCase({required this.imageService});

  /// Convert and save images with progress callback
  Future<ConvertAndSaveResult> execute({
    required List<ImageData> sourceImages,
    required ConversionSettings settings,
    required Function(int current, int total) onProgress,
    String? saveToPath,
  }) async {
    if (sourceImages.isEmpty) {
      throw Exception('No images to convert');
    }

    // Request storage permission
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      throw Exception('Storage permission denied');
    }

    final List<ImageData> convertedImages = [];
    final List<String> savedPaths = [];
    int successCount = 0;
    int failedCount = 0;

    try {
      // Process images in background
      await compute(_convertImagesInBackground, {
        'sourceImages': sourceImages,
        'settings': settings,
      }).then((results) async {
        convertedImages.addAll(results);

        // Save converted images
        for (int i = 0; i < convertedImages.length; i++) {
          try {
            final savedPath = await _saveImage(
              convertedImages[i],
              settings.targetFormat,
              saveToPath: saveToPath,
            );
            savedPaths.add(savedPath);
            successCount++;
          } catch (e) {
            debugPrint('Failed to save image ${i + 1}: $e');
            failedCount++;
          }

          // Report progress
          onProgress(i + 1, convertedImages.length);
        }
      });
    } catch (e) {
      throw Exception('Failed to convert images: $e');
    }

    return ConvertAndSaveResult(
      convertedImages: convertedImages,
      savedPaths: savedPaths,
      successCount: successCount,
      failedCount: failedCount,
    );
  }

  /// Convert images in background isolate
  static Future<List<ImageData>> _convertImagesInBackground(
    Map<String, dynamic> params,
  ) async {
    final List<ImageData> sourceImages = params['sourceImages'];
    final ConversionSettings settings = params['settings'];
    final imageService = ImageService();

    final List<ImageData> convertedImages = [];

    for (final sourceImage in sourceImages) {
      try {
        final converted = await imageService.convertImage(
          sourceImage,
          settings,
        );
        convertedImages.add(converted);
      } catch (e) {
        debugPrint('Failed to convert image: $e');
        // Add source image as fallback
        convertedImages.add(sourceImage);
      }
    }

    return convertedImages;
  }

  /// Save image to device storage
  Future<String> _saveImage(
    ImageData imageData,
    ImageFormat format, {
    String? saveToPath,
  }) async {
    return imageService.saveImage(imageData, saveToPath ?? '');
  }

  /// Request storage permission
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13+ (API 33+), photos permission is sufficient for MediaStore
      final photosStatus = await Permission.photos.status;
      if (photosStatus.isGranted) {
        return true;
      }

      // Request photos permission
      final photosResult = await Permission.photos.request();
      if (photosResult.isGranted) {
        return true;
      }

      // Fallback to storage permission for older Android versions
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) {
        return true;
      }

      final storageResult = await Permission.storage.request();
      return storageResult.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }

    return true; // For other platforms
  }
}

/// Result of convert and save operation
class ConvertAndSaveResult {
  final List<ImageData> convertedImages;
  final List<String> savedPaths;
  final int successCount;
  final int failedCount;

  ConvertAndSaveResult({
    required this.convertedImages,
    required this.savedPaths,
    required this.successCount,
    required this.failedCount,
  });

  bool get hasFailures => failedCount > 0;
  int get totalProcessed => successCount + failedCount;
}
