// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '画像変換ツール';

  @override
  String get convert => '変換';

  @override
  String get resize => 'リサイズ';

  @override
  String get settings => '設定';

  @override
  String get loading => '読み込み中...';

  @override
  String get convertImages => '画像を変換';

  @override
  String get resizeImage => '画像をリサイズ';

  @override
  String get pickImages => '画像を選択';

  @override
  String get selectImage => '画像を選択';

  @override
  String get selectImages => '画像を選択';

  @override
  String get selectImageToResize => 'リサイズする画像を選択';

  @override
  String converting(int current, int total) {
    return '変換中 $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return '$count 枚の画像を変換';
  }

  @override
  String saveNImages(int count) {
    return '$count 枚の画像を保存';
  }

  @override
  String get conversionComplete => '変換完了！';

  @override
  String get resizeComplete => 'リサイズ完了！';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count 枚の画像を変換しました';
  }

  @override
  String get yourImageResizedSuccessfully => '画像のリサイズが完了しました';

  @override
  String get format => '形式';

  @override
  String get quality => '品質';

  @override
  String get sourceImages => '元の画像';

  @override
  String get sourceImage => '元の画像';

  @override
  String get conversionSettings => '変換設定';

  @override
  String get resizeSettings => 'リサイズ設定';

  @override
  String get width => '幅';

  @override
  String get height => '高さ';

  @override
  String get maintainAspectRatio => 'アスペクト比を維持';

  @override
  String get name => '名前';

  @override
  String get dimensions => '寸法';

  @override
  String get size => 'サイズ';

  @override
  String get before => '前';

  @override
  String get after => '後';

  @override
  String get readyToConvert => '画像を変換する準備はできましたか？';

  @override
  String thisWillConvertNImages(int count) {
    return '$count 枚の画像を変換します';
  }

  @override
  String get readyToResize => '画像をリサイズする準備はできましたか？';

  @override
  String get imageWillBeResized => '画像が指定されたサイズにリサイズされます';

  @override
  String get cancel => 'キャンセル';

  @override
  String get continueAction => '続行';

  @override
  String get save => '保存';

  @override
  String get clear => 'クリア';

  @override
  String get reset => 'リセット';

  @override
  String get advertisement => '広告';

  @override
  String get adBannerPlaceholder => '広告バナープレースホルダー';

  @override
  String get appearance => '外観';

  @override
  String get theme => 'テーマ';

  @override
  String get choosePreferredTheme => 'お好みのテーマを選択';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get system => 'システム';

  @override
  String get conversionDefaults => '変換デフォルト';

  @override
  String get defaultOutputFormat => 'デフォルト出力形式';

  @override
  String get defaultQuality => 'デフォルト品質';

  @override
  String get storage => 'ストレージ';

  @override
  String get autoSaveToGallery => 'ギャラリーに自動保存';

  @override
  String get automaticallySaveConverted => '変換した画像を自動保存';

  @override
  String get storageLocation => '保存場所';

  @override
  String get storageLocationPath => 'Pictures/ImageConverter';

  @override
  String get advanced => '詳細設定';

  @override
  String get language => '言語';

  @override
  String get clearCache => 'キャッシュをクリア';

  @override
  String get freeUpStorage => 'ストレージを解放';

  @override
  String get about => 'について';

  @override
  String get version => 'バージョン';

  @override
  String get latest => '最新';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get howWeHandleData => 'データの取り扱い方法';

  @override
  String get termsOfService => '利用規約';

  @override
  String get appUsageTerms => 'アプリ利用規約';

  @override
  String get resetToDefaults => 'デフォルトに戻す';

  @override
  String get resetSettings => '設定をリセット？';

  @override
  String get resetSettingsConfirm => 'すべての設定がデフォルト値にリセットされます。この操作は元に戻せません。';

  @override
  String get settingsResetToDefaults => '設定がデフォルトにリセットされました';

  @override
  String get clearCacheQuestion => 'キャッシュをクリア？';

  @override
  String get clearCacheDescription => '一時ファイルをクリアしてストレージを解放します。画像と設定には影響しません。';

  @override
  String get cacheClearedSuccessfully => 'キャッシュをクリアしました';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String languageChangedTo(String language) {
    return '言語を $language に変更しました';
  }

  @override
  String get storageLocationConfigurationComingSoon => '保存場所の設定は近日公開！';

  @override
  String get privacyPolicyComingSoon => 'プライバシーポリシーは近日公開！';

  @override
  String get termsOfServiceComingSoon => '利用規約は近日公開！';

  @override
  String get saveFunctionalityComingSoon => '保存機能は近日公開！';

  @override
  String get noImagesSelected => '画像が選択されていません';

  @override
  String get pickImageError => '画像の選択に失敗しました';

  @override
  String get conversionError => '変換に失敗しました';

  @override
  String get resizeError => 'リサイズに失敗しました';

  @override
  String get convertYourImages => '画像を変換';

  @override
  String get selectImagesToGetStarted => '複数の画像を選択して開始';

  @override
  String get resizeYourImages => '画像をリサイズ';

  @override
  String get selectAnImageToGetStarted => '画像を選択して開始';

  @override
  String savedNImagesSuccessfully(int count) {
    return '$count 枚の画像を保存しました！';
  }

  @override
  String get failedToSaveImages => '画像の保存に失敗しました';

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
}
