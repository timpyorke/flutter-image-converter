# 📸 Flutter Image Converters

A cross-platform Flutter application for converting and resizing images between different formats with a clean MVVM architecture and Provider state management.

## ✨ Features

### Image Conversion

- 📷 **Multi-Select**: Pick multiple images from gallery at once
- 🔄 **Batch Conversion**: Convert multiple images simultaneously
- 📊 **Progress Tracking**: Real-time conversion progress (e.g., "Converting 2/5...")
- 🎯 **Format Conversion**: Convert between JPG, PNG, WebP, and BMP formats
- 🎚️ **Quality Control**: Adjust compression quality for lossy formats (1-100%)
- 👁️ **Preview**: View all images in horizontal scrollable list
- 📊 **Metadata Display**: See dimensions, format, and file size for each image
- 🗑️ **Individual Management**: Remove specific images from batch
- ➕ **Add More**: Add additional images to existing selection
- 💾 **Batch Results**: View before/after size comparison for all images

### Image Resizing

- 📐 **Custom Dimensions**: Set width and/or height
- 🔒 **Aspect Ratio Lock**: Maintain proportions automatically
- 📏 **Auto-calculation**: Automatically calculate dimensions when aspect ratio is locked
- 👁️ **Preview**: View original and resized images with comparison

### Architecture

- 🏗️ **MVVM Pattern**: Clean separation of concerns
- ⚡ **Provider State Management**: Reactive and efficient
- 🎨 **Material 3 Design**: Modern UI with dark mode support
- 🎯 **Multi-Flavor Support**: Separate dev and production environments

### Planned Features

- 💾 Save images to gallery
- 📤 Share functionality
- 🎨 Image filters and effects
- 📝 Conversion history
- ⚙️ Settings page
- ⚡ Parallel conversion (multi-threaded)

## 🏗️ Architecture

This project follows **MVVM (Model-View-ViewModel)** architecture with **Provider** for state management.

```
lib/
├── models/              # Data models
├── viewmodels/         # Business logic & state
├── views/              # UI components
├── services/           # Business operations
└── pages/              # Page scaffolds
```

For detailed architecture documentation, see:

- [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture overview and patterns
- [ARCHITECTURE_DIAGRAM.md](ARCHITECTURE_DIAGRAM.md) - Visual diagrams and flows
- [MVVM_IMPLEMENTATION.md](MVVM_IMPLEMENTATION.md) - Implementation details

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
├── main.dart              # Production entry point
├── main_dev.dart          # Development entry point
├── app.dart               # Root app widget
├── flavors.dart           # Flavor configuration
├── pages/                 # UI screens
│   └── my_home_page.dart  # Main screen
├── models/                # Data models (planned)
├── services/              # Business logic (planned)
└── repositories/          # Data layer (planned)
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
<string>We need access to your photo library to select images for conversion</string>
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to capture images for conversion</string>
```

**Android** - Permissions are handled automatically by `image_picker` plugin.

## 🛠️ Technology Stack

### Core Dependencies (Planned)

- `image_picker` - Gallery and camera image selection
- `image` - Image format conversion and processing
- `flutter_riverpod` / `bloc` - State management (TBD)
- `path_provider` - File system access
- `share_plus` - Image sharing functionality

### Development Dependencies

- `flutter_flavorizr` - Flavor management
- `flutter_lints` - Code quality and style
- `flutter_test` - Unit and widget testing

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ⏳ macOS (coming soon)
- ⏳ Web (coming soon)

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
