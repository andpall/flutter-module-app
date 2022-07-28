import 'package:flutter/material.dart';
import 'package:flutter_mod_app/core/controllers/authController.dart';
import 'package:flutter_mod_app/core/providers/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String password;

  const HomeScreen({Key? key, required this.password, required this.username})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final AuthController _authController = AuthController();
  String? email;

  @override
  void initState() {
    super.initState();
    email = _authController.getUser()?.email;
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
