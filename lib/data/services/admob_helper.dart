import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5657386459450119/5946433928';
      // return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5657386459458119/3049464382';
      // return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError('Unsupported platform');
  }

  // ✅ Initialize AdMob
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  // ✅ Create Banner Ad
  static BannerAd createBannerAd({
    required Function(Ad ad) onAdLoaded,
    required Function(Ad ad, LoadAdError error) onAdFailedToLoad,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
      ),
    );
  }
}