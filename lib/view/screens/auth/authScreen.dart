import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appAssets.dart';
import 'package:flutter_mod_app/core/navigator/navigator.dart';
import 'package:flutter_mod_app/core/stateProviders/auth.dart';
import 'package:flutter_mod_app/view/components/bigButton/button.dart';
import 'package:flutter_mod_app/view/components/textInput/textInput.dart';
import 'package:flutter_mod_app/constants/colors.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _username = "";
  String _password = "";
  String _error = "";

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
      await Provider.of<AuthStateProvider>(context, listen: false)
          .signWithMail(AuthData(_username, _password));
      setState(() => _error = "");
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.homeRoute,
          arguments: AuthData(
            _username,
            _password,
          ));
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  void _onPressRegister() {}

  void _onPressSignWithGoogle() async {
    try {
      await Provider.of<AuthStateProvider>(context, listen: false)
          .signWithGoogle();
      setState(() => _error = "");
      if (!mounted) return;
      Navigator.pushNamed(context, AppRoutes.homeRoute,
          arguments: AuthData(
            _username,
            _password,
          ));
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

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
                      label: AppLocalizations.of(context)!.email,
                      onChange: _setUsername,
                    ),
                    TextInput(
                      label: AppLocalizations.of(context)!.password,
                      onChange: _setPassword,
                      passwordUsing: true,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 24, right: 24),
                      child: Text(
                        _error,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.only(top: 24, bottom: 8, right: 32),
                      child: GestureDetector(
                          onTap: _onPressForgotPassword,
                          child: Text(
                              AppLocalizations.of(context)!.forgot_password,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
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
                        child: Text(
                          AppLocalizations.of(context)!.sign_in,
                          style: const TextStyle(fontSize: 18),
                        )),
                    BigButton(
                        onPressed: _onPressSignWithGoogle,
                        icon: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Tab(icon: AppAssets.googleLogo),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.sign_in_with_google,
                          style: const TextStyle(fontSize: 18),
                        )),
                    BigButton(
                        onPressed: _onPressRegister,
                        child: Text(
                          AppLocalizations.of(context)!.register_new_account,
                          style: const TextStyle(fontSize: 18),
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
