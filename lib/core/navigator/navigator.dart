import 'package:flutter/material.dart';
import 'package:flutter_mod_app/view/screens/auth/authScreen.dart';
import 'package:flutter_mod_app/view/screens/home/homeScreen.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';


Map<String, Widget Function(BuildContext)> routes = {
  AuthScreen.routeName: (context) => const AuthScreen(),
};

MaterialPageRoute? onGenerateGlobalRoute(RouteSettings settings) {
  switch (settings.name) {
    case (HomeScreen.routeName):
      {
        final args = settings.arguments as AuthData;
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen(
              username: args.username,
              password: args.password,
            );
          },
        );
      }
    case (AuthScreen.routeName):
      {
        return MaterialPageRoute(
          builder: (context) {
            return const AuthScreen();
          },
        );
      }
    default:
      {
        return null;
      }
  }
}
