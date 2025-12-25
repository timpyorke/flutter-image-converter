# Localization Implementation Guide

## 📁 Project Structure

```
lib/
├── l10n/
│   ├── app_en.arb              # English (template)
│   ├── app_th.arb              # Thai
│   ├── app_zh.arb              # Chinese
│   ├── app_ja.arb              # Japanese
│   ├── app_ko.arb              # Korean
│   ├── app_es.arb              # Spanish
│   ├── app_de.arb              # German
│   ├── app_fr.arb              # French
│   ├── app_pt.arb              # Portuguese
│   ├── app_ru.arb              # Russian
│   └── app_localizations.dart  # Generated
├── const/
│   ├── app_strings.dart        # BuildContext extension for l10n
│   ├── error_keys.dart         # Error keys for services
│   └── app_dimensions.dart     # UI dimensions
```

## 🎯 Usage Patterns

### 1. **In Widgets with BuildContext**

Use the `context.l10n` extension:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_image_converters/const/app_strings.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.errorOccurred);
    // or
    return Text(context.strings.errorOccurred);
  }
}
```

### 2. **In Services (without BuildContext)**

Use `LocalizedException` with error keys:

```dart
import 'package:flutter_image_converters/const/error_keys.dart';

class ImageService {
  Future<void> pickImage() async {
    try {
      // ... operation
    } catch (e) {
      throw LocalizedException(
        ErrorKeys.failedToPickImage,
        fallbackMessage: 'Failed to pick image: $e',
        originalError: e,
      );
    }
  }
}
```

### 3. **Displaying Errors in UI**

```dart
if (viewModel.errorMessage != null) {
  ToastHelper.showError(
    context,
    context.l10n.errorOccurred,
    subtitle: viewModel.errorMessage,
  );
}
```

### 4. **Pluralization**

```dart
Text(context.l10n.convertNImages(imageCount))
// Displays: "Convert 1 Image" or "Convert 3 Images"
```

### 5. **With Parameters**

```dart
Text(context.l10n.converting(current, total))
// Displays: "Converting 3/10..."
```

## 📝 Adding New Strings

### Step 1: Add to English ARB (template)

Edit `lib/l10n/app_en.arb`:

```json
{
  "newStringKey": "New String Value",
  "@newStringKey": {
    "description": "Description for translators"
  }
}
```

### Step 2: Generate Localization Files

```bash
flutter gen-l10n
```

### Step 3: Use in Code

```dart
Text(context.l10n.newStringKey)
```

## 🌍 Supported Languages

| Language   | Code | File       | Status      |
| ---------- | ---- | ---------- | ----------- |
| English    | en   | app_en.arb | ✅ Complete |
| Thai       | th   | app_th.arb | 🔄 Partial  |
| Chinese    | zh   | app_zh.arb | 🔄 Partial  |
| Japanese   | ja   | app_ja.arb | 🔄 Partial  |
| Korean     | ko   | app_ko.arb | 🔄 Partial  |
| Spanish    | es   | app_es.arb | 🔄 Partial  |
| German     | de   | app_de.arb | 🔄 Partial  |
| French     | fr   | app_fr.arb | 🔄 Partial  |
| Portuguese | pt   | app_pt.arb | 🔄 Partial  |
| Russian    | ru   | app_ru.arb | 🔄 Partial  |

## 🔧 Configuration Files

### l10n.yaml

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

### pubspec.yaml

```yaml
flutter:
  generate: true
```

## 🎨 Best Practices

### ✅ DO:

1. **Use context.l10n in widgets**

   ```dart
   Text(context.l10n.errorOccurred)
   ```

2. **Use descriptive keys**

   ```dart
   "failedToPickImage" // ✅ Good
   "error1"            // ❌ Bad
   ```

3. **Provide descriptions in ARB**

   ```json
   "@errorOccurred": {
     "description": "Generic error message shown to user"
   }
   ```

4. **Use LocalizedException for service errors**
   ```dart
   throw LocalizedException(
     ErrorKeys.failedToSaveImage,
     fallbackMessage: 'Failed to save image: $e',
   );
   ```

### ❌ DON'T:

1. **Don't hardcode strings**

   ```dart
   Text('Error Occurred') // ❌ Bad
   ```

2. **Don't use AppStrings in new code**

   ```dart
   Text(AppStrings.errorOccurred) // ❌ Deprecated
   ```

3. **Don't try to use context.l10n in services**
   ```dart
   // ❌ Services don't have BuildContext
   class MyService {
     void doSomething(BuildContext context) {
       // Bad practice - services shouldn't take context
     }
   }
   ```

## 🔄 Migration Status

### ✅ Completed:

- ✅ ResizeView using context.l10n
- ✅ ConvertView using context.l10n
- ✅ ImageService using LocalizedException
- ✅ ImageProcessingIsolate using standard exceptions
- ✅ BuildContext extension created
- ✅ Error keys system implemented

### 🔄 To Do:

- 🔄 Translate all strings to other languages
- 🔄 Update widget components
- 🔄 Update dialog texts
- 🔄 Update settings view
- 🔄 Update ViewModels error handling

## 🧪 Testing Localization

### Change Language at Runtime

```dart
MaterialApp(
  locale: const Locale('th'), // Force Thai
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
);
```

### Test with Different Locales

```bash
# Run app in Thai
flutter run --locale=th

# Run app in Japanese
flutter run --locale=ja
```

## 📊 Translation Progress

Run this to see translation status:

```bash
flutter gen-l10n
```

Output will show untranslated messages per language.

## 🚀 Quick Reference

```dart
// ✅ In Widgets
context.l10n.errorOccurred
context.l10n.imageSaved
context.l10n.convertNImages(count)

// ✅ In Services
throw LocalizedException(ErrorKeys.failedToPickImage)

// ✅ Error Display
ToastHelper.showError(context, context.l10n.errorOccurred)

// ❌ Deprecated (don't use)
AppStrings.errorOccurred
```

## 📚 Resources

- [Flutter Internationalization Guide](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization)
- [ARB File Format](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification)
- [ICU Message Format](https://unicode-org.github.io/icu/userguide/format_parse/messages/)

---

**Last Updated:** December 25, 2025  
**Current Version:** 1.0.0
