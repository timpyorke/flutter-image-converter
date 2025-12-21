import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../models/image_data.dart';
import '../models/conversion_settings.dart';

/// Service for handling image operations
class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// Pick an image from gallery
  Future<ImageData?> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return null;

      final bytes = await pickedFile.readAsBytes();
      final image = img.decodeImage(bytes);

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
          final image = img.decodeImage(bytes);

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

      final image = img.decodeImage(sourceImage.bytes!);
      if (image == null) {
        throw Exception('Failed to decode image');
      }

      Uint8List? convertedBytes;

      switch (settings.targetFormat) {
        case ImageFormat.jpg:
          convertedBytes = Uint8List.fromList(
            img.encodeJpg(image, quality: settings.quality),
          );
          break;
        case ImageFormat.png:
          convertedBytes = Uint8List.fromList(img.encodePng(image));
          break;
        case ImageFormat.webp:
          // Note: webp encoding might not be available in all versions
          // fallback to PNG if needed
          try {
            convertedBytes = Uint8List.fromList(
              img.encodeJpg(image, quality: settings.quality),
            );
          } catch (e) {
            convertedBytes = Uint8List.fromList(img.encodePng(image));
          }
          break;
        case ImageFormat.bmp:
          convertedBytes = Uint8List.fromList(img.encodeBmp(image));
          break;
      }

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

      final image = img.decodeImage(sourceImage.bytes!);
      if (image == null) {
        throw Exception('Failed to decode image');
      }

      int newWidth = settings.width ?? image.width;
      int newHeight = settings.height ?? image.height;

      if (settings.maintainAspectRatio) {
        if (settings.width != null && settings.height == null) {
          newHeight = (image.height * settings.width! / image.width).round();
        } else if (settings.height != null && settings.width == null) {
          newWidth = (image.width * settings.height! / image.height).round();
        }
      }

      final resized = img.copyResize(
        image,
        width: newWidth,
        height: newHeight,
        interpolation: img.Interpolation.linear,
      );

      // Keep original format
      Uint8List resizedBytes;
      if (sourceImage.format?.toLowerCase() == 'png') {
        resizedBytes = Uint8List.fromList(img.encodePng(resized));
      } else {
        resizedBytes = Uint8List.fromList(img.encodeJpg(resized, quality: 90));
      }

      return sourceImage.copyWith(
        bytes: resizedBytes,
        width: resized.width,
        height: resized.height,
        sizeInBytes: resizedBytes.length,
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

      final fileName =
          imageData.name ??
          'image_${DateTime.now().millisecondsSinceEpoch}.${imageData.format ?? 'jpg'}';
      final filePath = '$directory/$fileName';
      final file = File(filePath);

      await file.writeAsBytes(imageData.bytes!);

      return filePath;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
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
