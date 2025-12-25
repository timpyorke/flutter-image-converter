// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '图像转换器';

  @override
  String get convert => '转换';

  @override
  String get resize => '调整大小';

  @override
  String get settings => '设置';

  @override
  String get loading => '加载中...';

  @override
  String get convertImages => '转换图像';

  @override
  String get resizeImage => '调整图像大小';

  @override
  String get pickImages => '选择图像';

  @override
  String get selectImage => '选择图像';

  @override
  String get selectImages => '选择图像';

  @override
  String get selectImageToResize => '选择要调整大小的图像';

  @override
  String converting(int current, int total) {
    return '正在转换 $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return '转换 $count 张图像';
  }

  @override
  String saveNImages(int count) {
    return '保存 $count 张图像';
  }

  @override
  String get conversionComplete => '转换完成！';

  @override
  String get resizeComplete => '调整大小完成！';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return '成功转换 $count 张图像';
  }

  @override
  String get yourImageResizedSuccessfully => '您的图像已成功调整大小';

  @override
  String get format => '格式';

  @override
  String get quality => '质量';

  @override
  String get sourceImages => '源图像';

  @override
  String get sourceImage => '源图像';

  @override
  String get conversionSettings => '转换设置';

  @override
  String get resizeSettings => '调整大小设置';

  @override
  String get width => '宽度';

  @override
  String get height => '高度';

  @override
  String get maintainAspectRatio => '保持纵横比';

  @override
  String get name => '名称';

  @override
  String get dimensions => '尺寸';

  @override
  String get size => '大小';

  @override
  String get before => '之前';

  @override
  String get after => '之后';

  @override
  String get readyToConvert => '准备好转换您的图像了吗？';

  @override
  String thisWillConvertNImages(int count) {
    return '这将转换 $count 张图像';
  }

  @override
  String get readyToResize => '准备好调整图像大小了吗？';

  @override
  String get imageWillBeResized => '您的图像将被调整为指定的尺寸';

  @override
  String get cancel => '取消';

  @override
  String get continueAction => '继续';

  @override
  String get save => '保存';

  @override
  String get clear => '清除';

  @override
  String get reset => '重置';

  @override
  String get advertisement => '广告';

  @override
  String get adBannerPlaceholder => '广告横幅占位符';

  @override
  String get appearance => '外观';

  @override
  String get theme => '主题';

  @override
  String get choosePreferredTheme => '选择您喜欢的主题';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get system => '系统';

  @override
  String get conversionDefaults => '转换默认值';

  @override
  String get defaultOutputFormat => '默认输出格式';

  @override
  String get defaultQuality => '默认质量';

  @override
  String get storage => '存储';

  @override
  String get autoSaveToGallery => '自动保存到相册';

  @override
  String get automaticallySaveConverted => '自动保存转换后的图像';

  @override
  String get storageLocation => '存储位置';

  @override
  String get storageLocationPath => '图片/ImageConverter';

  @override
  String get advanced => '高级';

  @override
  String get language => '语言';

  @override
  String get clearCache => '清除缓存';

  @override
  String get freeUpStorage => '释放存储空间';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get latest => '最新';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get howWeHandleData => '我们如何处理您的数据';

  @override
  String get termsOfService => '服务条款';

  @override
  String get appUsageTerms => '应用使用条款';

  @override
  String get resetToDefaults => '恢复默认设置';

  @override
  String get resetSettings => '重置设置？';

  @override
  String get resetSettingsConfirm => '这将把所有设置恢复为默认值。此操作无法撤消。';

  @override
  String get settingsResetToDefaults => '设置已恢复为默认值';

  @override
  String get clearCacheQuestion => '清除缓存？';

  @override
  String get clearCacheDescription => '这将清除临时文件并释放存储空间。您的图像和设置不会受到影响。';

  @override
  String get cacheClearedSuccessfully => '缓存已成功清除';

  @override
  String get selectLanguage => '选择语言';

  @override
  String languageChangedTo(String language) {
    return '语言已更改为 $language';
  }

  @override
  String get storageLocationConfigurationComingSoon => '存储位置配置即将推出！';

  @override
  String get privacyPolicyComingSoon => '隐私政策即将推出！';

  @override
  String get termsOfServiceComingSoon => '服务条款即将推出！';

  @override
  String get saveFunctionalityComingSoon => '保存功能即将推出！';

  @override
  String get noImagesSelected => '未选择图像';

  @override
  String get pickImageError => '无法选择图像';

  @override
  String get conversionError => '转换失败';

  @override
  String get resizeError => '调整大小失败';

  @override
  String get convertYourImages => '转换您的图像';

  @override
  String get selectImagesToGetStarted => '选择多张图像开始';

  @override
  String get resizeYourImages => '调整图像大小';

  @override
  String get selectAnImageToGetStarted => '选择一张图像开始';

  @override
  String savedNImagesSuccessfully(int count) {
    return '成功保存 $count 张图像！';
  }

  @override
  String get failedToSaveImages => '无法保存图像';

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
