import 'dart:typed_data';
import 'package:flutter/foundation.dart';

/// Memory cache for image thumbnails to reduce re-rendering
class ImageCache {
  static final ImageCache _instance = ImageCache._internal();
  factory ImageCache() => _instance;
  ImageCache._internal();

  final Map<String, Uint8List> _cache = {};
  static const int _maxCacheSize = 50; // Maximum number of cached thumbnails
  final List<String> _accessOrder = []; // LRU tracking

  /// Get cached thumbnail
  Uint8List? get(String key) {
    if (_cache.containsKey(key)) {
      // Move to end (most recently used)
      _accessOrder.remove(key);
      _accessOrder.add(key);
      return _cache[key];
    }
    return null;
  }

  /// Put thumbnail in cache
  void put(String key, Uint8List data) {
    // If cache is full, remove least recently used
    if (_cache.length >= _maxCacheSize && !_cache.containsKey(key)) {
      final lruKey = _accessOrder.first;
      _accessOrder.removeAt(0);
      _cache.remove(lruKey);
    }

    _cache[key] = data;
    _accessOrder.remove(key);
    _accessOrder.add(key);
  }

  /// Clear cache
  void clear() {
    _cache.clear();
    _accessOrder.clear();
  }

  /// Get cache size
  int get size => _cache.length;

  /// Get total memory usage in bytes
  int get memoryUsage {
    return _cache.values.fold(0, (sum, bytes) => sum + bytes.length);
  }
}
