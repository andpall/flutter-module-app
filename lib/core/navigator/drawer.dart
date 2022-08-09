import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/constants/colors.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:provider/provider.dart';

part '../models/drawer_item.dart';

class DrawerNavigator extends StatefulWidget {
  const DrawerNavigator({Key? key}) : super(key: key);

  @override
  State<DrawerNavigator> createState() => _DrawerNavigatorState();
}

class _DrawerNavigatorState extends State<DrawerNavigator> {
  String? _profileAvatar;
  String? _email;
  String? _nick;

  int _selectedIndex = 0;

  final List<_DrawerItem> drawerItems = [
    _DrawerItem(route: AppRoutes.homeRoute, label: "Home"),
    _DrawerItem(route: AppRoutes.profileRoute, label: "Profile"),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var profileData = Provider.of<ProfileStateProvider>(context).getProfileData;
    _profileAvatar = profileData?.avatarUrl;
    _email = profileData?.email;
    _nick = profileData?.nick;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: screenWidth * 0.7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
      ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 240,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              currentAccountPictureSize: const Size.square(100),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(_profileAvatar!),
              ),
              accountEmail: Text(
                _email ?? "",
                style: const TextStyle(color: Colors.red),
              ),
              accountName: Text(_nick ?? "",
                  style: const TextStyle(color: AppColors.disabledBtn)),
            ),
          ),
          Container(
            // margin: const EdgeInsets.only(right: 80),
            padding: EdgeInsets.only(right: screenWidth * 0.7 - 120 - 20),
            child: CircleAvatar(
                radius: 60, backgroundImage: NetworkImage(_profileAvatar!)),
          ),
          Text(
            _nick ?? "",
          ),
          Text(
            _email ?? "",
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(4.0),
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                return _CustomListTile(
                    drawerItems[index].route, drawerItems[index].label);
              }),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String? title;
  final String routeName;
  final Icon? icon;

  const _CustomListTile(this.routeName, [this.title, this.icon]);

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
