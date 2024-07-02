import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'More',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            MoreScreenButtonWidget(
              label: 'Profile',
              icon: const Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, RouteName.profileScreen);
              },
            ),
            UserModel.currentUser.userType == 'FREELANCER'
                ? MoreScreenButtonWidget(
                    label: 'Team',
                    icon: const Icon(Icons.people),
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.teamScreen);
                    },
                  )
                : SizedBox(),
            MoreScreenButtonWidget(
              label: 'About',
              icon: const Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, RouteName.aboutScreen);
              },
            ),
            MoreScreenButtonWidget(
              label: 'Logout',
              icon: const Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  UserModel.currentUser = null;
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteName.signinScreen, (route) => route.isFirst);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MoreScreenButtonWidget extends StatelessWidget {
  const MoreScreenButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(label),
          leading: icon,
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
