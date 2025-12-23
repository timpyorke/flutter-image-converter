import 'package:flutter/foundation.dart';
import 'package:flutter_image_converters/const/resize_state_type.dart';
import 'package:flutter_image_converters/models/resize_setting.dart';
import 'package:flutter_image_converters/views/resize/models/resize_view_state.dart';
import '../models/image_data.dart';
import '../services/image_service.dart';

/// ViewModel for Image Resize operations
class ResizeViewModel extends ChangeNotifier {
  final ImageService _imageService;

  ResizeViewModel({required ImageService imageService})
    : _imageService = imageService;

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

  /// Pick an image from gallery
  Future<void> pickImage() async {
    _state = _state.copyWithPicking();
    notifyListeners();

    try {
      final image = await _imageService.pickImage();

      if (image != null) {
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
    } catch (e) {
      _state = _state.copyWithError(e.toString());
      notifyListeners();
    }
  }

  /// Update resize settings
  void updateSettings(ResizeSettings newSettings) {
    _state = _state.copyWith(settings: newSettings);
    notifyListeners();
  }

  /// Update width
  void updateWidth(int? width) {
    _state = _state.copyWith(settings: _state.settings.copyWith(width: width));
    notifyListeners();
  }

  /// Update height
  void updateHeight(int? height) {
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
}
