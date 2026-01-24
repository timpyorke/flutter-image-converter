import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Request storage permission
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13+ (API 33+), photos permission is sufficient for MediaStore
      final photosStatus = await Permission.photos.status;
      if (photosStatus.isGranted) {
        return true;
      }

      // Request photos permission
      final photosResult = await Permission.photos.request();
      if (photosResult.isGranted) {
        return true;
      }

      // Fallback to storage permission for older Android versions
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) {
        return true;
      }

      final storageResult = await Permission.storage.request();
      return storageResult.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.request();
      return status.isGranted;
    }

    return true; // For other platforms
  }
}
