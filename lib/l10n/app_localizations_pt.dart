// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Conversor de Imagens';

  @override
  String get convert => 'Converter';

  @override
  String get resize => 'Redimensionar';

  @override
  String get settings => 'Configurações';

  @override
  String get loading => 'Carregando...';

  @override
  String get convertImages => 'Converter Imagens';

  @override
  String get resizeImage => 'Redimensionar Imagem';

  @override
  String get pickImages => 'Selecionar Imagens';

  @override
  String get selectImage => 'Selecionar Imagem';

  @override
  String get selectImages => 'Selecionar Imagens';

  @override
  String get selectImageToResize => 'Selecionar imagem para redimensionar';

  @override
  String converting(int current, int total) {
    return 'Convertendo $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return 'Converter $count imagens';
  }

  @override
  String saveNImages(int count) {
    return 'Salvar $count imagens';
  }

  @override
  String get conversionComplete => 'Conversão Concluída!';

  @override
  String get resizeComplete => 'Redimensionamento Concluído!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count imagens convertidas com sucesso';
  }

  @override
  String get yourImageResizedSuccessfully =>
      'Sua imagem foi redimensionada com sucesso';

  @override
  String get format => 'Formato';

  @override
  String get quality => 'Qualidade';

  @override
  String get sourceImages => 'Imagens de Origem';

  @override
  String get sourceImage => 'Imagem de Origem';

  @override
  String get conversionSettings => 'Configurações de Conversão';

  @override
  String get resizeSettings => 'Configurações de Redimensionamento';

  @override
  String get width => 'Largura';

  @override
  String get height => 'Altura';

  @override
  String get maintainAspectRatio => 'Manter Proporção';

  @override
  String get name => 'Nome';

  @override
  String get dimensions => 'Dimensões';

  @override
  String get size => 'Tamanho';

  @override
  String get before => 'Antes';

  @override
  String get after => 'Depois';

  @override
  String get readyToConvert => 'Pronto para converter suas imagens?';

  @override
  String thisWillConvertNImages(int count) {
    return 'Isso converterá $count imagens';
  }

  @override
  String get readyToResize => 'Pronto para redimensionar sua imagem?';

  @override
  String get imageWillBeResized =>
      'Sua imagem será redimensionada para as dimensões especificadas';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continueAction => 'Continuar';

  @override
  String get save => 'Salvar';

  @override
  String get clear => 'Limpar';

  @override
  String get reset => 'Redefinir';

  @override
  String get advertisement => 'Publicidade';

  @override
  String get adBannerPlaceholder => 'Espaço para Banner Publicitário';

  @override
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get choosePreferredTheme => 'Escolha seu tema preferido';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get system => 'Sistema';

  @override
  String get conversionDefaults => 'Padrões de Conversão';

  @override
  String get defaultOutputFormat => 'Formato de Saída Padrão';

  @override
  String get defaultQuality => 'Qualidade Padrão';

  @override
  String get storage => 'Armazenamento';

  @override
  String get autoSaveToGallery => 'Salvar Automaticamente na Galeria';

  @override
  String get automaticallySaveConverted =>
      'Salvar automaticamente imagens convertidas';

  @override
  String get storageLocation => 'Local de Armazenamento';

  @override
  String get storageLocationPath => 'Imagens/ImageConverter';

  @override
  String get advanced => 'Avançado';

  @override
  String get language => 'Idioma';

  @override
  String get clearCache => 'Limpar Cache';

  @override
  String get freeUpStorage => 'Liberar espaço de armazenamento';

  @override
  String get about => 'Sobre';

  @override
  String get version => 'Versão';

  @override
  String get latest => 'Mais Recente';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get howWeHandleData => 'Como lidamos com seus dados';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get appUsageTerms => 'Termos de uso do aplicativo';

  @override
  String get resetToDefaults => 'Redefinir para Padrões';

  @override
  String get resetSettings => 'Redefinir Configurações?';

  @override
  String get resetSettingsConfirm =>
      'Isso redefinirá todas as configurações para seus valores padrão. Esta ação não pode ser desfeita.';

  @override
  String get settingsResetToDefaults =>
      'Configurações redefinidas para padrões';

  @override
  String get clearCacheQuestion => 'Limpar Cache?';

  @override
  String get clearCacheDescription =>
      'Isso limpará arquivos temporários e liberará espaço de armazenamento. Suas imagens e configurações não serão afetadas.';

  @override
  String get cacheClearedSuccessfully => 'Cache limpo com sucesso';

  @override
  String get selectLanguage => 'Selecionar Idioma';

  @override
  String languageChangedTo(String language) {
    return 'Idioma alterado para $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      'Configuração de local de armazenamento em breve!';

  @override
  String get privacyPolicyComingSoon => 'Política de privacidade em breve!';

  @override
  String get termsOfServiceComingSoon => 'Termos de serviço em breve!';

  @override
  String get saveFunctionalityComingSoon =>
      'Funcionalidade de salvamento em breve!';

  @override
  String get noImagesSelected => 'Nenhuma imagem selecionada';

  @override
  String get pickImageError => 'Falha ao selecionar imagem';

  @override
  String get conversionError => 'Falha na conversão';

  @override
  String get resizeError => 'Falha no redimensionamento';

  @override
  String get convertYourImages => 'Converta suas Imagens';

  @override
  String get selectImagesToGetStarted =>
      'Selecione várias imagens para começar';

  @override
  String get resizeYourImages => 'Redimensione suas Imagens';

  @override
  String get selectAnImageToGetStarted => 'Selecione uma imagem para começar';

  @override
  String savedNImagesSuccessfully(int count) {
    return '$count imagens salvas com sucesso!';
  }

  @override
  String get failedToSaveImages => 'Falha ao salvar imagens';
}
