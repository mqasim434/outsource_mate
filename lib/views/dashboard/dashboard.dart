import 'package:flutter/material.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/bottom_navbar_provider.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/res/components/bottom_navbar.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/inbox_screen.dart';
import 'package:outsource_mate/views/dashboard/dashboard_screen.dart';
import 'package:outsource_mate/views/dashboard/more_screen/more_screen.dart';
import 'package:outsource_mate/views/dashboard/projects_screen.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print("App is inactive");
        Provider.of<UserProvider>(context, listen: false)
            .updateUserField(fieldName: 'isOnline', newValue: false);
        Provider.of<UserProvider>(context, listen: false).updateUserField(
            fieldName: 'lastSeen',
            newValue: DateTime.now().toString().split('.').first);
        if (UserModel.currentUser.isTyping == true) {
          Provider.of<UserProvider>(context, listen: false)
              .updateUserField(fieldName: 'isTyping', newValue: false);
        }
        break;
      case AppLifecycleState.paused:
        print("App is paused");
        Provider.of<UserProvider>(context, listen: false)
            .updateUserField(fieldName: 'isOnline', newValue: false);
        Provider.of<UserProvider>(context, listen: false).updateUserField(
            fieldName: 'lastSeen',
            newValue: DateTime.now().toString().split('.').first);
        if (UserModel.currentUser.isTyping == true) {
          Provider.of<UserProvider>(context, listen: false)
              .updateUserField(fieldName: 'isTyping', newValue: false);
        }

        break;
      case AppLifecycleState.resumed:
        print("App is resumed");
        Provider.of<UserProvider>(context, listen: false)
            .updateUserField(fieldName: 'isOnline', newValue: true);
        break;
      case AppLifecycleState.detached:
        print("App is detached");
        Provider.of<UserProvider>(context, listen: false)
            .updateUserField(fieldName: 'isOnline', newValue: false);
        if (UserModel.currentUser.isTyping == true) {
          Provider.of<UserProvider>(context, listen: false)
              .updateUserField(fieldName: 'isTyping', newValue: false);
        }
        Provider.of<UserProvider>(context, listen: false).updateUserField(
            fieldName: 'lastSeen',
            newValue: DateTime.now().toString().split('.').first);
      case AppLifecycleState.hidden:
        print("App is Hidded");
        Provider.of<UserProvider>(context, listen: false)
            .updateUserField(fieldName: 'isOnline', newValue: false);
        Provider.of<UserProvider>(context, listen: false).updateUserField(
            fieldName: 'lastSeen',
            newValue: DateTime.now().toString().split('.').first);
        if (UserModel.currentUser.isTyping == true) {
          Provider.of<UserProvider>(context, listen: false)
              .updateUserField(fieldName: 'isTyping', newValue: false);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavbarProvider = Provider.of<BottomNavbarProvider>(context);
    return SafeArea(
      child: Scaffold(
          body: PageView(
            controller: bottomNavbarProvider.controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const DashboardScreen(),
              ProjectsScreen(),
              const InboxScreen(),
              const MoreScreen(),
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
