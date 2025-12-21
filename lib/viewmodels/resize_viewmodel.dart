import 'package:flutter/foundation.dart';
import 'package:flutter_image_converters/models/resize_setting.dart';
import '../models/image_data.dart';
import '../services/image_service.dart';

enum ResizeState { idle, picking, resizing, success, error }

/// ViewModel for Image Resize operations
class ResizeViewModel extends ChangeNotifier {
  final ImageService _imageService;

  ResizeViewModel({ImageService? imageService})
    : _imageService = imageService ?? ImageService();

  // State
  ResizeState _state = ResizeState.idle;
  ImageData? _sourceImage;
  ImageData? _resizedImage;
  ResizeSettings _settings = ResizeSettings(
    width: null,
    height: null,
    maintainAspectRatio: true,
  );
  String? _errorMessage;

  // Getters
  ResizeState get state => _state;
  ImageData? get sourceImage => _sourceImage;
  ImageData? get resizedImage => _resizedImage;
  ResizeSettings get settings => _settings;
  String? get errorMessage => _errorMessage;
  bool get hasSourceImage => _sourceImage != null;
  bool get hasResizedImage => _resizedImage != null;
  bool get isLoading =>
      _state == ResizeState.picking || _state == ResizeState.resizing;
  bool get canResize => _sourceImage != null && _settings.isValid;

  /// Pick an image from gallery
  Future<void> pickImage() async {
    _setState(ResizeState.picking);
    _errorMessage = null;

    try {
      final image = await _imageService.pickImage();

      if (image != null) {
        _sourceImage = image;
        _resizedImage = null; // Reset resized image
        // Set default dimensions
        _settings = ResizeSettings(
          width: image.width,
          height: image.height,
          maintainAspectRatio: true,
        );
        _setState(ResizeState.idle);
      } else {
        _setState(ResizeState.idle);
      }
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ResizeState.error);
    }
  }

  /// Resize the current image
  Future<void> resizeImage() async {
    if (_sourceImage == null) {
      _errorMessage = 'No image selected';
      _setState(ResizeState.error);
      return;
    }

    if (!_settings.isValid) {
      _errorMessage = 'Invalid resize dimensions';
      _setState(ResizeState.error);
      return;
    }

    _setState(ResizeState.resizing);
    _errorMessage = null;

    try {
      final resized = await _imageService.resizeImage(_sourceImage!, _settings);

      _resizedImage = resized;
      _setState(ResizeState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ResizeState.error);
    }
  }

  /// Update resize settings
  void updateSettings(ResizeSettings newSettings) {
    _settings = newSettings;
    notifyListeners();
  }

  /// Update width
  void updateWidth(int? width) {
    _settings = _settings.copyWith(width: width);
    notifyListeners();
  }

  /// Update height
  void updateHeight(int? height) {
    _settings = _settings.copyWith(height: height);
    notifyListeners();
  }

  /// Toggle aspect ratio lock
  void toggleAspectRatio() {
    _settings = _settings.copyWith(
      maintainAspectRatio: !_settings.maintainAspectRatio,
    );
    notifyListeners();
  }

  /// Clear all images
  void clear() {
    _sourceImage = null;
    _resizedImage = null;
    _errorMessage = null;
    _settings = ResizeSettings(
      width: null,
      height: null,
      maintainAspectRatio: true,
    );
    _setState(ResizeState.idle);
  }

  /// Reset error state
  void clearError() {
    _errorMessage = null;
    if (_state == ResizeState.error) {
      _setState(ResizeState.idle);
    }
  }

  void _setState(ResizeState newState) {
    _state = newState;
    notifyListeners();
  }
}
