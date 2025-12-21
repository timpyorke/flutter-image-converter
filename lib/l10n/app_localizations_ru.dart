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
}
