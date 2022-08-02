import 'package:flutter/material.dart';
import 'package:flutter_mod_app/core/models/user_data.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_mod_app/core/navigator/drawer.dart';
import 'package:flutter_mod_app/core/stateProviders/auth.dart';
import 'package:flutter_mod_app/view/components/textInput/textInput.dart';
import 'package:flutter_mod_app/core/stateProviders/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _email =
        Provider.of<AuthStateProvider>(context, listen: false).getUserEmail ??
            "";
    _userData = Provider.of<ProfileStateProvider>(context, listen: false)
        .getProfileData;
  }

  late UserData? _userData = null;

  late String _username = "";
  String _usernameError = "";
  late String _firstname = "";
  String _firstnameError = "";
  late String _lastname = "";
  String _lastameError = "";
  late String _age = "";
  String _ageError = "";
  late String _city = "";
  String _cityError = "";
  late String _email;
  String _emailError = "";

  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.switchThemeMode();
    }

    void _setUsername(String value) {
      setState(() {
        _username = value;
      });
    }

    void _setFirstName(String value) {
      setState(() {
        _firstname = value;
      });
    }

    void _setLastName(String value) {
      setState(() {
        _lastameError = value;
      });
    }

    void _setAge(String value) {
      setState(() {
        _age = value;
      });
    }

    void _setCity(String value) {
      setState(() {
        _city = value;
      });
    }

    void _setMail(String value) {
      setState(() {
        _email = value;
      });
    }

    return Scaffold(
        drawer: const DrawerNavigator(),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_username),
                TextInput(
                  label: "Nick name",
                  onChange: _setUsername,
                  initialValue: _userData?.nick ?? "",
                ),
                TextInput(
                  label: "First name",
                  onChange: _setFirstName,
                ),
                TextInput(
                  label: "Last name",
                  onChange: _setLastName,
                ),
                TextInput(
                  label: "Age",
                  onChange: _setAge,
                ),
                TextInput(
                  label: "City",
                  onChange: _setCity,
                ),
                TextInput(
                  label: AppLocalizations.of(context)!.email,
                  initialValue: _email,
                  onChange: _setMail,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: _onPressed, child: const Text("Change Theme")),
                ),
              ],
            ),
          ),
        ));
  }
}
