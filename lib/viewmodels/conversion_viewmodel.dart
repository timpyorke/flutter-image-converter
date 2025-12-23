import 'package:flutter/foundation.dart';
import 'package:flutter_image_converters/const/conversion_state_type.dart';
import 'package:flutter_image_converters/const/image_format.dart';
import 'package:flutter_image_converters/views/convert/models/convert_view_state.dart';
import '../models/image_data.dart';
import '../models/conversion_settings.dart';
import '../services/image_service.dart';
import '../services/storage_service.dart';
import '../usecases/convert_and_save_images_usecase.dart';

/// ViewModel for Image Conversion operations
class ConversionViewModel extends ChangeNotifier {
  final ImageService _imageService;
  final ConvertAndSaveImagesUseCase _convertAndSaveUseCase;
  final StorageService _storageService;

  ConversionViewModel({
    required ImageService imageService,
    required ConvertAndSaveImagesUseCase convertAndSaveUseCase,
    required StorageService storageService,
  }) : _imageService = imageService,
       _convertAndSaveUseCase = convertAndSaveUseCase,
       _storageService = storageService;

  // State
  ConvertViewState _state = ConvertViewState.initial();

  // Getters
  ConvertViewState get viewState => _state;
  ConversionStateType get state => _state.state;
  List<ImageData> get sourceImages => _state.sourceImages;
  List<ImageData> get convertedImages => _state.convertedImages;
  List<String> get savedPaths => _state.savedPaths;
  ConversionSettings get settings => _state.settings;
  String? get errorMessage => _state.errorMessage;
  bool get hasSourceImages => _state.hasSourceImages;
  bool get hasConvertedImages => _state.hasConvertedImages;
  bool get hasSavedImages => _state.hasSavedImages;
  bool get isLoading => _state.isLoading;
  int get convertedCount => _state.convertedCount;
  int get totalCount => _state.totalCount;
  double get progress => _state.progress;
  bool get shouldAutoSave => _storageService.getBool('saveToGallery') ?? true;
  bool get shouldShowSaveButton => !shouldAutoSave && hasConvertedImages;

  /// Pick multiple images from gallery
  Future<void> pickImages() async {
    _state = _state.copyWithPicking();
    notifyListeners();

    try {
      final images = await _imageService.pickMultipleImages();

      if (images.isNotEmpty) {
        _state = _state.copyWithSourceImages(images);
      } else {
        _state = _state.copyWithIdle();
      }
      notifyListeners();
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  /// Convert all selected images
  Future<void> convertImages() async {
    if (_state.sourceImages.isEmpty) {
      _state = _state.copyWithError('No images selected');
      notifyListeners();
      return;
    }

    // If auto-save is enabled, use convertAndSaveImages instead
    if (shouldAutoSave) {
      await convertAndSaveImages();
      return;
    }

    _state = _state.copyWithConverting();
    notifyListeners();

    try {
      final List<ImageData> converted = [];
      int count = 0;

      for (final sourceImage in _state.sourceImages) {
        final convertedImage = await _imageService.convertImage(
          sourceImage,
          _state.settings,
        );
        converted.add(convertedImage);
        count++;
        _state = _state.copyWithProgress(count);
        notifyListeners(); // Update progress
      }

      _state = _state.copyWithSuccess(convertedImages: converted);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  /// Convert and save all selected images in background
  Future<void> convertAndSaveImages() async {
    if (_state.sourceImages.isEmpty) {
      _state = _state.copyWithError('No images selected');
      notifyListeners();
      return;
    }

    _state = _state.copyWithConvertingAndSaving();
    notifyListeners();

    try {
      final result = await _convertAndSaveUseCase.execute(
        sourceImages: _state.sourceImages,
        settings: _state.settings,
        onProgress: (current, total) {
          _state = _state.copyWithProgress(
            _state.sourceImages.length + current,
          );
          notifyListeners();
        },
      );

      String? errorMsg;
      if (result.hasFailures) {
        errorMsg =
            'Saved ${result.successCount} of ${result.totalProcessed} images';
      }

      _state = _state.copyWithSuccess(
        convertedImages: result.convertedImages,
        savedPaths: result.savedPaths,
        errorMessage: errorMsg,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  /// Update conversion settings
  void updateSettings(ConversionSettings newSettings) {
    _state = _state.copyWith(settings: newSettings);
    notifyListeners();
  }

  /// Update target format
  void updateTargetFormat(ImageFormat format) {
    _state = _state.copyWith(
      settings: _state.settings.copyWith(targetFormat: format),
    );
    notifyListeners();
  }

  /// Update quality
  void updateQuality(int quality) {
    _state = _state.copyWith(
      settings: _state.settings.copyWith(quality: quality),
    );
    notifyListeners();
  }

  /// Clear all images
  void clear() {
    _state = _state.copyWithClear();
    notifyListeners();
  }

  /// Remove a specific source image
  void removeSourceImage(int index) {
    _state = _state.copyWithRemovedImage(index);
    notifyListeners();
  }

  /// Reset error state
  void clearError() {
    if (_state.state == ConversionStateType.error) {
      _state = _state.copyWithIdle();
      notifyListeners();
    }
  }
}
