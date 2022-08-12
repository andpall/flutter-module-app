import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  NavigationService._internal();

  factory NavigationService() => _instance;

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  dynamic pop() {
    return navigationKey.currentState?.pop();
  }

  Future<dynamic> navigateToRoute(String route, {arguments}) async =>
      navigationKey.currentState?.pushNamed(route, arguments: arguments);

  Future<dynamic> replaceScreenWithRoute(String route, {arguments}) async =>
      navigationKey.currentState
          ?.pushReplacementNamed(route, arguments: arguments);

  void popToFirst() =>
      navigationKey.currentState?.popUntil((route) => route.isFirst);
}
