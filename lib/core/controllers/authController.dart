import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mod_app/core/repositories/auth.dart';

class AuthController {
  final AuthRepository _authRepository = AuthRepository();

  AuthController();

  Future<void>  signWithMail(email, password) async {
    await _authRepository.signWithMail(email, password);
  }

  User? getUser() => _authRepository.getUser();
}
