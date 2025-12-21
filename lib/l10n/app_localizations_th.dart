// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'แปลงรูปภาพ';

  @override
  String get convert => 'แปลง';

  @override
  String get resize => 'ปรับขนาด';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get loading => 'กำลังโหลด...';

  @override
  String get convertImages => 'แปลงรูปภาพ';

  @override
  String get resizeImage => 'ปรับขนาดรูปภาพ';

  @override
  String get pickImages => 'เลือกรูปภาพ';

  @override
  String get selectImage => 'เลือกรูปภาพ';

  @override
  String get selectImages => 'เลือกรูปภาพ';

  @override
  String get selectImageToResize => 'เลือกรูปภาพเพื่อปรับขนาด';

  @override
  String converting(int current, int total) {
    return 'กำลังแปลง $current/$total...';
  }

  @override
  String convertNImages(int count) {
    return 'แปลง $count รูป';
  }

  @override
  String saveNImages(int count) {
    return 'บันทึก $count รูป';
  }

  @override
  String get conversionComplete => 'แปลงเสร็จสิ้น!';

  @override
  String get resizeComplete => 'ปรับขนาดเสร็จสิ้น!';

  @override
  String nImagesConvertedSuccessfully(int count) {
    return 'แปลงรูปภาพสำเร็จ $count รูป';
  }

  @override
  String get yourImageResizedSuccessfully => 'ปรับขนาดรูปภาพของคุณสำเร็จแล้ว';

  @override
  String get format => 'รูปแบบ';

  @override
  String get quality => 'คุณภาพ';

  @override
  String get sourceImages => 'รูปภาพต้นฉบับ';

  @override
  String get sourceImage => 'รูปภาพต้นฉบับ';

  @override
  String get conversionSettings => 'การตั้งค่าการแปลง';

  @override
  String get resizeSettings => 'การตั้งค่าการปรับขนาด';

  @override
  String get width => 'ความกว้าง';

  @override
  String get height => 'ความสูง';

  @override
  String get maintainAspectRatio => 'รักษาอัตราส่วนภาพ';

  @override
  String get name => 'ชื่อ';

  @override
  String get dimensions => 'ขนาด';

  @override
  String get size => 'ขนาดไฟล์';

  @override
  String get before => 'ก่อน';

  @override
  String get after => 'หลัง';

  @override
  String get readyToConvert => 'พร้อมแปลงรูปภาพของคุณแล้วหรือยัง?';

  @override
  String thisWillConvertNImages(int count) {
    return 'นี่จะแปลงรูปภาพ $count รูป';
  }

  @override
  String get readyToResize => 'พร้อมปรับขนาดรูปภาพของคุณแล้วหรือยัง?';

  @override
  String get imageWillBeResized => 'รูปภาพของคุณจะถูกปรับขนาดตามที่กำหนด';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get continueAction => 'ดำเนินการต่อ';

  @override
  String get save => 'บันทึก';

  @override
  String get clear => 'ล้าง';

  @override
  String get reset => 'รีเซ็ต';

  @override
  String get advertisement => 'โฆษณา';

  @override
  String get adBannerPlaceholder => 'พื้นที่โฆษณา';

  @override
  String get appearance => 'รูปลักษณ์';

  @override
  String get theme => 'ธีม';

  @override
  String get choosePreferredTheme => 'เลือกธีมที่คุณต้องการ';

  @override
  String get light => 'สว่าง';

  @override
  String get dark => 'มืด';

  @override
  String get system => 'ระบบ';

  @override
  String get conversionDefaults => 'ค่าเริ่มต้นการแปลง';

  @override
  String get defaultOutputFormat => 'รูปแบบเอาต์พุตเริ่มต้น';

  @override
  String get defaultQuality => 'คุณภาพเริ่มต้น';

  @override
  String get storage => 'พื้นที่จัดเก็บ';

  @override
  String get autoSaveToGallery => 'บันทึกอัตโนมัติไปยังแกลเลอรี';

  @override
  String get automaticallySaveConverted =>
      'บันทึกรูปภาพที่แปลงแล้วโดยอัตโนมัติ';

  @override
  String get storageLocation => 'ตำแหน่งจัดเก็บ';

  @override
  String get storageLocationPath => 'รูปภาพ/ImageConverter';

  @override
  String get advanced => 'ขั้นสูง';

  @override
  String get language => 'ภาษา';

  @override
  String get clearCache => 'ล้างแคช';

  @override
  String get freeUpStorage => 'เพิ่มพื้นที่จัดเก็บ';

  @override
  String get about => 'เกี่ยวกับ';

  @override
  String get version => 'เวอร์ชัน';

  @override
  String get latest => 'ล่าสุด';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get howWeHandleData => 'วิธีที่เราจัดการข้อมูลของคุณ';

  @override
  String get termsOfService => 'เงื่อนไขการให้บริการ';

  @override
  String get appUsageTerms => 'เงื่อนไขการใช้งานแอป';

  @override
  String get resetToDefaults => 'รีเซ็ตเป็นค่าเริ่มต้น';

  @override
  String get resetSettings => 'รีเซ็ตการตั้งค่า?';

  @override
  String get resetSettingsConfirm =>
      'การดำเนินการนี้จะรีเซ็ตการตั้งค่าทั้งหมดเป็นค่าเริ่มต้น การกระทำนี้ไม่สามารถยกเลิกได้';

  @override
  String get settingsResetToDefaults => 'รีเซ็ตการตั้งค่าเป็นค่าเริ่มต้นแล้ว';

  @override
  String get clearCacheQuestion => 'ล้างแคช?';

  @override
  String get clearCacheDescription =>
      'การดำเนินการนี้จะล้างไฟล์ชั่วคราวและเพิ่มพื้นที่จัดเก็บ รูปภาพและการตั้งค่าของคุณจะไม่ได้รับผลกระทบ';

  @override
  String get cacheClearedSuccessfully => 'ล้างแคชเรียบร้อยแล้ว';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String languageChangedTo(String language) {
    return 'เปลี่ยนภาษาเป็น $language';
  }

  @override
  String get storageLocationConfigurationComingSoon =>
      'การกำหนดค่าตำแหน่งจัดเก็บเร็วๆ นี้!';

  @override
  String get privacyPolicyComingSoon => 'นโยบายความเป็นส่วนตัวเร็วๆ นี้!';

  @override
  String get termsOfServiceComingSoon => 'เงื่อนไขการให้บริการเร็วๆ นี้!';

  @override
  String get saveFunctionalityComingSoon => 'ฟังก์ชันการบันทึกเร็วๆ นี้!';

  @override
  String get noImagesSelected => 'ไม่ได้เลือกรูปภาพ';

  @override
  String get pickImageError => 'ไม่สามารถเลือกรูปภาพ';

  @override
  String get conversionError => 'การแปลงล้มเหลว';

  @override
  String get resizeError => 'การปรับขนาดล้มเหลว';

  @override
  String get convertYourImages => 'แปลงรูปภาพของคุณ';

  @override
  String get selectImagesToGetStarted => 'เลือกหลายรูปภาพเพื่อเริ่มต้น';

  @override
  String get resizeYourImages => 'ปรับขนาดรูปภาพของคุณ';

  @override
  String get selectAnImageToGetStarted => 'เลือกรูปภาพเพื่อเริ่มต้น';

  @override
  String savedNImagesSuccessfully(int count) {
    return 'บันทึกรูปภาพสำเร็จ $count รูป!';
  }

  @override
  String get failedToSaveImages => 'ไม่สามารถบันทึกรูปภาพ';
}
