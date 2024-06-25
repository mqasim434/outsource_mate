// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:outsource_mate/models/notification_model.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/notifications_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/project_widget.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/enums.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:outsource_mate/views/dashboard/notifications_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ProjectProvider projectsProvider = ProjectProvider();
  ClientProvider clientProvider = ClientProvider();
  NotificationsProvider notificationsProvider = NotificationsProvider();
  String? selectedFreelancerId;
  String? freelancerEmail;

  String getCollectionName() {
    print(UserModel.currentUser.userType);
    if (UserModel.currentUser.userType.toString() ==
        UserRoles.FREELANCER.name) {
      return 'freelancers';
    } else if (UserModel.currentUser.userType.toString() ==
        UserRoles.CLIENT.name) {
      return 'clients';
    } else if (UserModel.currentUser.userType.toString() ==
        UserRoles.EMPLOYEE.name) {
      return 'employees';
    } else {
      return 'N/A';
    }
  }

  @override
  void initState() {
    super.initState();
    projectsProvider = Provider.of<ProjectProvider>(context, listen: false);
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    if (projectsProvider.projectsList.isEmpty) {
      await projectsProvider.getProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final signinProvider = Provider.of<SigninProvider>(context);

    return Scaffold(
      backgroundColor: MyColors.purpleColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height * 0.2,
              decoration: const BoxDecoration(
                color: MyColors.purpleColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 25,
                    ),
                    title: Text(
                      'Hi! \n${UserModel.currentUser != null ? UserModel.currentUser.email : 'User'}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Text(
                      'Welcome to ${signinProvider.currentRoleSelected.name} Dashboard',
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    trailing: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.notifications);
                        },
                        child: const CircleAvatar(
                            child: Icon(Icons.notifications))),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active Projects',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                projectsProvider.projectsList.clear();
                                setState(() {});
                              },
                              icon: Icon(Icons.replay_rounded))
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: _loadProjects(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(child: SizedBox());
                          }
                          if (projectsProvider.projectsList.isEmpty) {
                            return const Center(child: Text("No Projects Yet"));
                          }
                          return ListView.builder(
                            itemCount: projectsProvider.projectsList.length,
                            itemBuilder: (context, index) {
                              final project =
                                  projectsProvider.projectsList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: ProjectWidget(projectModel: project),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          signinProvider.currentRoleSelected == UserRoles.CLIENT
              ? FloatingActionButton(
                  backgroundColor: MyColors.pinkColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.addProjectScreen);
                  },
                  child: const Icon(Icons.add_box_rounded),
                )
              : const SizedBox(),
    );
  }
}
