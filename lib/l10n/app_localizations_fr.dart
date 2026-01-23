// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Convertisseur d\'Images';

  @override
  String get convert => 'Convertir';

  @override
  String get resize => 'Redimensionner';

  @override
  String get settings => 'Paramètres';

  @override
  String get loading => 'Chargement...';

  @override
  String get convertImages => 'Convertir les Images';

  @override
  String get resizeImage => 'Redimensionner l\'Image';

  @override
  String get pickImages => 'Sélectionner des Images';

  @override
  String get selectImage => 'Sélectionner une Image';

  @override
  String get selectImages => 'Sélectionner des Images';

  @override
  String get selectImageToResize => 'Sélectionner l\'image à redimensionner';

  @override
  String converting(int current, int total) {
    return 'Conversion $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return 'Convertir $count images';
  }

  @override
  String saveNImages(int count) {
    return 'Enregistrer $count images';
  }

  @override
  String get conversionComplete => 'Conversion Terminée !';

  @override
  String get resizeComplete => 'Redimensionnement Terminé !';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count images converties avec succès';
  }

  @override
  String get yourImageResizedSuccessfully =>
      'Votre image a été redimensionnée avec succès';

  @override
  String get format => 'Format';

  @override
  String get quality => 'Qualité';

  @override
  String get sourceImages => 'Images Sources';

  @override
  String get sourceImage => 'Image Source';

  @override
  String get conversionSettings => 'Paramètres de Conversion';

  @override
  String get resizeSettings => 'Paramètres de Redimensionnement';

  @override
  String get width => 'Largeur';

  @override
  String get height => 'Hauteur';

  @override
  String get maintainAspectRatio => 'Maintenir le Rapport d\'Aspect';

  @override
  String get name => 'Nom';

  @override
  String get dimensions => 'Dimensions';

  @override
  String get size => 'Taille';

  @override
  String get before => 'Avant';

  @override
  String get after => 'Après';

  @override
  String get readyToConvert => 'Prêt à convertir vos images ?';

  @override
  String thisWillConvertNImages(int count) {
    return 'Cela convertira $count images';
  }

  @override
  String get readyToResize => 'Prêt à redimensionner votre image ?';

  @override
  String get imageWillBeResized =>
      'Votre image sera redimensionnée aux dimensions spécifiées';

  @override
  String get cancel => 'Annuler';

  @override
  String get continueAction => 'Continuer';

  @override
  String get save => 'Enregistrer';

  @override
  String get clear => 'Effacer';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get advertisement => 'Publicité';

  @override
  String get adBannerPlaceholder => 'Bannière Publicitaire';

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get choosePreferredTheme => 'Choisissez votre thème préféré';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get conversionDefaults => 'Paramètres de Conversion par Défaut';

  @override
  String get defaultOutputFormat => 'Format de Sortie par Défaut';

  @override
  String get defaultQuality => 'Qualité par Défaut';

  @override
  String get storage => 'Stockage';

  @override
  String get autoSaveToGallery => 'Enregistrer Automatiquement dans la Galerie';

  @override
  String get automaticallySaveConverted =>
      'Enregistrer automatiquement les images converties';

  @override
  String get storageLocation => 'Emplacement de Stockage';

  @override
  String get storageLocationPath => 'Images/ImageConverter';

  @override
  String get advanced => 'Avancé';

  @override
  String get language => 'Langue';

  @override
  String get clearCache => 'Vider le Cache';

  @override
  String get freeUpStorage => 'Libérer de l\'espace de stockage';

  @override
  String get about => 'À Propos';

  @override
  String get version => 'Version';

  @override
  String get latest => 'Dernière';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get howWeHandleData => 'Comment nous gérons vos données';

  @override
  String get termsOfService => 'Conditions d\'Utilisation';

  @override
  String get appUsageTerms => 'Conditions d\'utilisation de l\'application';

  @override
  String get resetToDefaults => 'Réinitialiser aux Valeurs par Défaut';

  @override
  String get resetSettings => 'Réinitialiser les Paramètres ?';

  @override
  String get resetSettingsConfirm =>
      'Cela réinitialisera tous les paramètres à leurs valeurs par défaut. Cette action ne peut pas être annulée.';

  @override
  String get settingsResetToDefaults =>
      'Paramètres réinitialisés aux valeurs par défaut';

  @override
  String get clearCacheQuestion => 'Vider le Cache ?';

  @override
  String get clearCacheDescription =>
      'Cela supprimera les fichiers temporaires et libérera de l\'espace de stockage. Vos images et paramètres ne seront pas affectés.';

  @override
  String get cacheClearedSuccessfully => 'Cache vidé avec succès';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String languageChangedTo(String language) {
    return 'Langue changée en $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      'Configuration de l\'emplacement de stockage bientôt disponible !';

  @override
  String get privacyPolicyComingSoon =>
      'Politique de confidentialité bientôt disponible !';

  @override
  String get termsOfServiceComingSoon =>
      'Conditions d\'utilisation bientôt disponibles !';

  @override
  String get saveFunctionalityComingSoon =>
      'Fonctionnalité d\'enregistrement bientôt disponible !';

  @override
  String get noImagesSelected => 'Aucune image sélectionnée';

  @override
  String get pickImageError => 'Échec de la sélection de l\'image';

  @override
  String get conversionError => 'Échec de la conversion';

  @override
  String get resizeError => 'Échec du redimensionnement';

  @override
  String get convertYourImages => 'Convertissez vos Images';

  @override
  String get selectImagesToGetStarted =>
      'Sélectionnez plusieurs images pour commencer';

  @override
  String get resizeYourImages => 'Redimensionnez vos Images';

  @override
  String get selectAnImageToGetStarted =>
      'Sélectionnez une image pour commencer';

  @override
  String savedNImagesSuccessfully(int count) {
    return '$count images enregistrées avec succès !';
  }

  @override
  String get failedToSaveImages => 'Échec de l\'enregistrement des images';

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
