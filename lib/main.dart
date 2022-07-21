import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mod_app/src/constants/theme.dart';
import 'package:flutter_mod_app/src/navigator/navigator.dart';
import 'package:flutter_mod_app/src/screens/auth/authScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Module App',
        theme: lightTheme,
        initialRoute: AuthScreen.routeName,
        onGenerateRoute: onGenerateGlobalRoute);
  }
}
