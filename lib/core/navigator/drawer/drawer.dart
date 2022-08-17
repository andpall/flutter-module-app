import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/constants/colors.dart';
import 'package:flutter_mod_app/core/navigator/navigation_service.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:flutter_mod_app/core/stateProviders/theme.dart';
import 'package:provider/provider.dart';

part '../../models/drawer_item.dart';

part 'list_tile.dart';

class DrawerNavigator extends StatelessWidget {
  const DrawerNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double drawerWidth = screenWidth * 0.7;
    double safeAreaHeight = screenHeight - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Drawer(
        width: drawerWidth,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: safeAreaHeight, maxWidth: drawerWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [_DrawerHeader(), _DrawerItemList()],
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 16),
                      child: _ExitButton(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatefulWidget {
  const _DrawerHeader({Key? key}) : super(key: key);

  @override
  State<_DrawerHeader> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<_DrawerHeader> {
  String? _profileAvatar;
  String? _email;
  String? _nick;

  double imageRadius = 60;

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
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: CircleAvatar(
                radius: imageRadius,
                backgroundImage: NetworkImage(_profileAvatar!)),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 12),
            child: Text(
              _nick ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 4, bottom: 8),
            child: Text(
              _email ?? "",
              style: const TextStyle(color: AppColors.disabledBtn),
            ),
          ),
        ),
      ],
    );
  }
}

class _DrawerItemList extends StatelessWidget {
  const _DrawerItemList({Key? key}) : super(key: key);

  static const List<_DrawerItem> drawerItems = [
    _DrawerItem(route: AppRoutes.homeRoute, label: "Home", icon: Icons.home),
    _DrawerItem(
        route: AppRoutes.profileRoute, label: "Profile", icon: Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: drawerItems.length,
        itemBuilder: (context, index) {
          return _CustomListTile(
            drawerItems[index].route,
            drawerItems[index].label,
            drawerItems[index].icon,
            ModalRoute.of(context)!.settings.name == drawerItems[index].route,
          );
        });
  }
}

class _ExitButton extends StatelessWidget {
  const _ExitButton({Key? key}) : super(key: key);

  void onPress() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 40,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
            backgroundColor: MaterialStateProperty.all(AppColors.mainColor)),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.logout_outlined,
              color: AppColors.whiteColor,
            ),
            Text(
              "Log out",
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
