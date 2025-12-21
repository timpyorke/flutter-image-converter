import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/image_format.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

/// ViewModel for app settings
class SettingsViewModel extends ChangeNotifier {
  AppSettings _settings = AppSettings();
  SharedPreferences? _prefs;

  SettingsViewModel() {
    _loadSettings();
  }

  AppSettings get settings => _settings;

  /// Get theme mode
  ThemeMode get themeMode => _settings.themeMode;

  /// Get default format
  ImageFormat get defaultFormat => _settings.defaultFormat;

  /// Get default quality
  int get defaultQuality => _settings.defaultQuality;

  /// Get save to gallery preference
  bool get saveToGallery => _settings.saveToGallery;

  /// Get language preference
  String get language => _settings.language;

  /// Get app version
  String get version => _settings.version;

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();

    final themeModeIndex = _prefs?.getInt('themeMode') ?? 0;
    final defaultFormatIndex = _prefs?.getInt('defaultFormat') ?? 1;
    final defaultQuality = _prefs?.getInt('defaultQuality') ?? 90;
    final saveToGallery = _prefs?.getBool('saveToGallery') ?? true;
    final language = _prefs?.getString('language') ?? 'en';

    _settings = AppSettings(
      themeMode: ThemeMode.values[themeModeIndex],
      defaultFormat: ImageFormat.values[defaultFormatIndex],
      defaultQuality: defaultQuality,
      saveToGallery: saveToGallery,
      language: language,
    );

    notifyListeners();
  }

  /// Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    await _prefs?.setInt('themeMode', _settings.themeMode.index);
    await _prefs?.setInt('defaultFormat', _settings.defaultFormat.index);
    await _prefs?.setInt('defaultQuality', _settings.defaultQuality);
    await _prefs?.setBool('saveToGallery', _settings.saveToGallery);
    await _prefs?.setString('language', _settings.language);
  }

  /// Update theme mode
  Future<void> updateThemeMode(ThemeMode mode) async {
    _settings = _settings.copyWith(themeMode: mode);
    await _saveSettings();
    notifyListeners();
  }

  /// Update default format
  Future<void> updateDefaultFormat(ImageFormat format) async {
    _settings = _settings.copyWith(defaultFormat: format);
    await _saveSettings();
    notifyListeners();
  }

  /// Update default quality
  Future<void> updateDefaultQuality(int quality) async {
    _settings = _settings.copyWith(defaultQuality: quality);
    await _saveSettings();
    notifyListeners();
  }

  /// Toggle save to gallery
  Future<void> toggleSaveToGallery() async {
    _settings = _settings.copyWith(saveToGallery: !_settings.saveToGallery);
    await _saveSettings();
    notifyListeners();
  }

  /// Update language
  Future<void> updateLanguage(String languageCode) async {
    _settings = _settings.copyWith(language: languageCode);
    await _saveSettings();
    notifyListeners();
  }

  /// Reset to defaults
  Future<void> resetToDefaults() async {
    _settings = AppSettings();
    await _saveSettings();
    notifyListeners();
  }
}
