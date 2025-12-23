import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/image_format.dart';
import 'package:flutter_image_converters/services/dialog_service.dart';
import '../models/app_settings.dart';
import '../services/storage_service.dart';

/// ViewModel for app settings
class SettingsViewModel extends ChangeNotifier {
  AppSettings _settings = AppSettings();
  final StorageService storageService;
  final DialogService dialogService;

  SettingsViewModel({
    required this.storageService,
    required this.dialogService,
  }) {
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

  /// Get storage location
  String get storageLocation => _settings.storageLocation;

  /// Get app version
  String get version => _settings.version;

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final themeModeIndex = storageService.getInt('themeMode') ?? 0;
    final defaultFormatIndex = storageService.getInt('defaultFormat') ?? 1;
    final defaultQuality = storageService.getInt('defaultQuality') ?? 90;
    final saveToGallery = storageService.getBool('saveToGallery') ?? true;
    final language = storageService.getString('language') ?? 'en';
    final storageLocation =
        storageService.getString('storageLocation') ??
        'Pictures/ImageConverter';

    _settings = AppSettings(
      themeMode: ThemeMode.values[themeModeIndex],
      defaultFormat: ImageFormat.values[defaultFormatIndex],
      defaultQuality: defaultQuality,
      saveToGallery: saveToGallery,
      language: language,
      storageLocation: storageLocation,
    );

    notifyListeners();
  }

  /// Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    await storageService.setInt('themeMode', _settings.themeMode.index);
    await storageService.setInt('defaultFormat', _settings.defaultFormat.index);
    await storageService.setInt('defaultQuality', _settings.defaultQuality);
    await storageService.setBool('saveToGallery', _settings.saveToGallery);
    await storageService.setString('language', _settings.language);
    await storageService.setString(
      'storageLocation',
      _settings.storageLocation,
    );
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

  /// Update storage location
  Future<void> updateStorageLocation(String location) async {
    _settings = _settings.copyWith(storageLocation: location);
    await _saveSettings();
    notifyListeners();
  }

  /// Reset to defaults
  Future<void> resetToDefaults() async {
    _settings = AppSettings();
    await _saveSettings();
    notifyListeners();
  }

  String getLanguageName() {
    const languages = {
      'en': 'English',
      'th': 'ภาษาไทย',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'es': 'Español',
      'fr': 'Français',
      'de': 'Deutsch',
      'pt': 'Português',
      'ru': 'Русский',
    };
    return languages[language] ?? 'English';
  }

  void onShowResetDialog(BuildContext context) {
    dialogService.showResetSettingDialog(context, () {
      resetToDefaults();
    });
  }

  void onShowClearCacheDialog(BuildContext context) {
    dialogService.showClearCacheDialog(context);
  }

  void showLanguageDialog(BuildContext context) {
    dialogService.showLanguageDialog(context, language, (selectedLanguage) {
      updateLanguage(selectedLanguage);
    });
  }

  void showStorageLocationDialog(BuildContext context) {
    dialogService.showStorageLocationDialog(context, storageLocation, (
      selectedLocation,
    ) {
      updateStorageLocation(selectedLocation);
    });
  }
}
