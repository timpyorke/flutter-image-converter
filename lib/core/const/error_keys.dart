/// Error message keys for services (used without context)
/// These should be translated using context.l10n when displayed to users
class ErrorKeys {
  ErrorKeys._();

  static const String failedToPickImage = 'failedToPickImage';
  static const String failedToPickImages = 'failedToPickImages';
  static const String failedToConvertImage = 'failedToConvertImage';
  static const String failedToResizeImage = 'failedToResizeImage';
  static const String failedToSaveImage = 'failedToSaveImage';
  static const String failedToDecodeImage = 'failedToDecodeImage';
  static const String failedToLoadImage = 'failedToLoadImage';
  static const String failedToConvertImages = 'failedToConvertImages';
  static const String failedToGetExternalStorage = 'failedToGetExternalStorage';
  static const String noImageSelected = 'noImageSelected';
  static const String invalidResizeDimensions = 'invalidResizeDimensions';
  static const String noResizedImageToSave = 'noResizedImageToSave';
}

/// Exception with localization key for error messages
class LocalizedException implements Exception {
  final String key;
  final String fallbackMessage;
  final dynamic originalError;

  LocalizedException(this.key, {this.fallbackMessage = '', this.originalError});

  @override
  String toString() =>
      fallbackMessage.isNotEmpty ? fallbackMessage : 'LocalizedException: $key';
}
