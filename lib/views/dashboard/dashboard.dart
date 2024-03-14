import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/bottom_navbar_provider.dart';
import 'package:outsource_mate/res/components/bottom_navbar.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/inbox_screen.dart';
import 'package:outsource_mate/views/dashboard/dashboard_screen.dart';
import 'package:outsource_mate/views/dashboard/more_screen/more_screen.dart';
import 'package:outsource_mate/views/dashboard/projects_screen.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: PageView(
            controller: bottomNavbarProvider.controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DashboardScreen(),
              ProjectsScreen(),
              InboxScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: MyNavBar(
            navItems: [
              NavItem(
                  label: 'Home',
                  activeIcon: Icons.home,
                  inActiveIcon: Icons.home_outlined,
                  onTap: () {
                    bottomNavbarProvider.changeIndex(0);
                  }),
              NavItem(
                  label: 'Projects',
                  activeIcon: Icons.task,
                  inActiveIcon: Icons.task_outlined,
                  onTap: () {
                    bottomNavbarProvider.changeIndex(1);
                  }),
              NavItem(
                  label: 'Chat',
                  activeIcon: Icons.inbox,
                  inActiveIcon: Icons.inbox_outlined,
                  onTap: () {
                    bottomNavbarProvider.changeIndex(2);
                  }),
              NavItem(
                  label: 'More',
                  activeIcon: Icons.more_horiz,
                  inActiveIcon: Icons.more_vert,
                  onTap: () {
                    bottomNavbarProvider.changeIndex(3);
                  }),
            ],
          )),
    );
  }
}
