import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const THEME_STATUS = "THEME_STATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class ThemeProvider with ChangeNotifier {
  ThemePreference darkThemePreference = ThemePreference();
  bool _darkmode = false;

  ThemeProvider(bool isDarkTheme) {
    _darkmode = isDarkTheme;
  }

  bool get getDarkMode => _darkmode;

  void setDarkThemeMode(bool data) {
    _darkmode = data;
    darkThemePreference.setDarkTheme(data);
    notifyListeners();
  }

  void switchThemeMode() {
    _darkmode = !_darkmode;
    darkThemePreference.setDarkTheme(_darkmode);
    notifyListeners();
  }
}
