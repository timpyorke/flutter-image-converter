import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/image_format.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// Application settings model
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(ImageFormat.png) ImageFormat defaultFormat,
    @Default(90) int defaultQuality,
    @Default(true) bool saveToGallery,
    @Default('en') String language,
    @Default('1.0.0') String version,
    @Default('Pictures/ImageConverter') String storageLocation,
    @Default(false) bool hasSeenTutorial,
  }) = _AppSettings;
}
