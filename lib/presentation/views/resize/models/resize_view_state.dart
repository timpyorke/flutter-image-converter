import 'package:flutter_image_converters/core/const/resize_state_type.dart';
import 'package:flutter_image_converters/presentation/models/image_data.dart';
import 'package:flutter_image_converters/presentation/models/resize_setting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resize_view_state.freezed.dart';

/// Represents the state of the resize view
@freezed
class ResizeViewState with _$ResizeViewState {
  const factory ResizeViewState({
    @Default(ResizeStateType.idle) ResizeStateType state,
    ImageData? sourceImage,
    ImageData? resizedImage,
    required ResizeSettings settings,
    String? errorMessage,
  }) = _ResizeViewState;

  /// Initial state
  factory ResizeViewState.initial() {
    return ResizeViewState(
      state: ResizeStateType.idle,
      settings: ResizeSettings(
        width: null,
        height: null,
        maintainAspectRatio: true,
      ),
    );
  }
}

extension ResizeViewStateExtension on ResizeViewState {
  /// Check if source image exists
  bool get hasSourceImage => sourceImage != null;

  /// Check if resized image exists
  bool get hasResizedImage => resizedImage != null;

  /// Check if currently loading
  bool get isLoading =>
      state == ResizeStateType.picking || state == ResizeStateType.resizing;

  /// Check if can resize (has source and valid settings)
  bool get canResize => sourceImage != null && settings.isValid;

  /// Picking state
  ResizeViewState copyWithPicking() {
    return copyWith(state: ResizeStateType.picking, errorMessage: null);
  }

  /// Resizing state
  ResizeViewState copyWithResizing() {
    return copyWith(state: ResizeStateType.resizing, errorMessage: null);
  }

  /// Success state with resized image
  ResizeViewState copyWithSuccess(ImageData resizedImage) {
    return copyWith(
      state: ResizeStateType.success,
      resizedImage: resizedImage,
      errorMessage: null,
    );
  }

  /// Error state
  ResizeViewState copyWithError(String error) {
    return copyWith(state: ResizeStateType.error, errorMessage: error);
  }

  /// Idle state
  ResizeViewState copyWithIdle() {
    return copyWith(state: ResizeStateType.idle, errorMessage: null);
  }

  /// Source image picked
  ResizeViewState copyWithSourceImage(ImageData image) {
    return copyWith(
      state: ResizeStateType.idle,
      sourceImage: image,
      resizedImage: null,
      settings: ResizeSettings(
        width: image.width,
        height: image.height,
        maintainAspectRatio: true,
      ),
      errorMessage: null,
    );
  }

  /// Clear all images
  ResizeViewState copyWithClear() {
    return ResizeViewState.initial();
  }
}
