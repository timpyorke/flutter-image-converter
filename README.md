# 📸 Flutter Image Converters

A modern cross-platform Flutter application for converting and resizing images with a beautiful glassmorphism UI, clean MVVM architecture, and Provider state management.

## ✨ Features

### 🎨 Modern UI Design

- **Glassmorphism Effects**: Frosted glass aesthetic with blur effects throughout
- **Material Design 3**: Modern color schemes and typography
- **Dark Mode Support**: Fully implemented light/dark themes with system detection
- **Smooth Animations**: Polished transitions and interactive elements
- **Custom Glass Widgets**: Reusable GlassCard, GlassContainer, and GradientButton components

### Image Conversion

- 📷 **Multi-Select**: Pick multiple images from gallery at once
- 🔄 **Batch Conversion**: Convert multiple images simultaneously with progress tracking
- 📊 **Real-time Progress**: Live updates showing "Converting X/Y..." with visual progress
- 🎯 **Format Support**: Convert between JPG, PNG, WebP, and BMP formats
- 🎚️ **Quality Control**: Adjustable compression quality (1-100%)
- 👁️ **Preview Gallery**: Horizontal scrollable thumbnails with glassmorphic overlays
- 📊 **Metadata Display**: Dimensions, format, and file size for each image
- 🗑️ **Individual Management**: Remove specific images with animated transitions
- ➕ **Add More Images**: Expand selection without losing existing images
- 💾 **Results View**: Before/after size comparison with percentage reduction badges
- 🎬 **Advertisement Dialog**: Glassmorphic ad banner before processing
- 💾 **Auto-Save**: Background processing with automatic file saving to device storage

### Image Resizing

- 📐 **Custom Dimensions**: Precise width and height control
- 🔒 **Aspect Ratio Lock**: Automatic proportion maintenance
- 📏 **Smart Calculation**: Auto-calculate dimensions when locked
- 👁️ **Preview**: Original and resized comparison with metadata
- 💾 **Direct Save**: Save resized images to gallery

### ⚙️ Settings & Preferences

- 🎨 **Theme Switcher**: Light/Dark/System mode with instant updates
- 🌍 **Language Selection**: 10 languages supported (English, Thai, Chinese, Japanese, Korean, Spanish, French, German, Portuguese, Russian)
- 🎯 **Default Settings**: Configurable default output format and quality
- 💾 **Persistent Storage**: All settings saved with SharedPreferences
- 📱 **Auto-save Toggle**: Configure automatic gallery saving
- 🗂️ **Storage Location**: Custom save directory configuration
- 🧹 **Cache Management**: Clear temporary files
- ℹ️ **About Section**: Version info, privacy policy, terms of service

### Architecture

- 🏗️ **MVVM Pattern**: Clean separation of concerns with reactive state
- ⚡ **Provider State Management**: Efficient and scalable
- 🎯 **Use Cases**: Background processing with isolated compute
- 🔧 **Services Layer**: Reusable business logic
- 🎨 **Widget Library**: Custom reusable glassmorphism components
- 📦 **Multi-Flavor Support**: Separate dev and production environments

## 🏗️ Architecture

This project follows **MVVM (Model-View-ViewModel)** architecture with **Provider** for state management.

```
lib/
├── models/              # Data models (ImageData, Settings, etc.)
├── viewmodels/         # Business logic & state (Provider ChangeNotifiers)
├── views/              # UI components (Convert, Resize, Settings)
├── services/           # Business operations (ImageService)
├── usecases/           # Complex workflows (ConvertAndSaveImagesUseCase)
├── widgets/            # Reusable components (GlassCard, GradientButton)
└── pages/              # Page scaffolds (HomePage with navigation)
```

For detailed architecture documentation, see:

