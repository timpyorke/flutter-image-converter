import 'package:flutter/foundation.dart';
import '../models/image_data.dart';
import '../models/conversion_settings.dart';
import '../services/image_service.dart';
import '../usecases/convert_and_save_images_usecase.dart';

enum ConversionState { idle, picking, converting, saving, success, error }

/// ViewModel for Image Conversion operations
class ConversionViewModel extends ChangeNotifier {
  final ImageService _imageService;
  final ConvertAndSaveImagesUseCase _convertAndSaveUseCase;

  ConversionViewModel({
    ImageService? imageService,
    ConvertAndSaveImagesUseCase? convertAndSaveUseCase,
  }) : _imageService = imageService ?? ImageService(),
       _convertAndSaveUseCase =
           convertAndSaveUseCase ??
           ConvertAndSaveImagesUseCase(
             imageService: imageService ?? ImageService(),
           );

  // State
  ConversionState _state = ConversionState.idle;
  List<ImageData> _sourceImages = [];
  List<ImageData> _convertedImages = [];
  List<String> _savedPaths = [];
  ConversionSettings _settings = ConversionSettings(
    targetFormat: ImageFormat.png,
    quality: 90,
  );
  String? _errorMessage;
  int _convertedCount = 0;
  int _totalCount = 0;

  // Getters
  ConversionState get state => _state;
  List<ImageData> get sourceImages => _sourceImages;
  List<ImageData> get convertedImages => _convertedImages;
  List<String> get savedPaths => _savedPaths;
  ConversionSettings get settings => _settings;
  String? get errorMessage => _errorMessage;
  bool get hasSourceImages => _sourceImages.isNotEmpty;
  bool get hasConvertedImages => _convertedImages.isNotEmpty;
  bool get hasSavedImages => _savedPaths.isNotEmpty;
  bool get isLoading =>
      _state == ConversionState.picking ||
      _state == ConversionState.converting ||
      _state == ConversionState.saving;
  int get convertedCount => _convertedCount;
  int get totalCount => _totalCount;
  double get progress => _totalCount > 0 ? _convertedCount / _totalCount : 0.0;

  /// Pick multiple images from gallery
  Future<void> pickImages() async {
    _setState(ConversionState.picking);
    _errorMessage = null;

    try {
      final images = await _imageService.pickMultipleImages();

      if (images.isNotEmpty) {
        _sourceImages = images;
        _convertedImages = [];
        _convertedCount = 0;
        _totalCount = 0;
        _setState(ConversionState.idle);
      } else {
        _setState(ConversionState.idle);
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ConversionState.error);
    }
  }

  /// Convert all selected images
  Future<void> convertImages() async {
    if (_sourceImages.isEmpty) {
      _errorMessage = 'No images selected';
      _setState(ConversionState.error);
      return;
    }

    _setState(ConversionState.converting);
    _errorMessage = null;
    _convertedImages = [];
    _convertedCount = 0;
    _totalCount = _sourceImages.length;

    try {
      for (final sourceImage in _sourceImages) {
        final converted = await _imageService.convertImage(
          sourceImage,
          _settings,
        );
        _convertedImages.add(converted);
        _convertedCount++;
        notifyListeners(); // Update progress
      }

      _setState(ConversionState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ConversionState.error);
    }
  }

  /// Convert and save all selected images in background
  Future<void> convertAndSaveImages() async {
    if (_sourceImages.isEmpty) {
      _errorMessage = 'No images selected';
      _setState(ConversionState.error);
      return;
    }

    _setState(ConversionState.converting);
    _errorMessage = null;
    _convertedImages = [];
    _savedPaths = [];
    _convertedCount = 0;
    _totalCount = _sourceImages.length * 2; // Converting + Saving

    try {
      final result = await _convertAndSaveUseCase.execute(
        sourceImages: _sourceImages,
        settings: _settings,
        onProgress: (current, total) {
          _convertedCount = _sourceImages.length + current;
          notifyListeners();
        },
      );

      _convertedImages = result.convertedImages;
      _savedPaths = result.savedPaths;
      _convertedCount = _totalCount;

      if (result.hasFailures) {
        _errorMessage =
            'Saved ${result.successCount} of ${result.totalProcessed} images';
      }

      _setState(ConversionState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ConversionState.error);
    }
  }

  /// Update conversion settings
  void updateSettings(ConversionSettings newSettings) {
    _settings = newSettings;
    notifyListeners();
  }

  /// Update target format
  void updateTargetFormat(ImageFormat format) {
    _settings = _settings.copyWith(targetFormat: format);
    notifyListeners();
  }

  /// Update quality
  void updateQuality(int quality) {
    _settings = _settings.copyWith(quality: quality);
    notifyListeners();
  }

  /// Clear all images
  void clear() {
    _sourceImages = [];
    _convertedImages = [];
    _savedPaths = [];
    _errorMessage = null;
    _convertedCount = 0;
    _totalCount = 0;
    _setState(ConversionState.idle);
  }

  /// Remove a specific source image
  void removeSourceImage(int index) {
    if (index >= 0 && index < _sourceImages.length) {
      _sourceImages.removeAt(index);
      if (_sourceImages.isEmpty) {
        clear();
      } else {
        notifyListeners();
      }
    }
  }

  /// Reset error state
  void clearError() {
    _errorMessage = null;
    if (_state == ConversionState.error) {
      _setState(ConversionState.idle);
    }
  }

  void _setState(ConversionState newState) {
    _state = newState;
    notifyListeners();
  }
}
