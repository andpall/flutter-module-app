import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:provider/provider.dart';

class DrawerNavigator extends StatefulWidget {
  const DrawerNavigator({Key? key}) : super(key: key);

  @override
  State<DrawerNavigator> createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  @override
  Widget build(BuildContext context) {
    String? _profileAvatar =
        Provider.of<ProfileStateProvider>(context).getProfileData?.avatarUrl;

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
      ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: 100,
            width: 100,
            child: Image.network(
              _profileAvatar!,
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'Name',
            style: TextStyle(color: Colors.black),
          ),
          const Text(
            'Email',
            style: TextStyle(color: Colors.black),
          ),
          _CustomListTile(AppRoutes.homeRoute, "Home"),
          _CustomListTile(AppRoutes.profileRoute, "Profile"),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  String? title;
  String routeName;
  Icon? icon;

  _CustomListTile(this.routeName, [this.title, this.icon]);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(routeName);
    }

    return ListTile(
      title: Text(title ?? routeName),
      onTap: _onTap,
    );
  }
}
