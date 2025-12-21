# Flutter Image Converters - MVVM Architecture

## Project Structure

This project follows the MVVM (Model-View-ViewModel) architecture pattern with Provider for state management.

```
lib/
├── models/                    # Data models
│   ├── image_data.dart       # Image data model
│   └── conversion_settings.dart  # Settings models
├── viewmodels/               # Business logic & state management
│   ├── conversion_viewmodel.dart
│   ├── resize_viewmodel.dart
│   └── navigation_viewmodel.dart
├── views/                    # UI Components
│   ├── convert/
│   │   └── convert_view.dart
│   └── resize/
│       └── resize_view.dart
├── services/                 # Business logic services
│   └── image_service.dart
├── pages/                    # Page scaffolds
│   └── home_page.dart
├── app.dart                  # App entry with providers
├── main.dart                 # Main entry point
└── flavors.dart             # App flavors configuration
```

## Architecture Overview

### MVVM Pattern

- **Model**: Data structures and business entities

  - `ImageData`: Represents image metadata and bytes
  - `ConversionSettings`: Configuration for image conversion
  - `ResizeSettings`: Configuration for image resizing

- **View**: UI components that display data and capture user input

  - `ConvertView`: UI for image conversion
  - `ResizeView`: UI for image resizing
  - `HomePage`: Main navigation scaffold

- **ViewModel**: Business logic and state management
  - `ConversionViewModel`: Manages conversion state and operations
  - `ResizeViewModel`: Manages resize state and operations
  - `NavigationViewModel`: Manages navigation state

### Provider State Management

The app uses Provider for dependency injection and state management:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => NavigationViewModel()),
    ChangeNotifierProvider(create: (_) => ConversionViewModel()),
    ChangeNotifierProvider(create: (_) => ResizeViewModel()),
  ],
  child: MaterialApp(...)
)
```

### Service Layer

- **ImageService**: Handles all image-related operations
  - Picking images from gallery
  - Converting images between formats
  - Resizing images
  - Saving images to device

## Features

### Image Conversion

- Convert images between formats: JPG, PNG, WebP, BMP
- Adjustable quality for lossy formats
- Preview before and after conversion
- View image metadata (dimensions, size, format)

### Image Resizing

- Resize images by width and/or height
- Maintain aspect ratio option
- Real-time dimension calculation
- Preview original and resized images

## State Management Flow

1. **User Interaction** → View captures input
2. **View** → Calls ViewModel method
3. **ViewModel** → Uses Service to perform operation
4. **Service** → Processes data (e.g., image conversion)
5. **Service** → Returns result to ViewModel
6. **ViewModel** → Updates state and notifies listeners
7. **View** → Rebuilds with new state via `Consumer<T>`

## Example Usage

### Accessing a ViewModel in a View

```dart
Consumer<ConversionViewModel>(
  builder: (context, viewModel, child) {
    return Column(
      children: [
        if (viewModel.hasSourceImage)
          Image.memory(viewModel.sourceImage!.bytes!),
        ElevatedButton(
          onPressed: viewModel.pickImage,
          child: Text('Pick Image'),
        ),
      ],
    );
  },
)
```

### ViewModel State Pattern

```dart
class ConversionViewModel extends ChangeNotifier {
  ConversionState _state = ConversionState.idle;
  ImageData? _sourceImage;

  Future<void> pickImage() async {
    _setState(ConversionState.picking);
    try {
      final image = await _imageService.pickImage();
      _sourceImage = image;
      _setState(ConversionState.idle);
    } catch (e) {
      _setState(ConversionState.error);
    }
  }

  void _setState(ConversionState newState) {
    _state = newState;
    notifyListeners(); // Triggers UI rebuild
  }
}
```

## Dependencies

- **provider**: State management
- **image_picker**: Pick images from gallery
- **image**: Image processing and conversion
- **flutter_flavorizr**: Multi-flavor support

## Running the App

```bash
# Install dependencies
flutter pub get

# Run in dev flavor
flutter run --flavor dev

# Run in prod flavor
flutter run --flavor prod
```

## Future Enhancements

- [ ] Save images to gallery
- [ ] Batch image processing
- [ ] Image compression
- [ ] Image filters and effects
- [ ] Share functionality
- [ ] History of conversions
- [ ] Settings page for app preferences
