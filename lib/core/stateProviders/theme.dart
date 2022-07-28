import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const themeStatus = "THEME_STATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}

class ThemeProvider with ChangeNotifier {
  ThemePreference darkThemePreference = ThemePreference();
  bool _darkMode = false;

  ThemeProvider(bool isDarkTheme) {
    _darkMode = isDarkTheme;
  }

  bool get getDarkMode => _darkMode;

  void setDarkThemeMode(bool data) {
    _darkMode = data;
    darkThemePreference.setDarkTheme(data);
    notifyListeners();
  }

  void switchThemeMode() {
    _darkMode = !_darkMode;
    darkThemePreference.setDarkTheme(_darkMode);
    notifyListeners();
  }
}
