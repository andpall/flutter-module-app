import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/colors.dart';
import 'package:flutter_mod_app/core/models/user_data.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:flutter_mod_app/view/components/bigButton/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_mod_app/core/navigator/drawer/drawer.dart';
import 'package:flutter_mod_app/view/components/textInput/textInput.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    _userData = Provider.of<ProfileStateProvider>(context, listen: false)
        .getProfileData;
    _email = _userData?.email ?? "";
    _username = _userData?.nick ?? "";
    _avatar = _userData?.avatarUrl ?? "";
    _firstname = _userData?.name ?? "";
    _lastname = _userData?.surname ?? "";
    _age = _userData?.age ?? "";
    _city = _userData?.city ?? "";
  }

  late UserData? _userData;

  late String _username;
  String _usernameError = "";
  late String _firstname;
  String _firstnameError = "";
  late String _lastname = "";
  String _lastnameError = "";
  late String _age = "";
  String _ageError = "";
  late String _city = "";
  String _cityError = "";
  late String _email;
  String _emailError = "";
  late String _avatar;

  final double imageSize = 140;
  final double iconSize = 28;
  final double iconContainerSize = 48;

  void _onPressed() {
    Provider.of<ProfileStateProvider>(context, listen: false).updateProfile(
        UserData(
            _email, _username, _firstname, _lastname, _age, _city, _avatar));
  }

  void _onIconPressed() {}

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
      _lastnameError = value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerNavigator(),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(imageSize / 2),
                    child: Image.network(
                      _avatar,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: imageSize - iconContainerSize,
                        top: imageSize - iconContainerSize),
                    child: CircleAvatar(
                      radius: (iconSize + 20) / 2,
                      backgroundColor: AppColors.mainColor.withOpacity(0.8),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: iconSize,
                        ),
                        onPressed: _onIconPressed,
                      ),
                    ),
                  ),
                ],
              ),
              TextInput(
                label: "Nick name",
                onChange: _setUsername,
                initialValue: _userData?.nick ?? "",
              ),
              TextInput(
                label: "First name",
                onChange: _setFirstName,
                initialValue: _firstname,
              ),
              TextInput(
                label: "Last name",
                onChange: _setLastName,
                initialValue: _userData?.surname ?? "",
              ),
              TextInput(
                label: "Age",
                onChange: _setAge,
                initialValue: _userData?.age ?? "",
              ),
              TextInput(
                label: "City",
                onChange: _setCity,
                initialValue: _userData?.city ?? "",
              ),
              TextInput(
                label: AppLocalizations.of(context)!.email,
                initialValue: _userData?.email ?? "",
                onChange: _setMail,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child:
                    BigButton(onPressed: _onPressed, child: const Text("Save")),
              ),
            ],
          ),
        ));
  }
}
