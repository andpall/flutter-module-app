import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _authRepository;
  }

  AuthRepository._internal();

  void listenUser() {
    FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {},
        );
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> signWithMail(AuthData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.username, password: data.password);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
