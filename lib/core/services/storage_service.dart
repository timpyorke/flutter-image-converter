import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing local storage using SharedPreferences
class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _prefs;

  StorageService._();

  /// Get singleton instance
  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      await _instance!._init();
    }
    return _instance!;
  }

  /// Initialize SharedPreferences
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get integer value
  int? getInt(String key) => _prefs?.getInt(key);

  /// Set integer value
  Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Get string value
  String? getString(String key) => _prefs?.getString(key);

  /// Set string value
  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Get boolean value
  bool? getBool(String key) => _prefs?.getBool(key);

  /// Set boolean value
  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Get double value
  double? getDouble(String key) => _prefs?.getDouble(key);

  /// Set double value
  Future<bool> setDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value) ?? false;
  }

  /// Get string list value
  List<String>? getStringList(String key) => _prefs?.getStringList(key);

  /// Set string list value
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value) ?? false;
  }

  /// Remove a key
  Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clear all data
  Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  /// Check if key exists
  bool containsKey(String key) => _prefs?.containsKey(key) ?? false;

  /// Get all keys
  Set<String> getKeys() => _prefs?.getKeys() ?? {};
}
