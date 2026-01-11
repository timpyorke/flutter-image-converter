import 'dart:io';

class AdConfig {
  static const String _androidBannerAdUnitId =
      'ca-app-pub-9823034696974019/6287200928';
  static const String _iosBannerAdUnitId =
      'ca-app-pub-9823034696974019/4818863124';

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return _androidBannerAdUnitId;
    } else if (Platform.isIOS) {
      return _iosBannerAdUnitId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
