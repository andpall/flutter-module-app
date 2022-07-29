import 'package:flutter/material.dart';
import 'package:flutter_mod_app/core/navigator/navigator.dart';
import 'package:flutter_mod_app/core/stateProviders/auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter_mod_app/core/stateProviders/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

    void _onPressedSignOut() async {
      var authProvider = Provider.of<AuthStateProvider>(context, listen: false);
      await authProvider.signOut();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.authRoute, ModalRoute.withName(AppRoutes.authRoute));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(email ?? ""),
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: _onPressedSignOut, child: const Text("Log Out")),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: _onPressed, child: const Text("Change Theme")),
            ),
          ],
        ));
  }
}
