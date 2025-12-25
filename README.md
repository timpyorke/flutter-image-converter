# 📸 Flutter Image Converter

> A modern, high-performance Flutter app for image conversion and resizing with beautiful glassmorphism UI, MVVM architecture, and support for 10 languages.

[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.10.1-blue)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 🌟 Highlights

- 🎨 **Glassmorphism UI** - Beautiful frosted glass design
- ⚡ **High Performance** - Isolate-based processing, zero UI blocking
- 🌍 **10 Languages** - Full localization support
- 📱 **Cross-platform** - Android, iOS ready
- 🏗️ **Clean Architecture** - MVVM + Provider pattern
- 🎯 **Batch Processing** - Convert multiple images simultaneously

## ✨ Core Features

### 📷 Image Conversion

- Multi-select gallery picker
- Batch conversion with real-time progress
- Formats: JPG, PNG, WebP, BMP
- Quality control (1-100%)
- Before/after comparison

### 📐 Image Resizing

- Custom width & height
- Aspect ratio lock
- Quick presets (25%, 50%, 75%)
- Real-time preview

### ⚙️ Settings

- Theme: Light/Dark/System
- Language selection (10 languages)
- Auto-save configuration
- Cache management

## 🚀 Quick Start

```bash
# Clone & install
git clone https://github.com/timpyorke/flutter-image-converter.git
cd flutter_image_converters
flutter pub get

# Generate localization
flutter gen-l10n

# Run (dev mode)
flutter run --flavor dev -t lib/main_dev.dart

# Run (production)
flutter run --flavor prod -t lib/main.dart
```

## 📚 Documentation

**[📖 Complete Documentation](DOCUMENTATION.md)** - Comprehensive guide covering:

- Architecture & Design Patterns
- Features & Implementation
- Localization Guide
- Development Guide
- Performance Optimizations
- Contributing Guidelines

**Additional Resources:**

- [Localization Guide](docs/LOCALIZATION_GUIDE.md) - Detailed l10n implementation
- [Archived Docs](docs/archive/) - Historical implementation details

## 🏗️ Architecture

```
┌──────────┐
│   View   │ ← Stateless/StatefulWidget
└────┬─────┘
     │ Consumer<T>
┌────▼──────────┐
│  ViewModel    │ ← ChangeNotifier + State
└────┬──────────┘
     │ Uses
┌────▼──────────┐
│    Service    │ ← Business Logic
└────┬──────────┘
     │ Accesses
┌────▼──────────┐
│    Model      │ ← Data Classes (Freezed)
└───────────────┘
```

**Key Technologies:**

- **State Management:** Provider + ChangeNotifier
- **DI:** GetIt
- **Immutability:** Freezed
- **Localization:** Flutter l10n (ARB)
- **Performance:** Isolate-based processing

## 📁 Project Structure

```
lib/
├── const/              # Constants (strings, dimensions, errors)
├── core/
│   ├── di/            # Dependency injection
│   ├── utils/         # Helpers & utilities
│   └── widgets/       # Reusable UI components
├── l10n/              # Localization (10 languages)
├── models/            # Data models (Freezed)
├── viewmodels/        # State management
├── views/             # UI screens
├── services/          # Business logic
├── usecases/          # Complex workflows
└── providers/         # Data access
```

## 🌍 Supported Languages

English • Thai • Chinese • Japanese • Korean • Spanish • German • French • Portuguese • Russian

Change language in Settings → Language Selection

## ⚡ Performance

| Optimization         | Impact             |
| -------------------- | ------------------ |
| Isolate Processing   | 0 frame drops      |
| LRU Cache (50 items) | Faster thumbnails  |
| Batched Updates      | 90% fewer rebuilds |
| AutoKeepAlive        | No scroll lag      |

## 📦 Dependencies

```yaml
flutter: ">=3.10.1"
provider: ^6.1.2 # State management
get_it: ^9.2.0 # Dependency injection
freezed: ^2.4.7 # Immutable models
image: ^4.1.7 # Image processing
image_picker: ^1.0.7 # Gallery picker
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing`
3. Commit changes: `git commit -m 'feat: add amazing'`
4. Push: `git push origin feature/amazing`
5. Open Pull Request

**Guidelines:**

- Follow Flutter/Dart conventions
- Use localization (no hardcoded strings)
- Add tests for new features
- Update documentation

## 📄 License

MIT License - see [LICENSE](LICENSE) file

## 🙏 Acknowledgments

- Flutter Team
- Open Source Community
- All Contributors

---
