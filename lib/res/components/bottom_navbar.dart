import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/nav_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    super.key,
    required this.navItems,
  });

  final List<NavItem> navItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems,
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.label,
    required this.activeIcon,
    required this.inActiveIcon,
    required this.onTap,
  });

  final String? label;
  final IconData? activeIcon;
  final IconData? inActiveIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    bool isSelected = navProvider.selectedLabel == label;
    return InkWell(
      onTap: () {
        navProvider.changeSelectedLabel(label);
        onTap.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : inActiveIcon,
            color: isSelected ? MyColors.purpleColor: Colors.grey,
          ),
          Text(
            label.toString(),
            style: TextStyle(
              color: isSelected ? MyColors.purpleColor : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: isSelected ? MyColors.pinkColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
