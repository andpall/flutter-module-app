import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _authRepository;
  }

  AuthRepository._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
