import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// Extension to access localized strings via context
/// Usage: context.l10n.errorOccurred or context.strings.errorOccurred
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  AppLocalizations get strings => AppLocalizations.of(this)!;
}

/// Application-wide string constants (deprecated - use context.l10n instead)
/// This class is kept for backward compatibility during migration
@Deprecated('Use context.l10n or context.strings instead')
class AppStrings {
  AppStrings._();

  // Common
  static const String appName = 'Image Converter';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String delete = 'Delete';
  static const String save = 'Save';
  static const String clear = 'Clear';
  static const String close = 'Close';
  static const String done = 'Done';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String warning = 'Warning';
  static const String info = 'Info';
  static const String continueText = 'Continue';
  static const String back = 'Back';
  static const String next = 'Next';

  // Errors
  static const String errorOccurred = 'Error Occurred';
  static const String failedToPickImage = 'Failed to pick image';
  static const String failedToPickImages = 'Failed to pick images';
  static const String failedToConvertImage = 'Failed to convert image';
  static const String failedToResizeImage = 'Failed to resize image';
  static const String failedToSaveImage = 'Failed to save image';
  static const String failedToDecodeImage = 'Failed to decode image';
  static const String failedToLoadImage = 'Failed to load image';
  static const String failedToConvertImages = 'Failed to convert images';
  static const String failedToGetExternalStorage =
      'Failed to get external storage';
  static const String noImageSelected = 'No image selected';
  static const String invalidResizeDimensions = 'Invalid resize dimensions';
  static const String noResizedImageToSave = 'No resized image to save';
  static const String couldNotSaveImage = 'Could not save image';
  static const String saveFailed = 'Save Failed';

  // Success messages
  static const String imageSaved = 'Image Saved!';
  static const String imagesSaved = 'Images Saved!';
  static const String resizeComplete = 'Resize Complete!';
  static const String conversionComplete = 'Conversion Complete!';

  // Toast messages
  static const String imageSavedToGallery =
      'Your image has been saved to gallery';
  static const String imagesSavedToGallery =
      'Your images have been saved to gallery';
  static const String imageResizedSuccessfully =
      'Your image has been resized successfully';
  static const String imagesConvertedSuccessfully =
      'Your images have been converted successfully';
  static const String resizedImageSavedToGallery =
      'Your resized image has been saved to gallery';

  // Convert View
  static const String convertYourImages = 'Convert Your Images';
  static const String selectImagesToGetStarted = 'Select images to get started';
  static const String convertImages = 'Convert Images';
  static const String sourceImages = 'Source Images';
  static const String conversionSettings = 'Conversion Settings';
  static const String selectFormat = 'Select Format';
  static const String quality = 'Quality';
  static const String higher = 'Higher';
  static const String smaller = 'Smaller';

  // Resize View
  static const String resizeYourImages = 'Resize Your Images';
  static const String selectAnImageToGetStarted =
      'Select an image to get started';
  static const String resizeImage = 'Resize Image';
  static const String sourceImage = 'Source Image';
  static const String resizeSettings = 'Resize Settings';
  static const String maintainAspectRatio = 'Maintain Aspect Ratio';
  static const String reduceByPercent = 'Reduce by %';
  static const String width = 'Width';
  static const String height = 'Height';
  static const String reset = 'Reset';
  static const String pixels = 'px';

  // Settings View
  static const String settings = 'Settings';
  static const String appearance = 'Appearance';
  static const String theme = 'Theme';
  static const String system = 'System';
  static const String light = 'Light';
  static const String dark = 'Dark';
  static const String storage = 'Storage';
  static const String autoSaveToGallery = 'Auto-save to Gallery';
  static const String autoSaveDescription =
      'Automatically save images after processing';
  static const String storageLocation = 'Storage Location';
  static const String storageLocationDescription =
      'Choose where to save your images';
  static const String clearCache = 'Clear Cache';
  static const String clearCacheDescription =
      'Free up space by clearing temporary files';
  static const String about = 'About';
  static const String version = 'Version';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsOfService = 'Terms of Service';

  // Dialog messages
  static const String clearCacheTitle = 'Clear Cache?';
  static const String clearCacheMessage =
      'This will clear temporary files and free up storage space. Your images and settings will not be affected.';
  static const String cacheCleared = 'Cache Cleared';
  static const String cacheClearedMessage = 'Temporary files have been cleared';
  static const String readyToConvert = 'Ready to convert your images?';
  static const String readyToResize = 'Ready to resize your image?';
  static const String imageWillBeResized =
      'Your image will be resized to the specified dimensions';

  // Privacy & Legal
  static const String privacyTitle = 'Your Privacy Matters';
  static const String privacyDescription =
      'All image processing is done locally on your device. Your images never leave your device and are not uploaded to any servers or third parties.';

  // Image info
  static const String format = 'Format';
  static const String size = 'Size';
  static const String dimensions = 'Dimensions';

  // Navigation
  static const String convert = 'Convert';
  static const String resize = 'Resize';
}
