import 'package:flutter/widgets.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';
import 'package:flutter_mod_app/core/repositories/auth.dart';

class AuthStateProvider with ChangeNotifier {
  final AuthRepository _authProvider = AuthRepository();
  String? _email;

  AuthStateProvider();

  String? get getUserEmail => _email;

  Future<void> signWithMail(AuthData data) async {
    await _authProvider.signWithMail(data);
    _email = _authProvider.getUser()?.email;
    notifyListeners();
  }

  Future<void> signWithGoogle() async {
    await _authProvider.signWithGoogle();
    _email = _authProvider.getUser()?.email;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authProvider.signOut();
    _email = _authProvider.getUser()?.email;
    notifyListeners();
  }
}
