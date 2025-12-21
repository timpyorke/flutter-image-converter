// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Convertidor de Imágenes';

  @override
  String get convert => 'Convertir';

  @override
  String get resize => 'Redimensionar';

  @override
  String get settings => 'Configuración';

  @override
  String get convertImages => 'Convertir Imágenes';

  @override
  String get resizeImage => 'Redimensionar Imagen';

  @override
  String get pickImages => 'Seleccionar Imágenes';

  @override
  String get selectImage => 'Seleccionar Imagen';

  @override
  String get selectImages => 'Seleccionar Imágenes';

  @override
  String get selectImageToResize => 'Seleccionar imagen para redimensionar';

  @override
  String converting(int current, int total) {
    return 'Convirtiendo $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return 'Convertir $count imágenes';
  }

  @override
  String saveNImages(int count) {
    return 'Guardar $count imágenes';
  }

  @override
  String get conversionComplete => '¡Conversión Completa!';

  @override
  String get resizeComplete => '¡Redimensionado Completo!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count imágenes convertidas exitosamente';
  }

  @override
  String get yourImageResizedSuccessfully =>
      'Tu imagen ha sido redimensionada exitosamente';

  @override
  String get format => 'Formato';

  @override
  String get quality => 'Calidad';

  @override
  String get sourceImages => 'Imágenes de Origen';

  @override
  String get sourceImage => 'Imagen de Origen';

  @override
  String get conversionSettings => 'Configuración de Conversión';

  @override
  String get resizeSettings => 'Configuración de Redimensionado';

  @override
  String get width => 'Ancho';

  @override
  String get height => 'Alto';

  @override
  String get maintainAspectRatio => 'Mantener Relación de Aspecto';

  @override
  String get name => 'Nombre';

  @override
  String get dimensions => 'Dimensiones';

  @override
  String get size => 'Tamaño';

  @override
  String get before => 'Antes';

  @override
  String get after => 'Después';

  @override
  String get readyToConvert => '¿Listo para convertir tus imágenes?';

  @override
  String thisWillConvertNImages(int count) {
    return 'Esto convertirá $count imágenes';
  }

  @override
  String get readyToResize => '¿Listo para redimensionar tu imagen?';

  @override
  String get imageWillBeResized =>
      'Tu imagen será redimensionada a las dimensiones especificadas';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get save => 'Guardar';

  @override
  String get clear => 'Limpiar';

  @override
  String get reset => 'Restablecer';

  @override
  String get advertisement => 'Publicidad';

  @override
  String get adBannerPlaceholder => 'Marcador de Banner Publicitario';

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get choosePreferredTheme => 'Elige tu tema preferido';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get conversionDefaults => 'Valores Predeterminados de Conversión';

  @override
  String get defaultOutputFormat => 'Formato de Salida Predeterminado';

  @override
  String get defaultQuality => 'Calidad Predeterminada';

  @override
  String get storage => 'Almacenamiento';

  @override
  String get autoSaveToGallery => 'Guardar automáticamente en Galería';

  @override
  String get automaticallySaveConverted =>
      'Guardar automáticamente las imágenes convertidas';

  @override
  String get storageLocation => 'Ubicación de Almacenamiento';

  @override
  String get storageLocationPath => 'Imágenes/ImageConverter';

  @override
  String get advanced => 'Avanzado';

  @override
  String get language => 'Idioma';

  @override
  String get clearCache => 'Limpiar Caché';

  @override
  String get freeUpStorage => 'Liberar espacio de almacenamiento';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get latest => 'Última';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get howWeHandleData => 'Cómo manejamos tus datos';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get appUsageTerms => 'Términos de uso de la aplicación';

  @override
  String get resetToDefaults => 'Restablecer a Valores Predeterminados';

  @override
  String get resetSettings => '¿Restablecer Configuración?';

  @override
  String get resetSettingsConfirm =>
      'Esto restablecerá toda la configuración a sus valores predeterminados. Esta acción no se puede deshacer.';

  @override
  String get settingsResetToDefaults =>
      'Configuración restablecida a valores predeterminados';

  @override
  String get clearCacheQuestion => '¿Limpiar Caché?';

  @override
  String get clearCacheDescription =>
      'Esto limpiará los archivos temporales y liberará espacio de almacenamiento. Tus imágenes y configuración no se verán afectadas.';

  @override
  String get cacheClearedSuccessfully => 'Caché limpiado exitosamente';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String languageChangedTo(String language) {
    return 'Idioma cambiado a $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      '¡Configuración de ubicación de almacenamiento próximamente!';

  @override
  String get privacyPolicyComingSoon => '¡Política de privacidad próximamente!';

  @override
  String get termsOfServiceComingSoon => '¡Términos de servicio próximamente!';

  @override
  String get saveFunctionalityComingSoon =>
      '¡Funcionalidad de guardado próximamente!';

  @override
  String get noImagesSelected => 'No se seleccionaron imágenes';

  @override
  String get pickImageError => 'Error al seleccionar imagen';

  @override
  String get conversionError => 'Error de conversión';

  @override
  String get resizeError => 'Error de redimensionado';

  @override
  String get convertYourImages => 'Convierte tus Imágenes';

  @override
  String get selectImagesToGetStarted =>
      'Selecciona varias imágenes para comenzar';

  @override
  String get resizeYourImages => 'Redimensiona tus Imágenes';

  @override
  String get selectAnImageToGetStarted => 'Selecciona una imagen para comenzar';

  @override
  String savedNImagesSuccessfully(int count) {
    return '¡$count imágenes guardadas exitosamente!';
  }

  @override
  String get failedToSaveImages => 'Error al guardar imágenes';
}
