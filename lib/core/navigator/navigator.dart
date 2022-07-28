import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/routes.dart';
import 'package:flutter_mod_app/view/screens/auth/authScreen.dart';
import 'package:flutter_mod_app/view/screens/home/homeScreen.dart';
import 'package:flutter_mod_app/core/models/auth_data.dart';

MaterialPageRoute? onGenerateGlobalRoute(RouteSettings settings) {
  switch (settings.name) {
    case (homeRoute):
      {
        final args = settings.arguments as AuthData;
        return MaterialPageRoute(
          settings: const RouteSettings(name: homeRoute),
          builder: (context) {
            return HomeScreen(
              username: args.username,
              password: args.password,
            );
          },
        );
      }
    case (authRoute):
      {
        return MaterialPageRoute(
          settings: const RouteSettings(name: authRoute),
          builder: (context) {
            return const AuthScreen();
          },
        );
      }
    default:
      {
        break;
      }
  }
  return null;
}
