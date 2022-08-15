import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/constants/colors.dart';
import 'package:flutter_mod_app/core/navigator/navigation_service.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:flutter_mod_app/core/stateProviders/theme.dart';
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

  final List<_DrawerItem> drawerItems = [
    _DrawerItem(route: AppRoutes.homeRoute, label: "Home", icon: Icons.home),
    _DrawerItem(
        route: AppRoutes.profileRoute, label: "Profile", icon: Icons.person),
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
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 4, bottom: 8),
                    child: Text(
                      _email ?? "",
                      style: const TextStyle(color: AppColors.disabledBtn),
                    ),
                  ),
                )
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  return _CustomListTile(
                    drawerItems[index].route,
                    drawerItems[index].label,
                    drawerItems[index].icon,
                    ModalRoute.of(context)!.settings.name ==
                        drawerItems[index].route,
                  );
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
  final IconData icon;
  final bool selected;

  const _CustomListTile(
    this.routeName, [
    this.title,
    this.icon = Icons.abc,
    this.selected = false,
  ]);

  Color getColor(BuildContext context) {
    if (selected == true) return AppColors.mainColor;
    bool isDarkMode = context.read<ThemeProvider>().getDarkMode;
    return isDarkMode ? AppColors.whiteColor : AppColors.blackColor;
  }

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      NavigationService().pop();
      NavigationService().navigateToRoute(routeName);
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(left: 8),
      visualDensity: const VisualDensity(vertical: -2),
      dense: true,
      leading: Icon(
        icon,
        color: getColor(context),
      ),
      title: Transform.translate(
        offset: const Offset(-24, 0),
        child: Text(
          title ?? routeName,
          style: selected ? const TextStyle(color: AppColors.mainColor) : null,
        ),
      ),
      onTap: _onTap,
    );
  }
}
