import 'package:flutter_image_converters/services/storage_service.dart';

class SharedPrefProvider {
  final StorageService storageService;
  SharedPrefProvider(this.storageService);

  static const themeModeKey = 'themeMode';

  void setThemeMode(int value) => storageService.setInt(themeModeKey, value);

  int getThemMode() => storageService.getInt(themeModeKey) ?? 0;
}
