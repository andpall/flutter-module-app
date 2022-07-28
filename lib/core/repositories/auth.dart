import 'package:firebase_auth/firebase_auth.dart';


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

  Future<void> signWithMail(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

}
