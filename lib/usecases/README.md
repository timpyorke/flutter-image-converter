# Use Cases

This directory contains use case implementations that orchestrate business logic across multiple services.

## ConvertAndSaveImagesUseCase

Handles background image conversion and automatic file saving to device storage.

### Features

- **Background Processing**: Uses Flutter's `compute` to process images in a separate isolate
- **Progress Tracking**: Provides real-time progress updates via callback
- **Batch Operations**: Converts and saves multiple images efficiently
- **Platform-Aware Storage**: Automatically handles Android and iOS storage differences
- **Permission Management**: Requests and manages storage permissions
- **Error Handling**: Continues processing even if individual images fail

### Usage

```dart
final useCase = ConvertAndSaveImagesUseCase(
  imageService: ImageService(),
);

final result = await useCase.execute(
  sourceImages: images,
  settings: ConversionSettings(
    targetFormat: ImageFormat.png,
    quality: 90,
  ),
  onProgress: (current, total) {
    print('Progress: $current/$total');
  },
);

print('Saved ${result.successCount} images');
print('Failed ${result.failedCount} images');
```

### Storage Locations

- **Android**: `/storage/emulated/0/Pictures/ImageConverter/`
- **iOS**: Application Documents Directory

### Permissions Required

#### Android (AndroidManifest.xml)

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

#### iOS (Info.plist)

```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs access to save converted images to your photo library</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to select images for conversion</string>
```

### Integration with ViewModel

The use case is injected into `ConversionViewModel`:

```dart
final viewModel = ConversionViewModel(
  imageService: ImageService(),
  convertAndSaveUseCase: ConvertAndSaveImagesUseCase(
    imageService: ImageService(),
  ),
);

// Convert and save images
await viewModel.convertAndSaveImages();

// Check results
if (viewModel.hasSavedImages) {
  print('Saved to: ${viewModel.savedPaths}');
}
```

### Result Structure

```dart
class ConvertAndSaveResult {
  final List<ImageData> convertedImages;  // All converted images
  final List<String> savedPaths;          // File paths where images were saved
  final int successCount;                 // Number of successfully saved images
  final int failedCount;                  // Number of failed saves

  bool get hasFailures;                   // Whether any saves failed
  int get totalProcessed;                 // Total images processed
}
```
