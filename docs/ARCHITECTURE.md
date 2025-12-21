# Flutter Image Converters - MVVM Architecture

## Project Structure

This project follows the MVVM (Model-View-ViewModel) architecture pattern with Provider for state management.

```
lib/
├── models/                    # Data models
│   ├── image_data.dart       # Image metadata model
│   ├── conversion_settings.dart  # Conversion configuration
│   ├── resize_settings.dart  # Resize configuration
│   └── app_settings.dart     # Application settings
├── viewmodels/               # Business logic & state management
│   ├── conversion_viewmodel.dart  # Conversion state & operations
│   ├── resize_viewmodel.dart     # Resize state & operations
│   ├── navigation_viewmodel.dart # Navigation state
│   └── settings_viewmodel.dart   # Settings with persistence
├── views/                    # UI Components
│   ├── convert/
│   │   └── convert_view.dart      # Conversion UI with glassmorphism
│   ├── resize/
│   │   └── resize_view.dart       # Resize UI with glassmorphism
│   └── settings/
│       └── settings_view.dart     # Settings UI
├── services/                 # Business logic services
│   └── image_service.dart        # Image operations
├── usecases/                # Complex workflows
│   └── convert_and_save_images_usecase.dart  # Background processing
├── widgets/                 # Reusable components
│   └── glass_widgets.dart       # Glassmorphism UI library
├── pages/                   # Page scaffolds
│   └── home_page.dart          # Main navigation with glassmorphic nav bar
├── app.dart                 # App entry with providers & theme
├── main.dart                # Main entry point (production)
├── main_dev.dart           # Development entry point
└── flavors.dart            # App flavors configuration
```

## Architecture Overview

### MVVM Pattern

- **Model**: Data structures and business entities

  - `ImageData`: Image metadata (dimensions, format, size, bytes)
  - `ConversionSettings`: Configuration for image conversion
  - `ResizeSettings`: Configuration for image resizing
  - `AppSettings`: Application preferences with persistence

- **View**: UI components that display data and capture user input

  - `ConvertView`: Multi-select conversion UI with glassmorphism
  - `ResizeView`: Image resizing UI with glassmorphism
  - `SettingsView`: Theme, language, and preferences UI
  - `HomePage`: Main navigation with glassmorphic bottom bar

- **ViewModel**: Business logic and state management (ChangeNotifiers)
  - `ConversionViewModel`: Batch conversion state with progress tracking
  - `ResizeViewModel`: Resize operations and state
  - `NavigationViewModel`: Tab navigation state
  - `SettingsViewModel`: Settings with SharedPreferences persistence

### Provider State Management

The app uses Provider for dependency injection and state management:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => NavigationViewModel()),
    ChangeNotifierProvider(create: (_) => ConversionViewModel()),
    ChangeNotifierProvider(create: (_) => ResizeViewModel()),
    ChangeNotifierProvider(create: (_) => SettingsViewModel()),
  ],
  child: Consumer<SettingsViewModel>(
    builder: (context, settingsVM, child) {
      return MaterialApp(
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: settingsVM.themeMode, // Reactive theme switching
        ...
      );
    },
  ),
)
```

### Service Layer

- **ImageService**: Core image operations
  - Single and multi-image picking from gallery
  - Image format conversion (JPG, PNG, WebP, BMP)
  - Image resizing with aspect ratio control
  - Metadata extraction (dimensions, format, size)

### Use Case Layer

- **ConvertAndSaveImagesUseCase**: Complex batch operations
  - Background processing using `compute()` isolates
  - Automatic file saving to device storage
  - Progress tracking callbacks
  - Platform-specific storage paths (Android/iOS)
  - Permission handling

### Widget Library

Custom glassmorphism components:

- **GlassCard**: Frosted glass containers with backdrop blur
- **GlassContainer**: Smaller glass UI elements
- **GradientButton**: Elevated buttons with gradients
- **ShimmerLoading**: Animated loading placeholders

## Features

### Image Conversion

- **Multi-select** from gallery (batch processing)
- **Format conversion**: JPG, PNG, WebP, BMP
- **Quality control**: Adjustable 1-100%
- **Progress tracking**: Real-time "Converting X/Y..."
- **Preview gallery**: Horizontal scroll with thumbnails
- **Metadata display**: Dimensions, format, file size
- **Batch results**: Before/after comparison with size reduction
- **Auto-save**: Background processing with file saving
- **Ad integration**: Glassmorphic dialog before processing

### Image Resizing

- **Custom dimensions**: Precise width/height control
- **Aspect ratio lock**: Automatic proportion maintenance
- **Smart calculation**: Auto-adjust when locked
- **Preview**: Side-by-side comparison
- **Metadata**: Full image information display

### Settings & Preferences

- **Theme modes**: Light, Dark, System with reactive switching
- **Language selection**: 10 languages with native names
- **Default settings**: Format and quality preferences
- **Persistence**: SharedPreferences for all settings
- **Auto-save toggle**: Configure automatic gallery saving
- **Storage management**: Cache clearing

## Design System

### Glassmorphism UI

- **Frosted glass effects**: Backdrop blur with transparency
- **Material Design 3**: Modern color schemes
- **Custom components**: Reusable glass widgets
- **Gradient accents**: Primary/secondary/tertiary colors
- **Smooth animations**: Polished transitions

### Color Palette

- Primary: Indigo (#6366F1)
- Secondary: Purple (#8B5CF6)
- Tertiary: Cyan (#06B6D4)
- Success: Green variations
- Error: Red variations

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
