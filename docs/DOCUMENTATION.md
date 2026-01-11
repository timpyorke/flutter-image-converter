# 📚 Flutter Image Converter - Complete Documentation

> **Last Updated:** December 25, 2025 | **Version:** 2.0.0

## 📖 Table of Contents

1. [Quick Start](#quick-start)
2. [Architecture](#architecture)
3. [Features](#features)
4. [Localization](#localization)
5. [Development Guide](#development-guide)
6. [Performance](#performance)
7. [Contributing](#contributing)

---

## 🚀 Quick Start

### Prerequisites

- Flutter SDK `>=3.10.1`
- Dart SDK `>=3.10.1`
- Android Studio / Xcode for mobile development

### Installation

```bash
# Clone repository
git clone https://github.com/timpyorke/flutter-image-converter.git
cd flutter_image_converters

# Install dependencies
flutter pub get

# Generate localization files
flutter gen-l10n

# Run app (dev flavor)
flutter run --flavor dev

# Run app (production)
flutter run --flavor prod
```

### Project Structure

```
lib/
├── const/              # Constants (strings, dimensions, error keys)
├── core/              # Core utilities, widgets, DI
│   ├── di/           # Dependency injection setup
│   ├── utils/        # Helpers (toast, cache, etc.)
│   └── widgets/      # Reusable UI components
├── l10n/             # Localization files (10 languages)
├── models/           # Data models with freezed
├── viewmodels/       # State management (ChangeNotifier)
├── views/            # UI screens and widgets
├── services/         # Business logic services
├── usecases/         # Complex workflows
└── providers/        # Data access layer
```

---

## 🏗️ Architecture

### MVVM Pattern with Provider

```
┌─────────────────────────────────────────────────┐
│                    VIEW                         │
│  (Stateless/Stateful Widgets + UI Logic)       │
│                                                 │
│  - Displays UI                                  │
│  - Handles user interactions                    │
│  - Observes ViewModel state with Consumer      │
└────────────┬────────────────────────────────────┘
             │
             │ Uses context.watch<T>() / Consumer<T>
             │
┌────────────▼────────────────────────────────────┐
│                 VIEWMODEL                       │
│       (ChangeNotifier + State)                  │
│                                                 │
│  - Manages UI state                             │
│  - Handles business logic orchestration         │
│  - Notifies view of state changes              │
│  - Uses Services & UseCases                     │
└────────────┬────────────────────────────────────┘
             │
             │ Calls methods
             │
┌────────────▼────────────────────────────────────┐
│            SERVICES & USECASES                  │
│                                                 │
│  Services:  - ImageService                      │
│            - StorageService                     │
│            - DialogService                      │
│                                                 │
│  UseCases:  - ConvertAndSaveImagesUseCase       │
│            - Complex workflows                  │
└────────────┬────────────────────────────────────┘
             │
             │ Accesses
             │
┌────────────▼────────────────────────────────────┐
│                  MODEL                          │
│            (Data Classes)                       │
│                                                 │
│  - ImageData (with freezed)                     │
│  - ConversionSettings                           │
│  - ResizeSettings                               │
└─────────────────────────────────────────────────┘
```

### Key Architectural Decisions

#### 1. **Dependency Injection with GetIt**

```dart
// Setup (service_locator.dart)
void setupServiceLocator() {
  // Singletons
  getIt.registerLazySingleton(() => ImageService());
  getIt.registerLazySingleton(() => StorageService());

  // Factories (new instance each time)
  getIt.registerFactory(() => ConversionViewModel(
    getIt<ImageService>(),
    getIt<SharedPrefProvider>(),
  ));
}

// Usage in Views
final dialogService = getIt<DialogService>();
```

#### 2. **State Management with Provider**

```dart
// ViewModel
class ConversionViewModel extends ChangeNotifier {
  ConversionViewState _state = ConversionViewState.initial();

  void updateState(ConversionViewState newState) {
    _state = newState;
    notifyListeners(); // Trigger UI rebuild
  }
}

// View
Consumer<ConversionViewModel>(
  builder: (context, viewModel, child) {
    // UI rebuilds when viewModel.notifyListeners() is called
    return Text(viewModel.state.message);
  },
)
```

#### 3. **Immutable State with Freezed**

```dart
@freezed
class ConversionViewState with _$ConversionViewState {
  const factory ConversionViewState({
    required ConversionState state,
    required List<ImageData> sourceImages,
    required List<ImageData> convertedImages,
    String? errorMessage,
  }) = _ConversionViewState;

  factory ConversionViewState.initial() => const ConversionViewState(
    state: ConversionState.idle,
    sourceImages: [],
    convertedImages: [],
  );
}

// Usage - immutable updates
_state = _state.copyWith(
  state: ConversionState.converting,
  errorMessage: null,
);
```

#### 4. **Isolate-based Image Processing**

All heavy image operations run in background isolates to prevent UI freezing:

```dart
// ImageProcessingIsolate
static Future<Uint8List> convertImage(params) async {
  return compute(_convertImageSync, params);
}

// Runs in separate isolate - no UI blocking
static Uint8List _convertImageSync(params) {
  final image = img.decodeImage(params.imageBytes);
  // Heavy processing here
  return encodedBytes;
}
```

### Component Responsibilities

| Component     | Responsibility                    | Examples                                |
| ------------- | --------------------------------- | --------------------------------------- |
| **View**      | Display UI, handle user input     | `convert_view.dart`, `resize_view.dart` |
| **ViewModel** | Manage state, coordinate services | `conversion_viewmodel.dart`             |
| **Service**   | Business logic operations         | `ImageService`, `StorageService`        |
| **UseCase**   | Complex workflows                 | `ConvertAndSaveImagesUseCase`           |
| **Model**     | Data structures                   | `ImageData`, `ConversionSettings`       |
| **Provider**  | Data access                       | `SharedPrefProvider`                    |

---

## ✨ Features

### 1. **Image Conversion**

#### Multi-Select & Batch Processing

- Pick multiple images from gallery
- Convert all images simultaneously
- Real-time progress tracking
- Individual image removal
- Add more images during workflow

#### Format Support

- **Input:** JPG, PNG, WebP, BMP, GIF
- **Output:** JPG, PNG, WebP, BMP
- Quality control (1-100%)

#### Implementation

```dart
// Service Layer
class ImageService {
  Future<ImageData> convertImage(
    ImageData sourceImage,
    ConversionSettings settings,
  ) async {
    // Process in isolate
    final convertedBytes = await ImageProcessingIsolate.convertImage(
      ConvertImageParams(
        imageBytes: sourceImage.bytes!,
        targetFormat: settings.targetFormat,
        quality: settings.quality,
      ),
    );

    return sourceImage.copyWith(
      bytes: convertedBytes,
      format: settings.targetFormat.extension,
    );
  }
}

// UseCase Layer (batch operations)
class ConvertAndSaveImagesUseCase {
  Future<List<ImageData>> execute(
    List<ImageData> sourceImages,
    ConversionSettings settings,
    String storageLocation,
  ) async {
    final convertedImages = <ImageData>[];

    for (int i = 0; i < sourceImages.length; i++) {
      // Convert in background
      final converted = await _imageService.convertImage(
        sourceImages[i],
        settings,
      );

      // Save to storage
      await _imageService.saveImage(converted, storageLocation);

      convertedImages.add(converted);

      // Update progress every 10%
      if ((i + 1) % (sourceImages.length ~/ 10) == 0) {
        onProgress?.call(i + 1, sourceImages.length);
      }
    }

    return convertedImages;
  }
}
```

### 2. **Image Resizing**

#### Features

- Custom width & height input
- Aspect ratio lock toggle
- Quick percentage presets (25%, 50%, 75%)
- Real-time dimension calculation
- Preview before save

#### TextEditingController in ViewModel

```dart
class ResizeViewModel extends ChangeNotifier {
  late final TextEditingController widthController;
  late final TextEditingController heightController;

  ResizeViewModel() {
    widthController = TextEditingController();
    heightController = TextEditingController();

    // Auto-update on controller changes
    widthController.addListener(_onWidthChanged);
    heightController.addListener(_onHeightChanged);
  }

  void _onWidthChanged() {
    final width = int.tryParse(widthController.text);
    if (width != null && settings.maintainAspectRatio) {
      // Auto-calculate height
      final newHeight = calculateAspectHeight(width);
      heightController.text = newHeight.toString();
    }
  }

  @override
  void dispose() {
    widthController.dispose();
    heightController.dispose();
    super.dispose();
  }
}
```

### 3. **Settings & Preferences**

#### Theme Management

```dart
enum ThemeType { light, dark, system }

class SettingsViewModel extends ChangeNotifier {
  ThemeType _theme = ThemeType.system;

  void updateTheme(ThemeType theme) {
    _theme = theme;
    _sharedPrefProvider.saveTheme(theme.name);
    notifyListeners();
  }

  ThemeMode get themeMode {
    switch (_theme) {
      case ThemeType.light: return ThemeMode.light;
      case ThemeType.dark: return ThemeMode.dark;
      case ThemeType.system: return ThemeMode.system;
    }
  }
}
```

#### Persistent Storage

All settings saved with SharedPreferences:

- Theme preference
- Default output format
- Default quality level
- Auto-save toggle
- Storage location
- Language preference

### 4. **Custom UI Components**

#### GlassCard

```dart
GlassCard(
  padding: const EdgeInsets.all(20),
  color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
  borderRadius: 20,
  child: // Your content
)
```

#### GradientButton

```dart
GradientButton(
  onPressed: () => doSomething(),
  child: Row(
    children: [
      Icon(Icons.check),
      Text('Confirm'),
    ],
  ),
)
```

---

## 🌍 Localization

### Supported Languages (10)

| Language   | Code | Status      | File         |
| ---------- | ---- | ----------- | ------------ |
| English    | en   | ✅ Complete | `app_en.arb` |
| Thai       | th   | 🔄 Partial  | `app_th.arb` |
| Chinese    | zh   | 🔄 Partial  | `app_zh.arb` |
| Japanese   | ja   | 🔄 Partial  | `app_ja.arb` |
| Korean     | ko   | 🔄 Partial  | `app_ko.arb` |
| Spanish    | es   | 🔄 Partial  | `app_es.arb` |
| German     | de   | 🔄 Partial  | `app_de.arb` |
| French     | fr   | 🔄 Partial  | `app_fr.arb` |
| Portuguese | pt   | 🔄 Partial  | `app_pt.arb` |
| Russian    | ru   | 🔄 Partial  | `app_ru.arb` |

### Usage Patterns

#### In Widgets (with BuildContext)

```dart
import 'package:flutter_image_converters/const/app_strings.dart';

// Use context.l10n extension
Text(context.l10n.errorOccurred)
Text(context.l10n.imageSaved)

// With parameters
Text(context.l10n.converting(3, 10)) // "Converting 3/10..."

// Pluralization
Text(context.l10n.convertNImages(count)) // "1 Image" or "5 Images"
```

#### In Services (without BuildContext)

```dart
import 'package:flutter_image_converters/const/error_keys.dart';

throw LocalizedException(
  ErrorKeys.failedToPickImage,
  fallbackMessage: 'Failed to pick image: $e',
  originalError: e,
);
```

### Adding New Strings

1. **Edit `lib/l10n/app_en.arb`:**

```json
{
  "newKey": "New string value",
  "@newKey": {
    "description": "Description for translators"
  }
}
```

2. **Generate localization files:**

```bash
flutter gen-l10n
```

3. **Use in code:**

```dart
Text(context.l10n.newKey)
```

### Configuration

**l10n.yaml:**

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

**pubspec.yaml:**

```yaml
flutter:
  generate: true
```

---

## 💻 Development Guide

### Code Organization

#### Constants

```dart
// AppStrings - Localized strings access
context.l10n.errorOccurred
context.l10n.imageSaved

// AppDimensions - UI sizing
AppDimensions.paddingL        // 16.0
AppDimensions.spacingM        // 12.0
AppDimensions.radiusL         // 16.0
AppDimensions.iconS           // 20.0

// ErrorKeys - Service error keys
ErrorKeys.failedToPickImage
ErrorKeys.failedToSaveImage
```

#### Naming Conventions

| Type     | Pattern           | Example                  |
| -------- | ----------------- | ------------------------ |
| File     | `snake_case.dart` | `convert_view.dart`      |
| Class    | `PascalCase`      | `ConversionViewModel`    |
| Variable | `camelCase`       | `sourceImages`           |
| Constant | `camelCase`       | `paddingL`               |
| Private  | `_camelCase`      | `_state`                 |
| Boolean  | `is/has/can`      | `isLoading`, `hasImages` |

#### Widget Best Practices

```dart
// ✅ DO: Extract build methods for complex widgets
Widget _buildSourceImageCard(BuildContext context) {
  return GlassCard(
    child: // Complex widget tree
  );
}

// ✅ DO: Use const constructors
const SizedBox(width: AppDimensions.spacingM)

// ✅ DO: Use localization
Text(context.l10n.errorOccurred)

// ❌ DON'T: Hardcode strings
Text('Error Occurred')

// ❌ DON'T: Use magic numbers
const SizedBox(width: 12.0) // Use AppDimensions instead
```

### State Management Patterns

#### ViewModel Structure

```dart
class MyViewModel extends ChangeNotifier {
  // Private state
  MyViewState _state = MyViewState.initial();

  // Public getters
  MyViewState get state => _state;
  bool get isLoading => _state.isLoading;

  // Public methods
  Future<void> doSomething() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      // Business logic
      final result = await _service.process();
      _state = _state.copyWith(
        isLoading: false,
        data: result,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }
}
```

#### View Integration

```dart
class MyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyViewModel>(
      builder: (context, viewModel, child) {
        // Error handling
        if (viewModel.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ToastHelper.showError(
              context,
              context.l10n.errorOccurred,
              subtitle: viewModel.errorMessage,
            );
            viewModel.clearError();
          });
        }

        // Loading state
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Content
        return // Your UI
      },
    );
  }
}
```

### Testing Strategy

#### Unit Tests

```dart
test('ViewModel updates state correctly', () {
  final viewModel = ConversionViewModel(mockService, mockProvider);

  viewModel.updateQuality(85);

  expect(viewModel.settings.quality, 85);
});
```

#### Widget Tests

```dart
testWidgets('ConvertView displays empty state', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => mockViewModel,
        child: ConvertView(),
      ),
    ),
  );

  expect(find.text('Select images to get started'), findsOneWidget);
});
```

---

## ⚡ Performance

### Optimizations Implemented

#### 1. **Isolate-based Processing**

All image operations run in background isolates to prevent UI thread blocking:

- ✅ Image decoding
- ✅ Image encoding
- ✅ Image resizing
- ✅ Thumbnail generation

**Before:** 42+ frames skipped  
**After:** 0 frames skipped

#### 2. **LRU Image Cache**

```dart
class ImageCache {
  final int maxSize = 50;
  final Map<String, Uint8List> _cache = {};
  final List<String> _accessOrder = [];

  Uint8List? get(String key) {
    if (_cache.containsKey(key)) {
      _updateAccessOrder(key);
      return _cache[key];
    }
    return null;
  }

  void put(String key, Uint8List value) {
    if (_cache.length >= maxSize) {
      final oldest = _accessOrder.removeAt(0);
      _cache.remove(oldest);
    }
    _cache[key] = value;
    _accessOrder.add(key);
  }
}
```

#### 3. **Batched NotifyListeners**

Instead of notifying on every image:

```dart
// ❌ Before: 100 notifications for 100 images
for (var image in images) {
  processImage(image);
  notifyListeners(); // UI rebuilds 100 times
}

// ✅ After: 10 notifications (every 10%)
for (int i = 0; i < images.length; i++) {
  processImage(images[i]);
  if ((i + 1) % (images.length ~/ 10) == 0) {
    notifyListeners(); // UI rebuilds 10 times
  }
}
```

#### 4. **AutomaticKeepAliveClientMixin**

Prevents thumbnail widgets from being disposed on scroll:

```dart
class CachedImageThumbnail extends StatefulWidget {
  @override
  State<CachedImageThumbnail> createState() => _CachedImageThumbnailState();
}

class _CachedImageThumbnailState extends State<CachedImageThumbnail>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required
    return // Widget tree
  }
}
```

### Performance Metrics

| Metric          | Before     | After         | Improvement   |
| --------------- | ---------- | ------------- | ------------- |
| Frame drops     | 42+ frames | 0 frames      | 100%          |
| Processing time | UI frozen  | Background    | ∞             |
| Memory          | Uncached   | LRU (50)      | Controlled    |
| Rebuilds        | Per image  | Batched (10%) | 90% reduction |

---

## 🤝 Contributing

### Getting Started

1. **Fork the repository**
2. **Create a feature branch:**

```bash
git checkout -b feature/amazing-feature
```

3. **Make your changes**
4. **Run tests:**

```bash
flutter test
flutter analyze
```

5. **Commit with conventional commits:**

```bash
git commit -m "feat: add amazing feature"
git commit -m "fix: resolve issue with image conversion"
git commit -m "docs: update README"
```

6. **Push and create Pull Request:**

```bash
git push origin feature/amazing-feature
```

### Commit Convention

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Code style (formatting)
- `refactor:` Code refactoring
- `perf:` Performance improvement
- `test:` Tests
- `chore:` Build/tools

### Code Review Checklist

- [ ] Code follows project conventions
- [ ] All tests pass
- [ ] No `flutter analyze` warnings
- [ ] Localized strings used (no hardcoded text)
- [ ] Constants used for dimensions
- [ ] Documentation updated
- [ ] Commit messages follow convention

---

## 📄 License

MIT License - See [LICENSE](../LICENSE) file for details

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and testers
- Open source community

---

**For more detailed information, see the archived docs in `/docs/archive/`**

Last updated: December 25, 2025
