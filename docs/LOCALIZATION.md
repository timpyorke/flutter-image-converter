# Localization Guide

## Overview

This project uses Flutter's official internationalization (intl) package to support multiple languages.

## Supported Languages

Currently, the app supports **10 languages** with full translations:

- 🇬🇧 **English** (`en`) - Default
- 🇹🇭 **Thai** (`th`)
- 🇨🇳 **Chinese** (`zh`)
- 🇯🇵 **Japanese** (`ja`)
- 🇰🇷 **Korean** (`ko`)
- 🇪🇸 **Spanish** (`es`)
- 🇫🇷 **French** (`fr`)
- 🇩🇪 **German** (`de`)
- 🇵🇹 **Portuguese** (`pt`)
- 🇷🇺 **Russian** (`ru`)

## Configuration Files

### `l10n.yaml`

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

### Translation Files

- `lib/l10n/app_en.arb` - English (template)
- `lib/l10n/app_th.arb` - Thai
- `lib/l10n/app_zh.arb` - Chinese
- `lib/l10n/app_ja.arb` - Japanese
- `lib/l10n/app_ko.arb` - Korean
- `lib/l10n/app_es.arb` - Spanish
- `lib/l10n/app_fr.arb` - French
- `lib/l10n/app_de.arb` - German
- `lib/l10n/app_pt.arb` - Portuguese
- `lib/l10n/app_ru.arb` - Russian

## Adding a New Language

### Step 1: Create ARB File

Create a new `.arb` file in `lib/l10n/` following the naming convention `app_<locale>.arb`:

```json
{
  "@@locale": "es",
  "appTitle": "Convertidor de Imágenes",
  "convert": "Convertir",
  ...
}
```

### Step 2: Add to Supported Locales

Update `lib/app.dart` to include the new locale:

```dart
supportedLocales: const [
  Locale('en'), // English
  Locale('th'), // Thai
  Locale('zh'), // Chinese
  Locale('ja'), // Japanese
  Locale('ko'), // Korean
  Locale('es'), // Spanish
  Locale('fr'), // French
  Locale('de'), // German
  Locale('pt'), // Portuguese
  Locale('ru'), // Russian
  Locale('xx'), // Your New Language (NEW)
],
```

### Step 3: Run Code Generation

```bash
flutter pub get
```

Flutter will automatically generate localization code based on ARB files.

## Using Localizations in Code

### Basic Usage

```dart
import 'package:flutter_image_converters/l10n/app_localizations.dart';

// In build method:
final l10n = AppLocalizations.of(context)!;

Text(l10n.convert)
Text(l10n.settings)
```

### Placeholders

Some strings use placeholders for dynamic content:

```dart
// Converting {current}/{total}...
l10n.converting(current: 1, total: 5)  // "Converting 1/5..."

// {count} image(s) converted successfully
l10n.nImagesConvertedSuccessfully(count: 3)  // "3 images converted successfully"

// Language changed to {language}
l10n.languageChangedTo(language: 'English')  // "Language changed to English"
```

### Plurals

The ARB files use ICU message format for pluralization:

```json
"convertNImages": "Convert {count, plural, =1{1 Image} other{{count} Images}}"
```

## Available String Keys

### Navigation

- `convert`, `resize`, `settings`

### Actions

- `pickImages`, `selectImage`, `selectImages`
- `cancel`, `continueAction`, `save`, `clear`, `reset`

### Labels

- `format`, `quality`, `width`, `height`
- `name`, `dimensions`, `size`, `before`, `after`

### Sections

- `appearance`, `conversionDefaults`, `storage`, `advanced`, `about`
- `theme`, `language`, `defaultOutputFormat`, `defaultQuality`

### Theme Options

- `light`, `dark`, `system`

### Messages

- `conversionComplete`, `resizeComplete`
- `noImagesSelected`, `pickImageError`
- `conversionError`, `resizeError`

See `lib/l10n/app_en.arb` for the complete list of available strings.

## Changing Language

Users can change the app language from:
**Settings → Advanced → Language**

The selected language is persisted using SharedPreferences and will be restored on app restart.

## Development Tips

1. **Always use `l10n` strings**: Never hardcode UI strings in widgets
2. **Test both languages**: Switch between English and Thai to ensure proper layout
3. **Handle long text**: Some languages (like German) have longer words
4. **Use context**: Get `AppLocalizations.of(context)!` in build methods
5. **Hot reload**: Language changes require app restart

## Troubleshooting

### "AppLocalizations not found"

- Run `flutter pub get` to generate localization files
- Check that `generate: true` is in `pubspec.yaml`
- Verify ARB files have correct format

### Language not switching

- Ensure locale is added to `supportedLocales` in `app.dart`
- Check that ARB file exists for the locale
- Verify app is restarted after changing language

### Missing translations

- Check console for missing key warnings
- Ensure all keys in template ARB are in translation ARB
- Use English fallback for missing translations

## File Structure

```
lib/
├── l10n/
│   ├── app_en.arb           # English translations (template)
│   ├── app_th.arb           # Thai translations
│   └── app_localizations.dart  # Auto-generated (DO NOT EDIT)
├── app.dart                 # LocalizationsDelegates configuration
└── views/
    └── settings/
        └── settings_view.dart  # Language selector UI
l10n.yaml                    # Localization configuration
```

## Resources

- [Flutter Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [ICU Message Format](https://unicode-org.github.io/icu/userguide/format_parse/messages/)
- [ARB File Format](https://github.com/google/app-resource-bundle)
