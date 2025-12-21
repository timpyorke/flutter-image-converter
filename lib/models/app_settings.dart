import 'package:flutter/material.dart';

/// Application settings model
class AppSettings {
  final ThemeMode themeMode;
  final ImageFormat defaultFormat;
  final int defaultQuality;
  final bool saveToGallery;
  final String language;
  final String version;

  AppSettings({
    this.themeMode = ThemeMode.system,
    this.defaultFormat = ImageFormat.png,
    this.defaultQuality = 90,
    this.saveToGallery = true,
    this.language = 'en',
    this.version = '1.0.0',
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    ImageFormat? defaultFormat,
    int? defaultQuality,
    bool? saveToGallery,
    String? language,
    String? version,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      defaultFormat: defaultFormat ?? this.defaultFormat,
      defaultQuality: defaultQuality ?? this.defaultQuality,
      saveToGallery: saveToGallery ?? this.saveToGallery,
      language: language ?? this.language,
      version: version ?? this.version,
    );
  }
}

enum ImageFormat { jpg, png, webp, bmp }
