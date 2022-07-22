import 'package:flutter/material.dart';
import 'package:flutter_mod_app/src/components/textInput/textInput.dart';
import 'package:flutter_mod_app/src/constants/colors.dart';
import 'package:flutter_mod_app/src/screens/home/homeScreen.dart';

class AuthData {
  final String username;
  final String password;

  AuthData({required this.password, required this.username});
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const String routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _username = "";
  String _password = "";

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

  void _onPressLogin() {
    Navigator.pushNamed(context, HomeScreen.routeName,
        arguments: AuthData(password: _password, username: _username));
  }

  void _onPressRegister() {}

  void _onPressSignWithGoogle() {}

  void _onPressForgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextInput(
              label: "Username",
              onChange: _setUsername,
            ),
            TextInput(
              label: "Password",
              onChange: _setPassword,
              passwordUsing: true,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 16, bottom: 8, right: 16),
              child: GestureDetector(
                  onTap: _onPressForgotPassword,
                  child: Text("Forgot password?",
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.button)),
            ),
            _Button(
                onPressed: _onPressLogin,
                child: const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 18),
                )),
            _Button(
                onPressed: _onPressSignWithGoogle,
                child: const Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 18),
                )),
            _Button(
                onPressed: _onPressRegister,
                child: const Text(
                  "Register new account",
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({Key? key, this.onPressed, this.child}) : super(key: key);
  final Function()? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.only(top: 4, bottom: 8, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainColor),
                    fixedSize: MaterialStateProperty.all(Size(width - 40, 48)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20))),
                onPressed: onPressed,
                child: child),
          ],
        ));
  }
}
