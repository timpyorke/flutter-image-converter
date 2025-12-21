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
}
