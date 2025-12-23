import 'package:flutter_image_converters/services/storage_service.dart';

class SharedPrefProvider {
  final StorageService storageService;
  SharedPrefProvider(this.storageService);

  // Keys
  static const themeModeKey = 'themeMode';
  static const defaultFormatKey = 'defaultFormat';
  static const defaultQualityKey = 'defaultQuality';
  static const saveToGalleryKey = 'saveToGallery';
  static const languageKey = 'language';
  static const storageLocationKey = 'storageLocation';

  // Theme Mode
  Future<void> setThemeMode(int value) =>
      storageService.setInt(themeModeKey, value);
  int getThemeMode() => storageService.getInt(themeModeKey) ?? 0;

  // Default Format
  Future<void> setDefaultFormat(int value) =>
      storageService.setInt(defaultFormatKey, value);
  int getDefaultFormat() => storageService.getInt(defaultFormatKey) ?? 1;

  // Default Quality
  Future<void> setDefaultQuality(int value) =>
      storageService.setInt(defaultQualityKey, value);
  int getDefaultQuality() => storageService.getInt(defaultQualityKey) ?? 90;

  // Save to Gallery
  Future<void> setSaveToGallery(bool value) =>
      storageService.setBool(saveToGalleryKey, value);
  bool getSaveToGallery() => storageService.getBool(saveToGalleryKey) ?? true;

  // Language
  Future<void> setLanguage(String value) =>
      storageService.setString(languageKey, value);
  String getLanguage() => storageService.getString(languageKey) ?? 'en';

  // Storage Location
  Future<void> setStorageLocation(String value) =>
      storageService.setString(storageLocationKey, value);
  String getStorageLocation() =>
      storageService.getString(storageLocationKey) ?? 'Pictures/ImageConverter';
}
