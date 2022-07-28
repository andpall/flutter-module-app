import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';
import 'package:flutter_mod_app/core/repositories/auth.dart';

class AuthProvider {
  static final AuthProvider _authProvider = AuthProvider._internal();
  final AuthRepository _authRepository = AuthRepository();

  AuthProvider._internal();

  factory AuthProvider() {
    return _authProvider;
  }

  Future<void> signWithMail(AuthData data) async {
    await _authRepository.signWithMail(data);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }


  User? getUser() => _authRepository.getUser();
}
