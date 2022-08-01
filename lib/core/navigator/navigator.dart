import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/view/screens/auth/authScreen.dart';
import 'package:flutter_mod_app/view/screens/home/homeScreen.dart';

class AppRouter {
  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (AppRoutes.homeRoute):
        {
          return MaterialPageRoute(
            settings: const RouteSettings(name: AppRoutes.homeRoute),
            builder: (context) {
              return const HomeScreen();
            },
          );
        }
      case (AppRoutes.authRoute):
        {
          return MaterialPageRoute(
            settings: const RouteSettings(name: AppRoutes.authRoute),
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
}
