part of 'drawer.dart';

class _CustomListTile extends StatelessWidget {
  final String? title;
  final String routeName;
  final IconData icon;
  final bool selected;

  const _CustomListTile(this.routeName, [
    this.title,
    this.icon = Icons.abc,
    this.selected = false,
  ]);

  Color getColor(BuildContext context) {
    if (selected == true) return AppColors.mainColor;
    bool isDarkMode = context
        .read<ThemeProvider>()
        .getDarkMode;
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