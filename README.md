# 📸 Flutter Image Converter

> A modern, high-performance Flutter app for image conversion and resizing with a beautiful glassmorphism UI.

[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.10.1-blue)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## ✨ Features

- **🎨 Glassmorphism UI**: Beautiful frosted glass design with modern aesthetics.
- **⚡ High Performance**: Isolate-based image processing prevents UI blocking.
- **🌍 Localization**: Support for 10 languages (English, Thai, Chinese, Japanese, Korean, etc.).
- **🏗️ Clean Architecture**: Built with MVVM + Provider pattern.
- **📷 Image Tools**:
  - Batch conversion (JPG, PNG, WebP, BMP, HEIC/HEIF).
  - Resizing with aspect ratio control and presets.
  - Quality compression.

## 🚀 Quick Start

```bash
# 1. Clone & Install
git clone https://github.com/timpyorke/flutter-image-converter.git
cd flutter_image_converters
flutter pub get

# 2. Generate Code (Localization & Freezed)
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs

# 3. Run
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```

## � Project Structure

```
lib/
├── core/                  # Core functionality
│   ├── config/            # Themes, routes
│   ├── const/             # Constants
│   ├── di/                # Dependency injection (GetIt)
│   ├── services/          # Infrastructure services (Storage, Image)
│   ├── usecases/          # Business logic use cases
│   └── utils/             # Helper classes
├── l10n/                  # Localization files
├── presentation/          # UI Layer
│   ├── models/            # UI specific models
│   ├── pages/             # Main screens
│   ├── viewmodels/        # State management (ChangeNotifier)
│   └── views/             # Widget components
├── providers/             # Global providers
├── main_dev.dart          # Development entry point
└── main_prod.dart         # Production entry point
```

## �️ Tech Stack

- **Flutter**: UI Toolkit
- **Provider**: State Management
- **GetIt**: Dependency Injection
- **Freezed**: Immutable Data Models
- **Flutter Localizations**: Internationalization

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
