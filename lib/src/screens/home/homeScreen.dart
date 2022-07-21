import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String password;

  const HomeScreen({Key? key, required this.password, required this.username})
      : super(key: key);
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(username),
        ),
        body: Container());
  }
}
