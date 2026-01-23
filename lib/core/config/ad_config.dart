import 'dart:io';
import '../../flavors.dart';

class AdConfig {
  // Test Ad Unit IDs
  static const String _androidTestBannerId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _iosTestBannerId =
      'ca-app-pub-3940256099942544/2934735716';

  // Production Ad Unit IDs
  static const String _androidProdBannerId =
      'ca-app-pub-9823034696974019/6287200928';
  static const String _iosProdBannerId =
      'ca-app-pub-9823034696974019/4818863124';

  static String get bannerAdUnitId {
    if (F.appFlavor == Flavor.dev) {
      if (Platform.isAndroid) {
        return _androidTestBannerId;
      } else if (Platform.isIOS) {
        return _iosTestBannerId;
      }
    } else {
      if (Platform.isAndroid) {
        return _androidProdBannerId;
      } else if (Platform.isIOS) {
        return _iosProdBannerId;
      }
    }
    throw UnsupportedError('Unsupported platform');
  }
}
