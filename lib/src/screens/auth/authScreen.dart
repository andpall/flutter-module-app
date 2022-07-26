import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_app/src/components/bigButton/button.dart';
import 'package:flutter_mod_app/src/components/textInput/textInput.dart';
import 'package:flutter_mod_app/src/constants/colors.dart';
import 'package:flutter_mod_app/src/screens/home/homeScreen.dart';
import 'package:flutter_mod_app/src/services/auth.dart';
import 'package:flutter_mod_app/src/models/auth_data.dart';

const googleImage = "assets/images/google_logo.png";

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _username = "";
  String _password = "";

  void errCb(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  void _setUsername(String value) {
    setState(() {
      _username = value;
    });
  }

  void _setPassword(String value) {
    setState(() {
      _password = value;
    });
  }

  void _onPressLogin() async {
    try {
      await authWithEmail(_username, _password);
      Navigator.pushNamed(context, HomeScreen.routeName,
          arguments: AuthData(password: _password, username: _username));
    } catch (e) {
      print(e.toString());
    }
  }

  void _onPressRegister() {}

  void _onPressSignWithGoogle() {}

  void _onPressForgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextInput(
                      label: "Email",
                      onChange: _setUsername,
                    ),
                    TextInput(
                      label: "Password",
                      onChange: _setPassword,
                      passwordUsing: true,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(top: 24, bottom: 8, right: 32),
                      child: GestureDetector(
                          onTap: _onPressForgotPassword,
                          child: const Text("Forgot password",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.transparent,
                                shadows: [
                                  Shadow(
                                      offset: Offset(0, -8), color: disabledBtn)
                                ],
                                decorationThickness: 2,
                                decoration: TextDecoration.underline,
                                decorationColor: disabledBtn,
                              ))),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    BigButton(
                        onPressed: _onPressLogin,
                        child: const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 18),
                        )),
                    BigButton(
                        onPressed: _onPressSignWithGoogle,
                        icon: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Tab(
                              icon: Image.asset(googleImage,
                                  color: Colors.white)),
                        ),
                        child: const Text(
                          "Sign in with Google",
                          style: TextStyle(fontSize: 18),
                        )),
                    BigButton(
                        onPressed: _onPressRegister,
                        child: const Text(
                          "Register new account",
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
