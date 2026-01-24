import 'package:flutter_image_converters/core/const/conversion_state_type.dart';
import 'package:flutter_image_converters/core/const/image_format.dart';
import 'package:flutter_image_converters/features/convert/models/conversion_settings.dart';
import 'package:flutter_image_converters/data/image_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'convert_view_state.freezed.dart';

/// Represents the state of the conversion view
@freezed
class ConvertViewState with _$ConvertViewState {
  const factory ConvertViewState({
    @Default(ConversionStateType.idle) ConversionStateType state,
    @Default([]) List<ImageData> sourceImages,
    @Default([]) List<ImageData> convertedImages,
    @Default([]) List<String> savedPaths,
    required ConversionSettings settings,
    String? errorMessage,
    @Default(0) int convertedCount,
    @Default(0) int totalCount,
  }) = _ConvertViewState;

  /// Initial state
  factory ConvertViewState.initial() {
    return ConvertViewState(
      state: ConversionStateType.idle,
      settings: ConversionSettings(targetFormat: ImageFormat.png, quality: 90),
    );
  }
}

extension ConvertViewStateExtension on ConvertViewState {
  /// Check if source images exist
  bool get hasSourceImages => sourceImages.isNotEmpty;

  /// Check if converted images exist
  bool get hasConvertedImages => convertedImages.isNotEmpty;

  /// Check if saved images exist
  bool get hasSavedImages => savedPaths.isNotEmpty;

  /// Check if currently loading
  bool get isLoading =>
      state == ConversionStateType.picking ||
      state == ConversionStateType.converting ||
      state == ConversionStateType.saving;

  /// Get conversion progress
  double get progress => totalCount > 0 ? convertedCount / totalCount : 0.0;

  /// Picking state
  ConvertViewState copyWithPicking() {
    return copyWith(state: ConversionStateType.picking, errorMessage: null);
  }

  /// Converting state
  ConvertViewState copyWithConverting() {
    return copyWith(
      state: ConversionStateType.converting,
      errorMessage: null,
      convertedImages: [],
      convertedCount: 0,
      totalCount: sourceImages.length,
    );
  }

  /// Converting and saving state
  ConvertViewState copyWithConvertingAndSaving() {
    return copyWith(
      state: ConversionStateType.converting,
      errorMessage: null,
      convertedImages: [],
      savedPaths: [],
      convertedCount: 0,
      totalCount: sourceImages.length * 2, // Converting + Saving
    );
  }

  /// Saving state
  ConvertViewState copyWithSaving() {
    return copyWith(state: ConversionStateType.saving, errorMessage: null);
  }

  /// Success state
  ConvertViewState copyWithSuccess({
    List<ImageData>? convertedImages,
    List<String>? savedPaths,
    String? errorMessage,
  }) {
    return copyWith(
      state: ConversionStateType.success,
      convertedImages: convertedImages ?? this.convertedImages,
      savedPaths: savedPaths ?? this.savedPaths,
      errorMessage: errorMessage,
      convertedCount: totalCount,
    );
  }

  /// Error state
  ConvertViewState copyWithError(String error) {
    return copyWith(state: ConversionStateType.error, errorMessage: error);
  }

  /// Idle state
  ConvertViewState copyWithIdle() {
    return copyWith(state: ConversionStateType.idle, errorMessage: null);
  }

  /// Source images picked
  ConvertViewState copyWithSourceImages(List<ImageData> images) {
    return copyWith(
      state: ConversionStateType.idle,
      sourceImages: images,
      convertedImages: [],
      convertedCount: 0,
      totalCount: 0,
      errorMessage: null,
    );
  }

  /// Update progress
  ConvertViewState copyWithProgress(int count) {
    return copyWith(convertedCount: count);
  }

  /// Clear all images
  ConvertViewState copyWithClear() {
    return ConvertViewState.initial();
  }

  /// Remove source image at index
  ConvertViewState copyWithRemovedImage(int index) {
    if (index >= 0 && index < sourceImages.length) {
      final newSourceImages = List<ImageData>.from(sourceImages);
      newSourceImages.removeAt(index);

      if (newSourceImages.isEmpty) {
        return ConvertViewState.initial();
      }

      return copyWith(sourceImages: newSourceImages);
    }
    return this;
  }
}
