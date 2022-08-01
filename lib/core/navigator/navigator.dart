import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/view/screens/auth/authScreen.dart';
import 'package:flutter_mod_app/view/screens/home/homeScreen.dart';
import 'package:flutter_mod_app/view/screens/profile/profile.dart';

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
      case (AppRoutes.profileRoute):
        {
          return MaterialPageRoute(
            settings: const RouteSettings(name: AppRoutes.profileRoute),
            builder: (context) {
              return const ProfileScreen();
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
