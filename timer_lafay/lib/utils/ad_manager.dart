import 'dart:io';

class AdManager {
  // Test ads to avoid using production ads and risk account suspension
  static final String testAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  // Production ads
  // static final String settingsAdUnitId = 'ca-app-pub-5425427834138149/1787969550';
}
