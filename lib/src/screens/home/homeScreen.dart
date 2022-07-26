import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mod_app/src/constants/theme.dart';
import 'package:flutter_mod_app/src/providers/theme.dart';
import 'package:flutter_mod_app/src/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  const HomeScreen({Key? key, required this.password, required this.username})
      : super(key: key);
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String? email;

  @override
  void initState() {
    super.initState();
    email = getUser()?.email;
  }

  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.switchThemeMode();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(email ?? ""),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              onPressed: _onPressed, child: const Text("Change Theme")),
        ));
  }
}
