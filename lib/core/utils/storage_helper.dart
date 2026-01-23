import 'dart:io';
import 'package:flutter_image_converters/core/const/app_constants.dart';
import 'package:path_provider/path_provider.dart';

class StorageHelper {
  /// Resolve a user-friendly storage path (e.g., "Pictures/ImageConverter")
  /// to an absolute system path.
  static Future<Directory> resolveDirectory(String saveToPath) async {
    Directory? directory;

    if (saveToPath.startsWith('/')) {
      // Absolute path
      directory = Directory(saveToPath);
    } else {
      // Relative path - resolve against platform defaults
      if (Platform.isAndroid) {
        final externalDir = await getExternalStorageDirectory();

        // Map common public directories to their absolute paths
        if (saveToPath.startsWith(AppConstants.pictures)) {
          directory = Directory(
            '/storage/emulated/0/${AppConstants.pictures}/${AppConstants.folderName}',
          );
        } else if (saveToPath.startsWith(AppConstants.dcim)) {
          directory = Directory(
            '/storage/emulated/0/${AppConstants.dcim}/${AppConstants.folderName}',
          );
        } else if (saveToPath.startsWith(AppConstants.documents)) {
          directory = Directory(
            '/storage/emulated/0/${AppConstants.documents}/${AppConstants.folderName}',
          );
        } else if (saveToPath.startsWith(AppConstants.downloads)) {
          directory = Directory(
            '/storage/emulated/0/${AppConstants.download}/${AppConstants.folderName}',
          );
        } else if (externalDir != null) {
          // Fallback to app-specific external storage for other relative paths
          directory = Directory('${externalDir.path}/$saveToPath');
        }
      } else {
        // iOS and others - use Documents directory
        final docsDir = await getApplicationDocumentsDirectory();
        directory = Directory('${docsDir.path}/$saveToPath');
      }
    }

    // Default fallback if resolution failed
    if (directory == null) {
      if (Platform.isAndroid) {
        directory = Directory(
          '/storage/emulated/0/${AppConstants.pictures}/${AppConstants.folderName}',
        );
      } else {
        final docs = await getApplicationDocumentsDirectory();
        directory = Directory('${docs.path}/${AppConstants.folderName}');
      }
    }

    return directory;
  }
}
