import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('zh'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Image Converter'**
  String get appTitle;

  /// No description provided for @convert.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convert;

  /// No description provided for @resize.
  ///
  /// In en, this message translates to:
  /// **'Resize'**
  String get resize;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @convertImages.
  ///
  /// In en, this message translates to:
  /// **'Convert Images'**
  String get convertImages;

  /// No description provided for @resizeImage.
  ///
  /// In en, this message translates to:
  /// **'Resize Image'**
  String get resizeImage;

  /// No description provided for @pickImages.
  ///
  /// In en, this message translates to:
  /// **'Pick Images'**
  String get pickImages;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @selectImages.
  ///
  /// In en, this message translates to:
  /// **'Select Images'**
  String get selectImages;

  /// No description provided for @selectImageToResize.
  ///
  /// In en, this message translates to:
  /// **'Select Image to Resize'**
  String get selectImageToResize;

  /// No description provided for @converting.
  ///
  /// In en, this message translates to:
  /// **'Converting {current}/{total}...'**
  String converting(int current, int total);

  /// No description provided for @convertNImages.
  ///
  /// In en, this message translates to:
  /// **'Convert {count, plural, =1{1 Image} other{{count} Images}}'**
  String convertNImages(int count);

  /// No description provided for @saveNImages.
  ///
  /// In en, this message translates to:
  /// **'Save {count, plural, =1{1 Image} other{{count} Images}}'**
  String saveNImages(int count);

  /// No description provided for @conversionComplete.
  ///
  /// In en, this message translates to:
  /// **'Conversion Complete!'**
  String get conversionComplete;

  /// No description provided for @resizeComplete.
  ///
  /// In en, this message translates to:
  /// **'Resize Complete!'**
  String get resizeComplete;

  /// No description provided for @nImagesConvertedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'{count} image(s) converted successfully'**
  String nImagesConvertedSuccessfully(int count);

  /// No description provided for @yourImageResizedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your image has been resized successfully'**
  String get yourImageResizedSuccessfully;

  /// No description provided for @format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get format;

  /// No description provided for @quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get quality;

  /// No description provided for @sourceImages.
  ///
  /// In en, this message translates to:
  /// **'Source Images'**
  String get sourceImages;

  /// No description provided for @sourceImage.
  ///
  /// In en, this message translates to:
  /// **'Source Image'**
  String get sourceImage;

  /// No description provided for @conversionSettings.
  ///
  /// In en, this message translates to:
  /// **'Conversion Settings'**
  String get conversionSettings;

  /// No description provided for @resizeSettings.
  ///
  /// In en, this message translates to:
  /// **'Resize Settings'**
  String get resizeSettings;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @maintainAspectRatio.
  ///
  /// In en, this message translates to:
  /// **'Maintain Aspect Ratio'**
  String get maintainAspectRatio;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @dimensions.
  ///
  /// In en, this message translates to:
  /// **'Dimensions'**
  String get dimensions;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @before.
  ///
  /// In en, this message translates to:
  /// **'Before'**
  String get before;

  /// No description provided for @after.
  ///
  /// In en, this message translates to:
  /// **'After'**
  String get after;

  /// No description provided for @readyToConvert.
  ///
  /// In en, this message translates to:
  /// **'Ready to convert your images?'**
  String get readyToConvert;

  /// No description provided for @thisWillConvertNImages.
  ///
  /// In en, this message translates to:
  /// **'This will convert {count} image(s)'**
  String thisWillConvertNImages(int count);

  /// No description provided for @readyToResize.
  ///
  /// In en, this message translates to:
  /// **'Ready to resize your image?'**
  String get readyToResize;

  /// No description provided for @imageWillBeResized.
  ///
  /// In en, this message translates to:
  /// **'Your image will be resized to the specified dimensions'**
  String get imageWillBeResized;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @advertisement.
  ///
  /// In en, this message translates to:
  /// **'Advertisement'**
  String get advertisement;

  /// No description provided for @adBannerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Ad Banner Placeholder'**
  String get adBannerPlaceholder;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @choosePreferredTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get choosePreferredTheme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @conversionDefaults.
  ///
  /// In en, this message translates to:
  /// **'Conversion Defaults'**
  String get conversionDefaults;

  /// No description provided for @defaultOutputFormat.
  ///
  /// In en, this message translates to:
  /// **'Default Output Format'**
  String get defaultOutputFormat;

  /// No description provided for @defaultQuality.
  ///
  /// In en, this message translates to:
  /// **'Default Quality'**
  String get defaultQuality;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @autoSaveToGallery.
  ///
  /// In en, this message translates to:
  /// **'Auto-save to Gallery'**
  String get autoSaveToGallery;

  /// No description provided for @automaticallySaveConverted.
  ///
  /// In en, this message translates to:
  /// **'Automatically save converted images'**
  String get automaticallySaveConverted;

  /// No description provided for @storageLocation.
  ///
  /// In en, this message translates to:
  /// **'Storage Location'**
  String get storageLocation;

  /// No description provided for @storageLocationPath.
  ///
  /// In en, this message translates to:
  /// **'Pictures/ImageConverter'**
  String get storageLocationPath;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get clearCache;

  /// No description provided for @freeUpStorage.
  ///
  /// In en, this message translates to:
  /// **'Free up storage space'**
  String get freeUpStorage;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @howWeHandleData.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get howWeHandleData;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @appUsageTerms.
  ///
  /// In en, this message translates to:
  /// **'App usage terms'**
  String get appUsageTerms;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// No description provided for @resetSettings.
  ///
  /// In en, this message translates to:
  /// **'Reset Settings?'**
  String get resetSettings;

  /// No description provided for @resetSettingsConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will reset all settings to their default values. This action cannot be undone.'**
  String get resetSettingsConfirm;

  /// No description provided for @settingsResetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Settings reset to defaults'**
  String get settingsResetToDefaults;

  /// No description provided for @clearCacheQuestion.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache?'**
  String get clearCacheQuestion;

  /// No description provided for @clearCacheDescription.
  ///
  /// In en, this message translates to:
  /// **'This will clear temporary files and free up storage space. Your images and settings will not be affected.'**
  String get clearCacheDescription;

  /// No description provided for @cacheClearedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cacheClearedSuccessfully;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageChangedTo.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}'**
  String languageChangedTo(String language);

  /// No description provided for @storageLocationConfigurationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Storage location configuration coming soon!'**
  String get storageLocationConfigurationComingSoon;

  /// No description provided for @privacyPolicyComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy coming soon!'**
  String get privacyPolicyComingSoon;

  /// No description provided for @termsOfServiceComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Terms of service coming soon!'**
  String get termsOfServiceComingSoon;

  /// No description provided for @saveFunctionalityComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Save functionality coming soon!'**
  String get saveFunctionalityComingSoon;

  /// No description provided for @noImagesSelected.
  ///
  /// In en, this message translates to:
  /// **'No images selected'**
  String get noImagesSelected;

  /// No description provided for @pickImageError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get pickImageError;

  /// No description provided for @conversionError.
  ///
  /// In en, this message translates to:
  /// **'Conversion failed'**
  String get conversionError;

  /// No description provided for @resizeError.
  ///
  /// In en, this message translates to:
  /// **'Resize failed'**
  String get resizeError;

  /// No description provided for @convertYourImages.
  ///
  /// In en, this message translates to:
  /// **'Convert Your Images'**
  String get convertYourImages;

  /// No description provided for @selectImagesToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Select multiple images to get started'**
  String get selectImagesToGetStarted;

  /// No description provided for @resizeYourImages.
  ///
  /// In en, this message translates to:
  /// **'Resize Your Images'**
  String get resizeYourImages;

  /// No description provided for @selectAnImageToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Select an image to get started'**
  String get selectAnImageToGetStarted;

  /// No description provided for @savedNImagesSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully saved {count} image(s)!'**
  String savedNImagesSuccessfully(int count);

  /// No description provided for @failedToSaveImages.
  ///
  /// In en, this message translates to:
  /// **'Failed to save images'**
  String get failedToSaveImages;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error Occurred'**
  String get errorOccurred;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image'**
  String get failedToPickImage;

  /// No description provided for @failedToPickImages.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick images'**
  String get failedToPickImages;

  /// No description provided for @failedToConvertImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to convert image'**
  String get failedToConvertImage;

  /// No description provided for @failedToResizeImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to resize image'**
  String get failedToResizeImage;

  /// No description provided for @failedToSaveImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to save image'**
  String get failedToSaveImage;

  /// No description provided for @failedToDecodeImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to decode image'**
  String get failedToDecodeImage;

  /// No description provided for @failedToLoadImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get failedToLoadImage;

  /// No description provided for @failedToConvertImages.
  ///
  /// In en, this message translates to:
  /// **'Failed to convert images'**
  String get failedToConvertImages;

  /// No description provided for @failedToGetExternalStorage.
  ///
  /// In en, this message translates to:
  /// **'Failed to get external storage'**
  String get failedToGetExternalStorage;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @invalidResizeDimensions.
  ///
  /// In en, this message translates to:
  /// **'Invalid resize dimensions'**
  String get invalidResizeDimensions;

  /// No description provided for @noResizedImageToSave.
  ///
  /// In en, this message translates to:
  /// **'No resized image to save'**
  String get noResizedImageToSave;

  /// No description provided for @couldNotSaveImage.
  ///
  /// In en, this message translates to:
  /// **'Could not save image'**
  String get couldNotSaveImage;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save Failed'**
  String get saveFailed;

  /// No description provided for @imageSaved.
  ///
  /// In en, this message translates to:
  /// **'Image Saved!'**
  String get imageSaved;

  /// No description provided for @imagesSaved.
  ///
  /// In en, this message translates to:
  /// **'Images Saved!'**
  String get imagesSaved;

  /// No description provided for @imagesConvertedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your images have been converted successfully'**
  String get imagesConvertedSuccessfully;

  /// No description provided for @imageSavedToGallery.
  ///
  /// In en, this message translates to:
  /// **'Your image has been saved to gallery'**
  String get imageSavedToGallery;

  /// No description provided for @imagesSavedToGallery.
  ///
  /// In en, this message translates to:
  /// **'Your images have been saved to gallery'**
  String get imagesSavedToGallery;

  /// No description provided for @imageResizedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your image has been resized successfully'**
  String get imageResizedSuccessfully;

  /// No description provided for @resizedImageSavedToGallery.
  ///
  /// In en, this message translates to:
  /// **'Your resized image has been saved to gallery'**
  String get resizedImageSavedToGallery;

  /// No description provided for @selectFormat.
  ///
  /// In en, this message translates to:
  /// **'Select Format'**
  String get selectFormat;

  /// No description provided for @higher.
  ///
  /// In en, this message translates to:
  /// **'Higher'**
  String get higher;

  /// No description provided for @smaller.
  ///
  /// In en, this message translates to:
  /// **'Smaller'**
  String get smaller;

  /// No description provided for @reduceByPercent.
  ///
  /// In en, this message translates to:
  /// **'Reduce by %'**
  String get reduceByPercent;

  /// No description provided for @pixels.
  ///
  /// In en, this message translates to:
  /// **'px'**
  String get pixels;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache Cleared'**
  String get cacheCleared;

  /// No description provided for @cacheClearedMessage.
  ///
  /// In en, this message translates to:
  /// **'Temporary files have been cleared'**
  String get cacheClearedMessage;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Privacy Matters'**
  String get privacyTitle;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'All image processing is done locally on your device. Your images never leave your device and are not uploaded to any servers or third parties.'**
  String get privacyDescription;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ko',
    'pt',
    'ru',
    'th',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
