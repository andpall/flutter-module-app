import 'package:flutter/material.dart';
import 'package:flutter_mod_app/core/stateProviders/auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter_mod_app/core/stateProviders/theme.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  const HomeScreen({Key? key, required this.password, required this.username})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? email =
        Provider.of<AuthStateProvider>(context, listen: true).getUserEmail;

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
