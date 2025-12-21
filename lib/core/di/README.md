# Dependency Injection

This project uses **GetIt** for dependency injection to manage dependencies and improve testability.

## Architecture

### Service Locator Pattern

The `service_locator.dart` file contains all dependency registrations using the GetIt package.

### Registration Types

1. **Singleton**: Single instance shared across the app

   - `StorageService` - Async singleton (waits for initialization)
   - `ImageService` - Lazy singleton (created on first use)

2. **Factory**: New instance created each time
   - All ViewModels (for Provider integration)
   - All UseCases

## Setup

Dependencies are initialized in `main.dart` before the app starts:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await setupDependencyInjection();

  runApp(const App());
}
```

## Usage

### In ViewModels

ViewModels receive dependencies through constructor injection:

```dart
class ConversionViewModel extends ChangeNotifier {
  final ImageService _imageService;
  final ConvertAndSaveImagesUseCase _convertAndSaveUseCase;

  ConversionViewModel({
    required ImageService imageService,
    required ConvertAndSaveImagesUseCase convertAndSaveUseCase,
  }) : _imageService = imageService,
       _convertAndSaveUseCase = convertAndSaveUseCase;
}
```

### In App Initialization

The app retrieves ViewModels from the service locator:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => getIt<NavigationViewModel>()),
    ChangeNotifierProvider(create: (_) => getIt<ConversionViewModel>()),
    // ...
  ],
)
```

## Benefits

1. **Testability**: Easy to mock dependencies in unit tests
2. **Maintainability**: Clear dependency graph and single source of truth
3. **Flexibility**: Easy to swap implementations
4. **Lifecycle Management**: Proper initialization order and singleton management

## Adding New Dependencies

1. Register the dependency in `service_locator.dart`:

   ```dart
   getIt.registerLazySingleton<MyService>(() => MyService());
   ```

2. Inject it into consumers:

   ```dart
   class MyViewModel extends ChangeNotifier {
     final MyService _myService;

     MyViewModel({required MyService myService})
       : _myService = myService;
   }
   ```

3. Update the factory registration:
   ```dart
   getIt.registerFactory<MyViewModel>(
     () => MyViewModel(myService: getIt<MyService>()),
   );
   ```
