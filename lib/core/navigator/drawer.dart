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

  late double screenWidth;
  late double drawerWidth = screenWidth * 0.7;
  double imageRadius = 60;

  static int _selectedIndex = 0;

  final List<_DrawerItem> drawerItems = [
    _DrawerItem(route: AppRoutes.homeRoute, label: "Home"),
    _DrawerItem(route: AppRoutes.profileRoute, label: "Profile"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;

    var profileData = Provider.of<ProfileStateProvider>(context).getProfileData;
    _profileAvatar = profileData?.avatarUrl;
    _email = profileData?.email;
    _nick = profileData?.nick;
  }

  void tileCallback(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: drawerWidth,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(_profileAvatar!)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _nick ?? "",
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _email ?? "",
                  ),
                )
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(4.0),
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  return _CustomListTile(
                      drawerItems[index].route,
                      drawerItems[index].label,
                      null,
                      index == _selectedIndex,
                      () => tileCallback(index));
                }),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String? title;
  final String routeName;
  final Icon? icon;
  final bool selected;
  final VoidCallback? callback;

  const _CustomListTile(this.routeName,
      [this.title, this.icon, this.selected = false, this.callback]);

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      if (callback != null) callback!();
      Navigator.pop(context);
      Navigator.of(context).pushNamed(routeName);
    }

    return ListTile(
      title: Text(
        title ?? routeName,
        style: selected ? const TextStyle(color: AppColors.mainColor) : null,
      ),
      onTap: _onTap,
    );
  }
}
