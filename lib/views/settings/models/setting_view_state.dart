import 'package:flutter_image_converters/models/app_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_view_state.freezed.dart';

/// Represents the state of the settings view
@freezed
class SettingViewState with _$SettingViewState {
  const factory SettingViewState({
    required AppSettings settings,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SettingViewState;

  /// Initial state
  factory SettingViewState.initial() {
    return SettingViewState(settings: AppSettings(), isLoading: true);
  }
}

extension SettingViewStateExtension on SettingViewState {
  /// Loading state
  SettingViewState copyWithLoading() {
    return copyWith(isLoading: true, errorMessage: null);
  }

  /// Success state with updated settings
  SettingViewState copyWithSettings(AppSettings newSettings) {
    return copyWith(
      settings: newSettings,
      isLoading: false,
      errorMessage: null,
    );
  }

  /// Error state
  SettingViewState copyWithError(String error) {
    return copyWith(isLoading: false, errorMessage: error);
  }
}
