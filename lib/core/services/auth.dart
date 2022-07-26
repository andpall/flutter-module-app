import 'package:firebase_auth/firebase_auth.dart';

void listenUser() {
  FirebaseAuth.instance.authStateChanges().listen(
    (User? user) {
      print(user);
    },
  );
}

User? getUser() {
  return FirebaseAuth.instance.currentUser;
}

Future<void> authWithEmail(email, password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException {
    rethrow;
  }
}
