import 'package:flutter/material.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthorized;

  AuthProvider([this._isAuthorized = false]);

  bool get getDarkMode => _isAuthorized;

  void signInWithMain(AuthData data) {
    _isAuthorized = false;
    notifyListeners();
  }

  void logOut() {
    _isAuthorized = !_isAuthorized;
    notifyListeners();
  }
}