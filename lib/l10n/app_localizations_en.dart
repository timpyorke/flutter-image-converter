// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Image Converter';

  @override
  String get convert => 'Convert';

  @override
  String get resize => 'Resize';

  @override
  String get settings => 'Settings';

  @override
  String get loading => 'Loading...';

  @override
  String get convertImages => 'Convert Images';

  @override
  String get resizeImage => 'Resize Image';

  @override
  String get pickImages => 'Pick Images';

  @override
  String get selectImage => 'Select Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get selectImageToResize => 'Select Image to Resize';

  @override
  String converting(int current, int total) {
    return 'Converting $current/$total...';
  }

  @override
  String convertNImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Images',
      one: '1 Image',
    );
    return 'Convert $_temp0';
  }

  @override
  String saveNImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Images',
      one: '1 Image',
    );
    return 'Save $_temp0';
  }

  @override
  String get conversionComplete => 'Conversion Complete!';

  @override
  String get resizeComplete => 'Resize Complete!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count image(s) converted successfully';
  }

  @override
  String get yourImageResizedSuccessfully =>
      'Your image has been resized successfully';

  @override
  String get format => 'Format';

  @override
  String get quality => 'Quality';

  @override
  String get sourceImages => 'Source Images';

  @override
  String get sourceImage => 'Source Image';

  @override
  String get conversionSettings => 'Conversion Settings';

  @override
  String get resizeSettings => 'Resize Settings';

  @override
  String get width => 'Width';

  @override
  String get height => 'Height';

  @override
  String get maintainAspectRatio => 'Maintain Aspect Ratio';

  @override
  String get name => 'Name';

  @override
  String get dimensions => 'Dimensions';

  @override
  String get size => 'Size';

  @override
  String get before => 'Before';

  @override
  String get after => 'After';

  @override
  String get readyToConvert => 'Ready to convert your images?';

  @override
  String thisWillConvertNImages(int count) {
    return 'This will convert $count image(s)';
  }

  @override
  String get readyToResize => 'Ready to resize your image?';

  @override
  String get imageWillBeResized =>
      'Your image will be resized to the specified dimensions';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueAction => 'Continue';

  @override
  String get save => 'Save';

  @override
  String get clear => 'Clear';

  @override
  String get reset => 'Reset';

  @override
  String get advertisement => 'Advertisement';

  @override
  String get adBannerPlaceholder => 'Ad Banner Placeholder';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get choosePreferredTheme => 'Choose your preferred theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get conversionDefaults => 'Conversion Defaults';

  @override
  String get defaultOutputFormat => 'Default Output Format';

  @override
  String get defaultQuality => 'Default Quality';

  @override
  String get storage => 'Storage';

  @override
  String get autoSaveToGallery => 'Auto-save to Gallery';

  @override
  String get automaticallySaveConverted =>
      'Automatically save converted images';

  @override
  String get storageLocation => 'Storage Location';

  @override
  String get storageLocationPath => 'Pictures/ImageConverter';

  @override
  String get advanced => 'Advanced';

  @override
  String get language => 'Language';

  @override
  String get clearCache => 'Clear Cache';

  @override
  String get freeUpStorage => 'Free up storage space';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get latest => 'Latest';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get howWeHandleData => 'How we handle your data';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get appUsageTerms => 'App usage terms';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get resetSettings => 'Reset Settings?';

  @override
  String get resetSettingsConfirm =>
      'This will reset all settings to their default values. This action cannot be undone.';

  @override
  String get settingsResetToDefaults => 'Settings reset to defaults';

  @override
  String get clearCacheQuestion => 'Clear Cache?';

  @override
  String get clearCacheDescription =>
      'Free up space by clearing temporary files';

  @override
  String get cacheClearedSuccessfully => 'Cache cleared successfully';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String languageChangedTo(String language) {
    return 'Language changed to $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      'Storage location configuration coming soon!';

  @override
  String get privacyPolicyComingSoon => 'Privacy policy coming soon!';

  @override
  String get termsOfServiceComingSoon => 'Terms of service coming soon!';

  @override
  String get saveFunctionalityComingSoon => 'Save functionality coming soon!';

  @override
  String get noImagesSelected => 'No images selected';

  @override
  String get pickImageError => 'Failed to pick image';

  @override
  String get conversionError => 'Conversion failed';

  @override
  String get resizeError => 'Resize failed';

  @override
  String get convertYourImages => 'Convert Your Images';

  @override
  String get selectImagesToGetStarted =>
      'Select multiple images to get started';

  @override
  String get resizeYourImages => 'Resize Your Images';

  @override
  String get selectAnImageToGetStarted => 'Select an image to get started';

  @override
  String savedNImagesSuccessfully(int count) {
    return 'Successfully saved $count image(s)!';
  }

  @override
  String get failedToSaveImages => 'Failed to save images';

  @override
  String get errorOccurred => 'Error Occurred';

  @override
  String get failedToPickImage => 'Failed to pick image';

  @override
  String get failedToPickImages => 'Failed to pick images';

  @override
  String get failedToConvertImage => 'Failed to convert image';

  @override
  String get failedToResizeImage => 'Failed to resize image';

  @override
  String get failedToSaveImage => 'Failed to save image';

  @override
  String get failedToDecodeImage => 'Failed to decode image';

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String get failedToConvertImages => 'Failed to convert images';

  @override
  String get failedToGetExternalStorage => 'Failed to get external storage';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get invalidResizeDimensions => 'Invalid resize dimensions';

  @override
  String get noResizedImageToSave => 'No resized image to save';

  @override
  String get couldNotSaveImage => 'Could not save image';

  @override
  String get saveFailed => 'Save Failed';

  @override
  String get imageSaved => 'Image Saved!';

  @override
  String get imagesSaved => 'Images Saved!';

  @override
  String get imagesConvertedSuccessfully =>
      'Your images have been converted successfully';

  @override
  String get imageSavedToGallery => 'Your image has been saved to gallery';

  @override
  String get imagesSavedToGallery => 'Your images have been saved to gallery';

  @override
  String get imageResizedSuccessfully =>
      'Your image has been resized successfully';

  @override
  String get resizedImageSavedToGallery =>
      'Your resized image has been saved to gallery';

  @override
  String get selectFormat => 'Select Format';

  @override
  String get higher => 'Higher';

  @override
  String get smaller => 'Smaller';

  @override
  String get reduceByPercent => 'Reduce by %';

  @override
  String get max => 'Max';

  @override
  String get targetFormat => 'Target Format';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get pixels => 'px';

  @override
  String get cacheCleared => 'Cache Cleared';

  @override
  String get cacheClearedMessage => 'Temporary files have been cleared';

  @override
  String get privacyTitle => 'Your Privacy Matters';

  @override
  String get privacyDescription =>
      'All image processing is done locally on your device. Your images never leave your device and are not uploaded to any servers or third parties.';

  @override
  String get ok => 'OK';

  @override
  String get confirm => 'Confirm';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get done => 'Done';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Info';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get processing => 'Processing...';

  @override
  String get processingImages => 'Processing Images...';

  @override
  String processingNImages(int current, int total) {
    return 'Processing $current of $total...';
  }

  @override
  String get convertingInBackground => 'Converting in background...';

  @override
  String get resizingInBackground => 'Resizing in background...';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String convertedNImagesSuccessfully(int count) {
    return 'Successfully converted $count image(s)!';
  }

  @override
  String get allImagesProcessed => 'All images processed successfully!';

  @override
  String get tutorialWelcomeTitle => 'Welcome to Image Converter';

  @override
  String get tutorialWelcomeDescription =>
      'The all-in-one tool to convert and resize your images effortlessly. Let\'s get started!';

  @override
  String get tutorialConvertTitle => 'Convert Images Easily';

  @override
  String get tutorialConvertDescription =>
      'Transform your photos into different formats like PNG, JPG, and WEBP with just a few taps.';

  @override
  String get tutorialResizeTitle => 'Resize with Precision';

  @override
  String get tutorialResizeDescription =>
      'Adjust image dimensions while maintaining quality. Perfect for social media and storage optimization.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get failedToLoadSettings => 'Failed to load settings';

  @override
  String get failedToSaveSettings => 'Failed to save settings';

  @override
  String get addMore => 'Add more';

  @override
  String get clearAll => 'Clear all';

  @override
  String get selected => 'selected';

  @override
  String get storageLocationDescription => 'Choose where to save your images';

  @override
  String get storageLocationTitle => 'Storage Location';

  @override
  String get chooseStorageLocation => 'Choose where to save converted images';

  @override
  String get storageLocationUpdatedTo => 'Storage location updated to';

  @override
  String get privacyPolicyDescription => 'How we handle your data';

  @override
  String get termsOfServiceDescription => 'App usage terms';

  @override
  String get clearCacheDialogDescription =>
      'This will clear temporary files and free up storage space. Your images and settings will not be affected.';

  @override
  String get sourceImageBytesNull => 'Source image bytes are null';

  @override
  String get noImageDataToSave => 'No image data to save';

  @override
  String get noImageDataForThumbnail => 'No image data for thumbnail';

  @override
  String get resetSettingsDescription =>
      'This will reset all settings to their default values. This action cannot be undone.';
}
