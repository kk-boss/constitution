import 'package:ConstitutionOfNepal/controllers/ad-manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_admob/firebase_admob.dart';

import './constants/admob.dart';
import './providers/bookmark-manager.dart';
import './providers/font-manager.dart';
import './providers/theme-manager.dart';
import './views/about-app.dart';
import './views/about-us.dart';
import './views/bookmarks.dart';
import './views/chapter.dart';
import './views/home.dart';
import './views/schedule.dart';
import './views/search.dart';
import './views/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: getAppId());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd _bannerAd;
  double _bottomPadding = 0.0;
  @override
  void initState() {
    super.initState();
    _bannerAd = createBannerAd()..load();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          if (_bottomPadding != 0.0)
            setState(() {
              _bottomPadding = 0.0;
            });
        }
        if (event == MobileAdEvent.loaded) {
          if (_bottomPadding != 50.0)
            setState(() {
              _bottomPadding = 50.0;
            });
        }
      },
    );
  }

  @override
  void dispose() {
    AdManager().interstitialAd?.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FontManager()),
        ChangeNotifierProvider.value(value: BookmarkManager()),
        ChangeNotifierProvider.value(value: ThemeManager()),
      ],
      child: Consumer<ThemeManager>(builder: (context, themeManager, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'नेपालको संविधान',
          theme: themeManager.themeData,
          home: HomePage(),
          routes: {
            '/chapter': (ctx) => Chapter(),
            '/bookmarks': (ctx) => Bookmarks(),
            '/themes': (ctx) => ThemeChooser(),
            '/schedule': (ctx) => ScheduleView(),
            '/search': (ctx) => Search(),
            AboutUs.routeName: (ctx) => AboutUs(),
            AboutApp.routeName: (ctx) => AboutApp(),
          },
          builder: (context, widget) {
            _bannerAd..show();
            return Padding(
              padding: EdgeInsets.only(
                bottom: _bottomPadding,
              ),
              child: widget,
            );
          },
        );
      }),
    );
  }
}
