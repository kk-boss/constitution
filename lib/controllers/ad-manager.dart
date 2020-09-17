import 'package:firebase_admob/firebase_admob.dart';
import '../constants/admob.dart';

class AdManager {
  int _cardPressed = 0;
  int get cardPressed => _cardPressed;
  InterstitialAd interstitialAd;
  set cardPressed(int value) {
    _cardPressed = value;
    if (_cardPressed % 5 == 0) {
      _cardPressed = 0;
      interstitialAd = createInterstitialAd()
        ..load()
        ..show();
    }
  }

  AdManager._internal();
  static final AdManager _adManager = AdManager._internal();
  factory AdManager() {
    return _adManager;
  }

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
        if (event == MobileAdEvent.closed) {
          interstitialAd?.dispose();
        }
      },
    );
  }
}