- [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture overview and patterns
- [MVVM_IMPLEMENTATION.md](MVVM_IMPLEMENTATION.md) - Implementation details
- [lib/usecases/README.md](lib/usecases/README.md) - Use case patterns

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.10.1`
- Dart SDK: `>=3.10.1`
- iOS development: Xcode 14+ (for iOS/macOS builds)
- Android development: Android Studio with Android SDK 21+

### Installation

1. Clone the repository:

```bash
git clone https://github.com/s-thongphitak/flutter-image-converters.git
cd flutter_image_converters
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

**Development flavor:**

```bash
flutter run --flavor dev -t lib/main_dev.dart
```

**Production flavor:**

```bash
flutter run --flavor prod -t lib/main.dart
```

## 🏗️ Project Structure

```
lib/
├── main.dart                    # Production entry point
├── main_dev.dart                # Development entry point
├── app.dart                     # Root app with theme management
├── flavors.dart                 # Flavor configuration
├── models/                      # Data models
│   ├── image_data.dart         # Image metadata model
│   ├── conversion_settings.dart # Conversion configuration
│   ├── resize_settings.dart    # Resize configuration
│   └── app_settings.dart       # Application settings
├── viewmodels/                  # State management (ChangeNotifiers)
│   ├── navigation_viewmodel.dart
│   ├── conversion_viewmodel.dart
│   ├── resize_viewmodel.dart
│   └── settings_viewmodel.dart
├── views/                       # UI screens
│   ├── convert/
│   │   └── convert_view.dart   # Image conversion UI
│   ├── resize/
│   │   └── resize_view.dart    # Image resizing UI
│   └── settings/
│       └── settings_view.dart  # App settings UI
├── services/                    # Business logic
│   └── image_service.dart      # Image operations
├── usecases/                    # Complex workflows
│   └── convert_and_save_images_usecase.dart
├── widgets/                     # Reusable components
│   └── glass_widgets.dart      # Glassmorphism UI components
└── pages/
    └── home_page.dart          # Main navigation container
```

## 🔧 Configuration

### Flavors

The app supports two flavors for different environments:

| Flavor   | App Name             | Bundle ID                           |
| -------- | -------------------- | ----------------------------------- |
| **dev**  | Image Converters Dev | `com.codenour.image_converters.dev` |
| **prod** | Image Converters     | `com.codenour.image_converters`     |

### Platform Permissions

**iOS** - Add to `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to select images for conversion</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs access to save converted images to your photo library</string>
```

**Android** - Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

## 🛠️ Technology Stack

### Core Dependencies

- `flutter` - Framework
- `provider: ^6.1.2` - State management
- `image_picker: ^1.0.7` - Image selection with multi-select support
- `image: ^4.1.7` - Image format conversion and processing
- `path_provider: ^2.1.2` - File system access
- `permission_handler: ^11.3.0` - Runtime permissions
- `shared_preferences: ^2.2.2` - Settings persistence

### Development Dependencies

- `flutter_flavorizr: ^2.4.1` - Flavor management
- `flutter_lints` - Code quality and style
- `flutter_test` - Unit and widget testing

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ⏳ macOS (coming soon)
- ⏳ Web (coming soon)

## 🎨 UI Components

### Glass Widgets Library

Custom glassmorphism components for modern UI:

- **GlassCard**: Frosted glass container with blur effects
- **GlassContainer**: Smaller glass elements for buttons and chips
- **GradientButton**: Elevated button with gradient and shadow
- **ShimmerLoading**: Animated loading placeholder

### Design System

- **Color Scheme**:
  - Primary: Indigo (#6366F1)
  - Secondary: Purple (#8B5CF6)
  - Tertiary: Cyan (#06B6D4)
- **Typography**: Custom letter spacing and font weights
- **Effects**: Backdrop blur (10-15px), gradient overlays, animated transitions

## 💾 Data Persistence

Settings are automatically saved using SharedPreferences:

- Theme preference (Light/Dark/System)
- Default conversion format
- Default quality setting
- Language preference
- Auto-save preference

## 🚀 Future Enhancements

- 📤 Share functionality
- 🎨 Image filters and effects
- 📝 Conversion history
- ⚡ Parallel conversion optimization
- 🌐 Full internationalization (i18n)
- 📊 Analytics and usage tracking
- ☁️ Cloud storage integration

## 🧪 Testing

Run tests:

```bash
flutter test
```

Run tests with coverage:

```bash
flutter test --coverage
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Code Style

This project follows the official [Flutter style guide](https://docs.flutter.dev/effective-dart/style) and uses `flutter_lints` for code analysis.

Format code:

```bash
flutter format .
```

Analyze code:

```bash
flutter analyze
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Contact

- GitHub: [@s-thongphitak](https://github.com/s-thongphitak)
- Repository: [flutter-image-converters](https://github.com/s-thongphitak/flutter-image-converters)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Image processing community for format conversion libraries
- Contributors and users of this project
