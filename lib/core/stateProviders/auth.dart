import 'package:flutter/widgets.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';
import 'package:flutter_mod_app/core/providers/auth.dart';

class AuthStateProvider with ChangeNotifier {
  final AuthProvider _authProvider = AuthProvider();
  String? _email;

  AuthStateProvider();

  String? get getUserEmail => _email;

  Future<void> signWithMail(AuthData data) async {
    await _authProvider.signWithMail(data);
    _email = _authProvider.getUser()?.email;
    notifyListeners();
  }
}
