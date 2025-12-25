import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/resize_state_type.dart';
import 'package:flutter_image_converters/core/utils/toast_helper.dart';
import 'package:flutter_image_converters/models/resize_setting.dart';
import 'package:flutter_image_converters/providers/shared_pref_provider.dart';
import 'package:flutter_image_converters/views/resize/models/resize_view_state.dart';
import '../models/image_data.dart';
import '../services/image_service.dart';

/// ViewModel for Image Resize operations
class ResizeViewModel extends ChangeNotifier {
  final ImageService _imageService;
  final SharedPrefProvider _sharedPrefProvider;

  // TextEditingControllers for dimension inputs
  late final TextEditingController widthController;
  late final TextEditingController heightController;

  ResizeViewModel({
    required ImageService imageService,
    required SharedPrefProvider sharedPrefProvider,
  }) : _imageService = imageService,
       _sharedPrefProvider = sharedPrefProvider {
    // Initialize controllers
    widthController = TextEditingController();
    heightController = TextEditingController();

    // Add listeners for automatic updates
    widthController.addListener(_onWidthChanged);
    heightController.addListener(_onHeightChanged);
  }

  // State
  ResizeViewState _state = ResizeViewState.initial();

  // Getters
  ResizeViewState get viewState => _state;
  ResizeStateType get state => _state.state;
  ImageData? get sourceImage => _state.sourceImage;
  ImageData? get resizedImage => _state.resizedImage;
  ResizeSettings get settings => _state.settings;
  String? get errorMessage => _state.errorMessage;
  bool get hasSourceImage => _state.hasSourceImage;
  bool get hasResizedImage => _state.hasResizedImage;
  bool get isLoading => _state.isLoading;
  bool get canResize => _state.canResize;
  bool get shouldAutoSave => _sharedPrefProvider.getSaveToGallery();
  bool get shouldShowSaveButton => !shouldAutoSave && hasResizedImage;

  /// Handle width controller changes
  void _onWidthChanged() {
    final width = int.tryParse(widthController.text);
    if (width != null && width != _state.settings.width) {
      updateWidth(width);

      // Update height if aspect ratio is maintained
      if (_state.settings.maintainAspectRatio && _state.sourceImage != null) {
        final sourceWidth = _state.sourceImage!.width ?? 1;
        final sourceHeight = _state.sourceImage!.height ?? 1;
        final newHeight = (sourceHeight * width / sourceWidth).round();

        // Update without triggering listener loop
        heightController.removeListener(_onHeightChanged);
        heightController.text = newHeight.toString();
        heightController.addListener(_onHeightChanged);

        updateHeight(newHeight);
      }
    }
  }

  /// Handle height controller changes
  void _onHeightChanged() {
    final height = int.tryParse(heightController.text);
    if (height != null && height != _state.settings.height) {
      updateHeight(height);

      // Update width if aspect ratio is maintained
      if (_state.settings.maintainAspectRatio && _state.sourceImage != null) {
        final sourceWidth = _state.sourceImage!.width ?? 1;
        final sourceHeight = _state.sourceImage!.height ?? 1;
        final newWidth = (sourceWidth * height / sourceHeight).round();

        // Update without triggering listener loop
        widthController.removeListener(_onWidthChanged);
        widthController.text = newWidth.toString();
        widthController.addListener(_onWidthChanged);

        updateWidth(newWidth);
      }
    }
  }

  /// Pick an image from gallery
  Future<void> pickImage() async {
    _state = _state.copyWithPicking();
    notifyListeners();

    try {
      final image = await _imageService.pickImage();

      if (image != null) {
        // Update controllers with source image dimensions
        widthController.text = image.width?.toString() ?? '';
        heightController.text = image.height?.toString() ?? '';

        _state = _state.copyWithSourceImage(image);
      } else {
        _state = _state.copyWithIdle();
      }
      notifyListeners();
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  /// Resize the current image
  Future<void> resizeImage() async {
    if (_state.sourceImage == null) {
      _state = _state.copyWithError('No image selected');
      notifyListeners();
      return;
    }

    if (!_state.settings.isValid) {
      _state = _state.copyWithError('Invalid resize dimensions');
      notifyListeners();
      return;
    }

    _state = _state.copyWithResizing();
    notifyListeners();

    try {
      final resized = await _imageService.resizeImage(
        _state.sourceImage!,
        _state.settings,
      );

      _state = _state.copyWithSuccess(resized);
      notifyListeners();

      // Auto-save if enabled
      if (shouldAutoSave) {
        final saved = await _saveResizedImage();
        if (saved) {
          // Update state to indicate successful auto-save
          _state = _state.copyWith(errorMessage: null);
          notifyListeners();
        }
      }
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  void onSaveResizedImage(BuildContext context) async {
    final success = await _saveResizedImage();
    if (context.mounted) {
      if (success) {
        ToastHelper.showSuccess(
          context,
          'Image Saved!',
          subtitle: 'Your resized image has been saved to gallery',
        );
      } else {
        ToastHelper.showError(context, 'Save Failed', subtitle: errorMessage);
      }
    }
  }

  /// Save the resized image
  Future<bool> _saveResizedImage() async {
    if (_state.resizedImage == null) {
      _state = _state.copyWithError('No resized image to save');
      notifyListeners();
      return false;
    }

    try {
      final storageLocation = _sharedPrefProvider.getStorageLocation();
      await _imageService.saveImage(_state.resizedImage!, storageLocation);
      return true;
    } catch (e) {
      _state = _state.copyWithError('Failed to save image: $e');
      notifyListeners();
      return false;
    }
  }

  /// Update resize settings
  void updateSettings(ResizeSettings newSettings) {
    if (_state.settings == newSettings) return;
    _state = _state.copyWith(settings: newSettings);
    notifyListeners();
  }

  /// Update width
  void updateWidth(int? width) {
    if (_state.settings.width == width) return;
    _state = _state.copyWith(settings: _state.settings.copyWith(width: width));
    notifyListeners();
  }

  /// Update height
  void updateHeight(int? height) {
    if (_state.settings.height == height) return;
    _state = _state.copyWith(
      settings: _state.settings.copyWith(height: height),
    );
    notifyListeners();
  }

  /// Toggle aspect ratio lock
  void toggleAspectRatio() {
    _state = _state.copyWith(
      settings: _state.settings.copyWith(
        maintainAspectRatio: !_state.settings.maintainAspectRatio,
      ),
    );
    notifyListeners();
  }

  /// Clear all images
  void clear() {
    widthController.clear();
    heightController.clear();
    _state = _state.copyWithClear();
    notifyListeners();
  }

  /// Reset error state
  void clearError() {
    if (_state.state == ResizeStateType.error) {
      _state = _state.copyWithIdle();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    widthController.removeListener(_onWidthChanged);
    heightController.removeListener(_onHeightChanged);
    widthController.dispose();
    heightController.dispose();
    super.dispose();
  }
}
