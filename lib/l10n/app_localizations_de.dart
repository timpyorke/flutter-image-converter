// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Bildkonverter';

  @override
  String get convert => 'Konvertieren';

  @override
  String get resize => 'Größe ändern';

  @override
  String get settings => 'Einstellungen';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get convertImages => 'Bilder Konvertieren';

  @override
  String get resizeImage => 'Bildgröße Ändern';

  @override
  String get pickImages => 'Bilder Auswählen';

  @override
  String get selectImage => 'Bild Auswählen';

  @override
  String get selectImages => 'Bilder Auswählen';

  @override
  String get selectImageToResize => 'Bild zum Ändern der Größe auswählen';

  @override
  String converting(int current, int total) {
    return 'Konvertiere $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return '$count Bilder konvertieren';
  }

  @override
  String saveNImages(int count) {
    return '$count Bilder speichern';
  }

  @override
  String get conversionComplete => 'Konvertierung Abgeschlossen!';

  @override
  String get resizeComplete => 'Größenänderung Abgeschlossen!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count Bilder erfolgreich konvertiert';
  }

  @override
  String get yourImageResizedSuccessfully =>
      'Ihr Bild wurde erfolgreich in der Größe geändert';

  @override
  String get format => 'Format';

  @override
  String get quality => 'Qualität';

  @override
  String get sourceImages => 'Quellbilder';

  @override
  String get sourceImage => 'Quellbild';

  @override
  String get conversionSettings => 'Konvertierungseinstellungen';

  @override
  String get resizeSettings => 'Größenänderungseinstellungen';

  @override
  String get width => 'Breite';

  @override
  String get height => 'Höhe';

  @override
  String get maintainAspectRatio => 'Seitenverhältnis Beibehalten';

  @override
  String get name => 'Name';

  @override
  String get dimensions => 'Abmessungen';

  @override
  String get size => 'Größe';

  @override
  String get before => 'Vorher';

  @override
  String get after => 'Nachher';

  @override
  String get readyToConvert => 'Bereit, Ihre Bilder zu konvertieren?';

  @override
  String thisWillConvertNImages(int count) {
    return 'Dies wird $count Bilder konvertieren';
  }

  @override
  String get readyToResize => 'Bereit, die Größe Ihres Bildes zu ändern?';

  @override
  String get imageWillBeResized =>
      'Ihr Bild wird auf die angegebenen Abmessungen skaliert';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get continueAction => 'Fortfahren';

  @override
  String get save => 'Speichern';

  @override
  String get clear => 'Löschen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get advertisement => 'Werbung';

  @override
  String get adBannerPlaceholder => 'Werbebanner Platzhalter';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get theme => 'Design';

  @override
  String get choosePreferredTheme => 'Wählen Sie Ihr bevorzugtes Design';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get system => 'System';

  @override
  String get conversionDefaults => 'Konvertierungs-Standardwerte';

  @override
  String get defaultOutputFormat => 'Standard-Ausgabeformat';

  @override
  String get defaultQuality => 'Standardqualität';

  @override
  String get storage => 'Speicher';

  @override
  String get autoSaveToGallery => 'Automatisch in Galerie Speichern';

  @override
  String get automaticallySaveConverted =>
      'Konvertierte Bilder automatisch speichern';

  @override
  String get storageLocation => 'Speicherort';

  @override
  String get storageLocationPath => 'Bilder/ImageConverter';

  @override
  String get advanced => 'Erweitert';

  @override
  String get language => 'Sprache';

  @override
  String get clearCache => 'Cache Leeren';

  @override
  String get freeUpStorage => 'Speicherplatz freigeben';

  @override
  String get about => 'Über';

  @override
  String get version => 'Version';

  @override
  String get latest => 'Neueste';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get howWeHandleData => 'Wie wir Ihre Daten verarbeiten';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get appUsageTerms => 'App-Nutzungsbedingungen';

  @override
  String get resetToDefaults => 'Auf Standardwerte Zurücksetzen';

  @override
  String get resetSettings => 'Einstellungen Zurücksetzen?';

  @override
  String get resetSettingsConfirm =>
      'Dies setzt alle Einstellungen auf ihre Standardwerte zurück. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get settingsResetToDefaults =>
      'Einstellungen auf Standardwerte zurückgesetzt';

  @override
  String get clearCacheQuestion => 'Cache Leeren?';

  @override
  String get clearCacheDescription =>
      'Dies löscht temporäre Dateien und gibt Speicherplatz frei. Ihre Bilder und Einstellungen werden nicht beeinträchtigt.';

  @override
  String get cacheClearedSuccessfully => 'Cache erfolgreich geleert';

  @override
  String get selectLanguage => 'Sprache Auswählen';

  @override
  String languageChangedTo(String language) {
    return 'Sprache geändert zu $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      'Speicherort-Konfiguration kommt bald!';

  @override
  String get privacyPolicyComingSoon => 'Datenschutzrichtlinie kommt bald!';

  @override
  String get termsOfServiceComingSoon => 'Nutzungsbedingungen kommen bald!';

  @override
  String get saveFunctionalityComingSoon => 'Speicherfunktion kommt bald!';

  @override
  String get noImagesSelected => 'Keine Bilder ausgewählt';

  @override
  String get pickImageError => 'Bild konnte nicht ausgewählt werden';

  @override
  String get conversionError => 'Konvertierung fehlgeschlagen';

  @override
  String get resizeError => 'Größenänderung fehlgeschlagen';

  @override
  String get convertYourImages => 'Konvertieren Sie Ihre Bilder';

  @override
  String get selectImagesToGetStarted =>
      'Wählen Sie mehrere Bilder aus, um zu beginnen';

  @override
  String get resizeYourImages => 'Ändern Sie die Größe Ihrer Bilder';

  @override
  String get selectAnImageToGetStarted =>
      'Wählen Sie ein Bild aus, um zu beginnen';

  @override
  String savedNImagesSuccessfully(int count) {
    return '$count Bilder erfolgreich gespeichert!';
  }

  @override
  String get failedToSaveImages => 'Bilder konnten nicht gespeichert werden';

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
}
