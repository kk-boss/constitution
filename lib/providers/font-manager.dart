import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontManager with ChangeNotifier {
  double _fontScalefactor = 1.0;
  String _fontPreference = "font_preference";

  FontManager() {
    _loadFont();
  }
  void _loadFont() {
    SharedPreferences.getInstance().then((prefs) {
      double scaleFactor = prefs.getDouble(_fontPreference) ?? 1.0;
      _fontScalefactor = scaleFactor;
    });
  }

  double get fontScalefactor => _fontScalefactor;

  void setFontScalefactor(double scaleFactor) {
    _fontScalefactor = scaleFactor;
    notifyListeners();
  }

  void saveFont() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontPreference, _fontScalefactor);
  }
}
