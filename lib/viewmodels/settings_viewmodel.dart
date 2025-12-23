import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/image_format.dart';
import 'package:flutter_image_converters/services/dialog_service.dart';
import 'package:flutter_image_converters/views/settings/models/setting_view_state.dart';
import '../models/app_settings.dart';
import '../services/storage_service.dart';

/// ViewModel for app settings
class SettingsViewModel extends ChangeNotifier {
  SettingViewState _state = SettingViewState.initial();
  final StorageService storageService;
  final DialogService dialogService;

  SettingsViewModel({
    required this.storageService,
    required this.dialogService,
  }) {
    _loadSettings();
  }

  SettingViewState get state => _state;
  AppSettings get settings => _state.settings;
  bool get isLoading => _state.isLoading;
  String? get errorMessage => _state.errorMessage;

  /// Get theme mode
  ThemeMode get themeMode => _state.settings.themeMode;

  /// Get default format
  ImageFormat get defaultFormat => _state.settings.defaultFormat;

  /// Get default quality
  int get defaultQuality => _state.settings.defaultQuality;

  /// Get save to gallery preference
  bool get saveToGallery => _state.settings.saveToGallery;

  /// Get language preference
  String get language => _state.settings.language;

  /// Get storage location
  String get storageLocation => _state.settings.storageLocation;

  /// Get app version
  String get version => _state.settings.version;

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    try {
      _state = _state.copyWithLoading();
      notifyListeners();

      final themeModeIndex = storageService.getInt('themeMode') ?? 0;
      final defaultFormatIndex = storageService.getInt('defaultFormat') ?? 1;
      final defaultQuality = storageService.getInt('defaultQuality') ?? 90;
      final saveToGallery = storageService.getBool('saveToGallery') ?? true;
      final language = storageService.getString('language') ?? 'en';
      final storageLocation =
          storageService.getString('storageLocation') ??
          'Pictures/ImageConverter';

      final loadedSettings = AppSettings(
        themeMode: ThemeMode.values[themeModeIndex],
        defaultFormat: ImageFormat.values[defaultFormatIndex],
        defaultQuality: defaultQuality,
        saveToGallery: saveToGallery,
        language: language,
        storageLocation: storageLocation,
      );

      _state = _state.copyWithSettings(loadedSettings);
      notifyListeners();
    } catch (e) {
      _state = _state.copyWithError('Failed to load settings: $e');
      notifyListeners();
    }
  }

  /// Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    try {
      await storageService.setInt('themeMode', _state.settings.themeMode.index);
      await storageService.setInt(
        'defaultFormat',
        _state.settings.defaultFormat.index,
      );
      await storageService.setInt(
        'defaultQuality',
        _state.settings.defaultQuality,
      );
      await storageService.setBool(
        'saveToGallery',
        _state.settings.saveToGallery,
      );
      await storageService.setString('language', _state.settings.language);
      await storageService.setString(
        'storageLocation',
        _state.settings.storageLocation,
      );
    } catch (e) {
      _state = _state.copyWithError('Failed to save settings: $e');
      notifyListeners();
      rethrow;
    }
  }

  /// Update theme mode
  Future<void> updateThemeMode(ThemeMode mode) async {
    final updatedSettings = _state.settings.copyWith(themeMode: mode);
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }

  /// Update default format
  Future<void> updateDefaultFormat(ImageFormat format) async {
    final updatedSettings = _state.settings.copyWith(defaultFormat: format);
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }

  /// Update default quality
  Future<void> updateDefaultQuality(int quality) async {
    final updatedSettings = _state.settings.copyWith(defaultQuality: quality);
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }

  /// Toggle save to gallery
  Future<void> toggleSaveToGallery() async {
    final updatedSettings = _state.settings.copyWith(
      saveToGallery: !_state.settings.saveToGallery,
    );
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }

  /// Update language
  Future<void> updateLanguage(String languageCode) async {
    final updatedSettings = _state.settings.copyWith(language: languageCode);
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }

  /// Update storage location
  Future<void> updateStorageLocation(String location) async {
    final updatedSettings = _state.settings.copyWith(storageLocation: location);
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }

  /// Reset to defaults
  Future<void> resetToDefaults() async {
    final defaultSettings = AppSettings();
    _state = _state.copyWithSettings(defaultSettings);
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
