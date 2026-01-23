// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Конвертер Изображений';

  @override
  String get convert => 'Конвертировать';

  @override
  String get resize => 'Изменить размер';

  @override
  String get settings => 'Настройки';

  @override
  String get loading => 'Загрузка...';

  @override
  String get convertImages => 'Конвертировать Изображения';

  @override
  String get resizeImage => 'Изменить Размер Изображения';

  @override
  String get pickImages => 'Выбрать Изображения';

  @override
  String get selectImage => 'Выбрать Изображение';

  @override
  String get selectImages => 'Выбрать Изображения';

  @override
  String get selectImageToResize =>
      'Выберите изображение для изменения размера';

  @override
  String converting(int current, int total) {
    return 'Конвертация $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return 'Конвертировать $count изображений';
  }

  @override
  String saveNImages(int count) {
    return 'Сохранить $count изображений';
  }

  @override
  String get conversionComplete => 'Конвертация Завершена!';

  @override
  String get resizeComplete => 'Изменение Размера Завершено!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return 'Успешно конвертировано $count изображений';
  }

  @override
  String get yourImageResizedSuccessfully =>
      'Размер вашего изображения успешно изменен';

  @override
  String get format => 'Формат';

  @override
  String get quality => 'Качество';

  @override
  String get sourceImages => 'Исходные Изображения';

  @override
  String get sourceImage => 'Исходное Изображение';

  @override
  String get conversionSettings => 'Настройки Конвертации';

  @override
  String get resizeSettings => 'Настройки Изменения Размера';

  @override
  String get width => 'Ширина';

  @override
  String get height => 'Высота';

  @override
  String get maintainAspectRatio => 'Сохранить Пропорции';

  @override
  String get name => 'Имя';

  @override
  String get dimensions => 'Размеры';

  @override
  String get size => 'Размер';

  @override
  String get before => 'До';

  @override
  String get after => 'После';

  @override
  String get readyToConvert => 'Готовы конвертировать ваши изображения?';

  @override
  String thisWillConvertNImages(int count) {
    return 'Это конвертирует $count изображений';
  }

  @override
  String get readyToResize => 'Готовы изменить размер вашего изображения?';

  @override
  String get imageWillBeResized =>
      'Размер вашего изображения будет изменен до указанных размеров';

  @override
  String get cancel => 'Отмена';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get save => 'Сохранить';

  @override
  String get clear => 'Очистить';

  @override
  String get reset => 'Сбросить';

  @override
  String get advertisement => 'Реклама';

  @override
  String get adBannerPlaceholder => 'Место для Рекламного Баннера';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get theme => 'Тема';

  @override
  String get choosePreferredTheme => 'Выберите предпочитаемую тему';

  @override
  String get light => 'Светлая';

  @override
  String get dark => 'Темная';

  @override
  String get system => 'Системная';

  @override
  String get conversionDefaults => 'Настройки Конвертации по Умолчанию';

  @override
  String get defaultOutputFormat => 'Формат Вывода по Умолчанию';

  @override
  String get defaultQuality => 'Качество по Умолчанию';

  @override
  String get storage => 'Хранилище';

  @override
  String get autoSaveToGallery => 'Автосохранение в Галерею';

  @override
  String get automaticallySaveConverted =>
      'Автоматически сохранять конвертированные изображения';

  @override
  String get storageLocation => 'Место Хранения';

  @override
  String get storageLocationPath => 'Изображения/ImageConverter';

  @override
  String get advanced => 'Дополнительно';

  @override
  String get language => 'Язык';

  @override
  String get clearCache => 'Очистить Кэш';

  @override
  String get freeUpStorage => 'Освободить место';

  @override
  String get about => 'О программе';

  @override
  String get version => 'Версия';

  @override
  String get latest => 'Последняя';

  @override
  String get privacyPolicy => 'Политика Конфиденциальности';

  @override
  String get howWeHandleData => 'Как мы обрабатываем ваши данные';

  @override
  String get termsOfService => 'Условия Использования';

  @override
  String get appUsageTerms => 'Условия использования приложения';

  @override
  String get resetToDefaults => 'Сбросить до Значений по Умолчанию';

  @override
  String get resetSettings => 'Сбросить Настройки?';

  @override
  String get resetSettingsConfirm =>
      'Это сбросит все настройки до значений по умолчанию. Это действие нельзя отменить.';

  @override
  String get settingsResetToDefaults =>
      'Настройки сброшены до значений по умолчанию';

  @override
  String get clearCacheQuestion => 'Очистить Кэш?';

  @override
  String get clearCacheDescription =>
      'Это удалит временные файлы и освободит место. Ваши изображения и настройки не будут затронуты.';

  @override
  String get cacheClearedSuccessfully => 'Кэш успешно очищен';

  @override
  String get selectLanguage => 'Выбрать Язык';

  @override
  String languageChangedTo(String language) {
    return 'Язык изменен на $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      'Настройка места хранения скоро!';

  @override
  String get privacyPolicyComingSoon => 'Политика конфиденциальности скоро!';

  @override
  String get termsOfServiceComingSoon => 'Условия использования скоро!';

  @override
  String get saveFunctionalityComingSoon => 'Функция сохранения скоро!';

  @override
  String get noImagesSelected => 'Изображения не выбраны';

  @override
  String get pickImageError => 'Не удалось выбрать изображение';

  @override
  String get conversionError => 'Ошибка конвертации';

  @override
  String get resizeError => 'Ошибка изменения размера';

  @override
  String get convertYourImages => 'Конвертируйте Ваши Изображения';

  @override
  String get selectImagesToGetStarted =>
      'Выберите несколько изображений для начала';

  @override
  String get resizeYourImages => 'Измените Размер Ваших Изображений';

  @override
  String get selectAnImageToGetStarted => 'Выберите изображение для начала';

  @override
  String savedNImagesSuccessfully(int count) {
    return 'Успешно сохранено $count изображений!';
  }

  @override
  String get failedToSaveImages => 'Не удалось сохранить изображения';

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
