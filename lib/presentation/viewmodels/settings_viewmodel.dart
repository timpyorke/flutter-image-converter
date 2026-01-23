import 'package:flutter/material.dart';
import 'package:flutter_image_converters/core/const/image_format.dart';
import 'package:flutter_image_converters/providers/shared_pref_provider.dart';
import 'package:flutter_image_converters/core/services/dialog_service.dart';
import 'package:flutter_image_converters/presentation/views/settings/models/setting_view_state.dart';
import '../models/app_settings.dart';

/// ViewModel for app settings
class SettingsViewModel extends ChangeNotifier {
  SettingViewState _state = SettingViewState.initial();
  final SharedPrefProvider sharedPrefProvider;
  final DialogService dialogService;

  SettingsViewModel({
    required this.sharedPrefProvider,
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

      final themeModeIndex = sharedPrefProvider.getThemeMode();
      final defaultFormatIndex = sharedPrefProvider.getDefaultFormat();
      final defaultQuality = sharedPrefProvider.getDefaultQuality();
      final saveToGallery = sharedPrefProvider.getSaveToGallery();
      final language = sharedPrefProvider.getLanguage();
      final storageLocation = sharedPrefProvider.getStorageLocation();
      final hasSeenTutorial = sharedPrefProvider.getHasSeenTutorial();

      final loadedSettings = AppSettings(
        themeMode: ThemeMode.values[themeModeIndex],
        defaultFormat: ImageFormat.values[defaultFormatIndex],
        defaultQuality: defaultQuality,
        saveToGallery: saveToGallery,
        language: language,
        storageLocation: storageLocation,
        hasSeenTutorial: hasSeenTutorial,
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
      await sharedPrefProvider.setThemeMode(_state.settings.themeMode.index);
      await sharedPrefProvider.setDefaultFormat(
        _state.settings.defaultFormat.index,
      );
      await sharedPrefProvider.setDefaultQuality(
        _state.settings.defaultQuality,
      );
      await sharedPrefProvider.setSaveToGallery(_state.settings.saveToGallery);
      await sharedPrefProvider.setLanguage(_state.settings.language);
      await sharedPrefProvider.setStorageLocation(
        _state.settings.storageLocation,
      );
      await sharedPrefProvider.setHasSeenTutorial(
        _state.settings.hasSeenTutorial,
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

  /// Complete tutorial
  Future<void> completeTutorial() async {
    final updatedSettings = _state.settings.copyWith(hasSeenTutorial: true);
    _state = _state.copyWithSettings(updatedSettings);
    await _saveSettings();
    notifyListeners();
  }
}
