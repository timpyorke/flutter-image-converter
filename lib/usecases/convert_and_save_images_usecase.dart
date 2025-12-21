import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../const/image_format.dart';
import '../models/image_data.dart';
import '../models/conversion_settings.dart';
import '../services/image_service.dart';

/// Use case for converting and saving images in the background
class ConvertAndSaveImagesUseCase {
  ConvertAndSaveImagesUseCase({required ImageService imageService});

  /// Convert and save images with progress callback
  Future<ConvertAndSaveResult> execute({
    required List<ImageData> sourceImages,
    required ConversionSettings settings,
    required Function(int current, int total) onProgress,
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
  Future<String> _saveImage(ImageData imageData, ImageFormat format) async {
    if (imageData.bytes == null) {
      throw Exception('Image bytes are null');
    }

    // Get appropriate directory based on platform
    Directory? directory;

    if (Platform.isAndroid) {
      // For Android, save to Pictures directory
      directory = Directory('/storage/emulated/0/Pictures/ImageConverter');
    } else if (Platform.isIOS) {
      // For iOS, use application documents directory
      directory = await getApplicationDocumentsDirectory();
    } else {
      // Fallback to downloads directory
      directory = await getDownloadsDirectory();
    }

    if (directory == null) {
      throw Exception('Unable to access storage directory');
    }

    // Create directory if it doesn't exist
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    // Generate unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = format.extension;
    final fileName = 'converted_$timestamp$extension';
    final filePath = '${directory.path}/$fileName';

    // Write file
    final file = File(filePath);
    await file.writeAsBytes(imageData.bytes!);

    return filePath;
  }

  /// Request storage permission
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13+, use MANAGE_EXTERNAL_STORAGE or scoped storage
      final androidInfo = await Permission.storage.request();
      if (androidInfo.isGranted) {
        return true;
      }

      // Try photos permission for Android 13+
      final photosPermission = await Permission.photos.request();
      return photosPermission.isGranted;
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
