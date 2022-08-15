import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/appRoutes.dart';
import 'package:flutter_mod_app/constants/colors.dart';
import 'package:flutter_mod_app/core/navigator/navigation_service.dart';
import 'package:flutter_mod_app/core/stateProviders/profile.dart';
import 'package:flutter_mod_app/core/stateProviders/theme.dart';
import 'package:provider/provider.dart';

part '../../models/drawer_item.dart';

part 'list_tile.dart';

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
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                maxWidth: drawerWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 4, bottom: 8),
                        child: Text(
                          _email ?? "",
                          style: const TextStyle(color: AppColors.disabledBtn),
                        ),
                      ),
                    ),
                    ListView.builder(
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
                            ModalRoute.of(context)!.settings.name ==
                                drawerItems[index].route,
                          );
                        }),
                  ],
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, bottom: 16),
                      child: ExitButton(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

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
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.logout_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            Text(
              "Log out",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
