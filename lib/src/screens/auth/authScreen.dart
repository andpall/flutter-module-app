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

  void _incrementCounter() {
    print("Plus");
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

  void _onPressLogin() {
    Navigator.pushNamed(context, HomeScreen.routeName,
        arguments: AuthData(password: _password, username: _username));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _username,
              style: Theme.of(context).textTheme.headline6,
            ),
            TextInput(
              onChange: _setUsername,
            ),
            TextInput(
              onChange: _setPassword,
              passwordUsing: true,
            ),
            Text(
              'Enter password',
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      fixedSize:
                          MaterialStateProperty.all(Size(width - 40, 48)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20))),
                  onPressed: _onPressLogin,
                  child: const Text("Login")),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
