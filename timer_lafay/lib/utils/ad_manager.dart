import 'dart:io';

class AdManager {
  // Test ads to avoid using production ads and risk account suspension
  static final String bannerTestAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  static final interstitialTestAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  // Production ads
  // static final String settingsAdUnitId = 'ca-app-pub-5425427834138149/1787969550';

  // static final String interstitialAdUnitId = 'ca-app-pub-5425427834138149/3657301021';
}
