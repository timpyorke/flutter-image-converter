// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '이미지 변환기';

  @override
  String get convert => '변환';

  @override
  String get resize => '크기 조정';

  @override
  String get settings => '설정';

  @override
  String get loading => '로딩 중...';

  @override
  String get convertImages => '이미지 변환';

  @override
  String get resizeImage => '이미지 크기 조정';

  @override
  String get pickImages => '이미지 선택';

  @override
  String get selectImage => '이미지 선택';

  @override
  String get selectImages => '이미지 선택';

  @override
  String get selectImageToResize => '크기를 조정할 이미지 선택';

  @override
  String converting(int current, int total) {
    return '변환 중 $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return '$count개 이미지 변환';
  }

  @override
  String saveNImages(int count) {
    return '$count개 이미지 저장';
  }

  @override
  String get conversionComplete => '변환 완료!';

  @override
  String get resizeComplete => '크기 조정 완료!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '$count개 이미지가 성공적으로 변환되었습니다';
  }

  @override
  String get yourImageResizedSuccessfully => '이미지 크기가 성공적으로 조정되었습니다';

  @override
  String get format => '형식';

  @override
  String get quality => '품질';

  @override
  String get sourceImages => '원본 이미지';

  @override
  String get sourceImage => '원본 이미지';

  @override
  String get conversionSettings => '변환 설정';

  @override
  String get resizeSettings => '크기 조정 설정';

  @override
  String get width => '너비';

  @override
  String get height => '높이';

  @override
  String get maintainAspectRatio => '종횡비 유지';

  @override
  String get name => '이름';

  @override
  String get dimensions => '크기';

  @override
  String get size => '파일 크기';

  @override
  String get before => '이전';

  @override
  String get after => '이후';

  @override
  String get readyToConvert => '이미지를 변환할 준비가 되셨나요?';

  @override
  String thisWillConvertNImages(int count) {
    return '$count개의 이미지를 변환합니다';
  }

  @override
  String get readyToResize => '이미지 크기를 조정할 준비가 되셨나요?';

  @override
  String get imageWillBeResized => '지정된 크기로 이미지 크기가 조정됩니다';

  @override
  String get cancel => '취소';

  @override
  String get continueAction => '계속';

  @override
  String get save => '저장';

  @override
  String get clear => '지우기';

  @override
  String get reset => '재설정';

  @override
  String get advertisement => '광고';

  @override
  String get adBannerPlaceholder => '광고 배너 자리 표시자';

  @override
  String get appearance => '모양';

  @override
  String get theme => '테마';

  @override
  String get choosePreferredTheme => '원하는 테마 선택';

  @override
  String get light => '밝게';

  @override
  String get dark => '어둡게';

  @override
  String get system => '시스템';

  @override
  String get conversionDefaults => '변환 기본값';

  @override
  String get defaultOutputFormat => '기본 출력 형식';

  @override
  String get defaultQuality => '기본 품질';

  @override
  String get storage => '저장소';

  @override
  String get autoSaveToGallery => '갤러리에 자동 저장';

  @override
  String get automaticallySaveConverted => '변환된 이미지 자동 저장';

  @override
  String get storageLocation => '저장 위치';

  @override
  String get storageLocationPath => 'Pictures/ImageConverter';

  @override
  String get advanced => '고급';

  @override
  String get language => '언어';

  @override
  String get clearCache => '캐시 지우기';

  @override
  String get freeUpStorage => '저장 공간 확보';

  @override
  String get about => '정보';

  @override
  String get version => '버전';

  @override
  String get latest => '최신';

  @override
  String get privacyPolicy => '개인정보 보호정책';

  @override
  String get howWeHandleData => '데이터 처리 방법';

  @override
  String get termsOfService => '서비스 약관';

  @override
  String get appUsageTerms => '앱 사용 약관';

  @override
  String get resetToDefaults => '기본값으로 재설정';

  @override
  String get resetSettings => '설정을 재설정하시겠습니까?';

  @override
  String get resetSettingsConfirm => '모든 설정이 기본값으로 재설정됩니다. 이 작업은 취소할 수 없습니다.';

  @override
  String get settingsResetToDefaults => '설정이 기본값으로 재설정되었습니다';

  @override
  String get clearCacheQuestion => '캐시를 지우시겠습니까?';

  @override
  String get clearCacheDescription =>
      '임시 파일을 지우고 저장 공간을 확보합니다. 이미지와 설정은 영향을 받지 않습니다.';

  @override
  String get cacheClearedSuccessfully => '캐시가 성공적으로 지워졌습니다';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String languageChangedTo(String language) {
    return '언어가 $language(으)로 변경되었습니다';
  }

  @override
  String get storageLocationConfigurationComingSoon => '저장 위치 설정이 곧 제공됩니다!';

  @override
  String get privacyPolicyComingSoon => '개인정보 보호정책이 곧 제공됩니다!';

  @override
  String get termsOfServiceComingSoon => '서비스 약관이 곧 제공됩니다!';

  @override
  String get saveFunctionalityComingSoon => '저장 기능이 곧 제공됩니다!';

  @override
  String get noImagesSelected => '이미지가 선택되지 않았습니다';

  @override
  String get pickImageError => '이미지를 선택하지 못했습니다';

  @override
  String get conversionError => '변환 실패';

  @override
  String get resizeError => '크기 조정 실패';

  @override
  String get convertYourImages => '이미지 변환';

  @override
  String get selectImagesToGetStarted => '여러 이미지를 선택하여 시작';

  @override
  String get resizeYourImages => '이미지 크기 조정';

  @override
  String get selectAnImageToGetStarted => '이미지를 선택하여 시작';

  @override
  String savedNImagesSuccessfully(int count) {
    return '$count개 이미지가 성공적으로 저장되었습니다!';
  }

  @override
  String get failedToSaveImages => '이미지 저장 실패';

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
