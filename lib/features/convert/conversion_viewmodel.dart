import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/conversion_state_type.dart';
import 'package:flutter_image_converters/core/const/image_format.dart';
import 'package:flutter_image_converters/l10n/l10n.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/features/convert/models/conversion_settings.dart';
import 'package:flutter_image_converters/data/image_data.dart';
import 'package:flutter_image_converters/data/providers/shared_pref_provider.dart';
import 'package:flutter_image_converters/core/services/dialog_service.dart';
import 'package:flutter_image_converters/features/convert/models/convert_view_state.dart';
import '../../core/services/image_service.dart';
import '../../domain/usecases/convert_and_save_images_usecase.dart';

/// ViewModel for Image Conversion operations
class ConversionViewModel extends ChangeNotifier {
  final ConvertAndSaveImagesUseCase convertAndSaveUseCase;
  final SharedPrefProvider sharedPrefProvider;
  final DialogService dialogService;
  final ImageService imageService;

  ConversionViewModel({
    required this.dialogService,
    required this.convertAndSaveUseCase,
    required this.sharedPrefProvider,
    required this.imageService,
  });

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
  bool get shouldAutoSave => sharedPrefProvider.getSaveToGallery();
  bool get shouldShowSaveButton => !shouldAutoSave && hasConvertedImages;

  /// Pick multiple images from gallery
  Future<void> pickImages() async {
    _state = _state.copyWithPicking();
    notifyListeners();

    try {
      final images = await imageService.pickMultipleImages();

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
        final convertedImage = await imageService.convertImage(
          sourceImage,
          _state.settings,
        );
        converted.add(convertedImage);
        count++;

        // Only notify every 10% progress or last item to reduce UI updates
        if (count % (_state.sourceImages.length ~/ 10 + 1) == 0 ||
            count == _state.sourceImages.length) {
          _state = _state.copyWithProgress(count);
          notifyListeners();
        }
      }

      // Ensure final state is set
      if (_state.convertedCount != converted.length) {
        _state = _state.copyWithProgress(converted.length);
      }
      _state = _state.copyWithSuccess(convertedImages: converted);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  void onConvertAndSaveImages(BuildContext context) async {
    await convertAndSaveImages();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            hasSavedImages
                ? 'Successfully saved ${savedPaths.length} image${savedPaths.length > 1 ? "s" : ""}!'
                : 'Failed to save images',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              hasSavedImages ? Colors.green.shade600 : Colors.red.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
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
      final storageLocation = sharedPrefProvider.getStorageLocation();
      final totalImages = _state.sourceImages.length;
      final result = await convertAndSaveUseCase.execute(
        sourceImages: _state.sourceImages,
        settings: _state.settings,
        saveToPath: storageLocation,
        onProgress: (current, total) {
          // Only notify every 10% progress to reduce UI updates
          if (current % (total ~/ 10 + 1) == 0 || current == total) {
            _state = _state.copyWithProgress(totalImages + current);
            notifyListeners();
          }
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
    if (_state.settings == newSettings) return;
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

  void onShowConvertAdDialog(
    BuildContext context, {
    required int imageCount,
    required Future<void> Function() onContinue,
  }) {
    dialogService.showAdDialog(
      context,
      onContinue: () => convertImagesWithProgress(context),
      title: context.l10n.readyToConvert,
      subtitle: context.l10n.thisWillConvertNImages(sourceImages.length),
    );
  }

  /// Convert images with background processing and show toast on completion
  Future<void> convertImagesWithProgress(BuildContext context) async {
    // Start processing (dialog will dismiss, overlay will show)
    final imageCount = sourceImages.length;

    // Convert images
    if (shouldAutoSave) {
      await convertAndSaveImages();
    } else {
      await convertImages();
    }

    // Show success toast after completion
    if (context.mounted && hasConvertedImages) {
      ToastHelper.showSuccess(
        context,
        context.l10n.conversionComplete,
        subtitle: shouldAutoSave
            ? context.l10n.savedNImagesSuccessfully(imageCount)
            : context.l10n.convertedNImagesSuccessfully(imageCount),
      );
    }
  }
}
