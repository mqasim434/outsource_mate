// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:outsource_mate/providers/notifications_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';
import 'package:outsource_mate/services/notification_services.dart';

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

  List<Map<String, int>> projectProgressList = [];

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
    _loadProjects().then((value) {
      getProgressList();
    });
  }

  Future<void> _loadProjects() async {
    if (projectsProvider.projectsList.isEmpty) {
      await projectsProvider.getProjects();
    }
  }

  int getProgressCount(ProjectModel projectModel) {
    int progress = 0;
    int count = 0;
    for (int i = 0; i < projectModel.modules!.length; i++) {
      if (projectModel.modules?[i].values.toList().first == true) {
        count++;
      }
    }
    progress = ((count / (projectModel.modules!.length)) * 100).toInt();
    return progress;
  }

  void getProgressList() {
    projectProgressList.clear(); // Clear the list before updating it
    for (int i = 0; i < projectsProvider.projectsList.length; i++) {
      projectProgressList.add({
        projectsProvider.projectsList[i].projectTitle.toString():
            getProgressCount(projectsProvider.projectsList[i])
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.notifications);
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.notifications_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Project Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    projectsProvider.getProjects();
                  },
                  icon: Icon(Icons.replay_rounded),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProjectStatsCard(
                  label: 'In Progress',
                  color: MyColors.pinkColor,
                  projectProvider: projectsProvider,
                ),
                ProjectStatsCard(
                  label: 'In Revision',
                  color: MyColors.purpleColor,
                  projectProvider: projectsProvider,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProjectStatsCard(
                  label: 'Overdue',
                  color: Colors.red,
                  projectProvider: projectsProvider,
                ),
                ProjectStatsCard(
                  label: 'Completed',
                  color: Colors.green,
                  projectProvider: projectsProvider,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 200,
              width: screenWidth,
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  barGroups: projectProgressList.map((e) {
                    int progress = e.values.first;
                    int xValue =
                        progress;
                    return BarChartGroupData(
                      x: xValue,
                      barRods: [
                        BarChartRodData(
                          toY: progress.toDouble(),
                          width: 15,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: projectProgressList.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(projectProgressList[index].keys.first),
            //         trailing: Text(
            //             '${projectProgressList[index].values.first.toStringAsFixed(1)}%'),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton:
          UserModel.currentUser.userType == UserRoles.CLIENT.name
              ? FloatingActionButton(
                  onPressed: () async {
                    // await NotificationServices.sendNotification(
                    //   UserModel.currentUser.deviceToken.toString(),
                    //   context,
                    //   'This is a test Notification',
                    //   'Test Notification',
                    // );
                    Navigator.pushNamed(context, RouteName.addProjectScreen);
                  },
                  child: Icon(Icons.add),
                )
              : SizedBox(),
    );
  }
}

class ProjectStatsCard extends StatelessWidget {
  const ProjectStatsCard({
    super.key,
    required this.label,
    required this.color,
    required this.projectProvider,
  });

  final String? label;
  final Color? color;
  final ProjectProvider projectProvider;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.435,
      height: screenHeight * 0.15,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
        image: DecorationImage(
          opacity: 0.2,
          image: AssetImage('assets/vectors/card_bg.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            projectProvider.projectsList
                .where((element) => (element.projectStatus == label))
                .length
                .toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          Text(
            label.toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}




// Container(
//               width: screenWidth,
//               height: screenHeight * 0.3,
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         height: screenHeight * 0.3,
//                         width: 2,
//                         color: Colors.black,
//                       ),
//                       Container(
//                         height: 2,
//                         width: screenWidth * 0.82,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: sortedProjectsProgressList.reversed
//                             .map((e) => Column(
//                                   children: [
//                                     Text('${e.toInt().toString()}%'),
//                                     SizedBox(
//                                       height: ((screenHeight * 0.3) / e),
//                                     ),
//                                   ],
//                                 ))
//                             .toList(),
//                       ),
//                       SizedBox(
//                         width: screenWidth * 0.82,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: sortedProjectsList.map((e) {
//                               double maxValue = sortedProjectsProgressList
//                                   .reduce((a, b) => a > b ? a : b);
//                               double proportionalHeight =
//                                   (screenHeight * 0.3) * (e.value / maxValue);

//                               return Padding(
//                                 padding: const EdgeInsets.only(left: 16.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(bottom: 4.0),
//                                       child: RotatedBox(
//                                           quarterTurns: -1,
//                                           child: Text(
//                                             e.key,
//                                             style: TextStyle(height: 0),
//                                           )),
//                                     ),
//                                     Container(
//                                       width: 50,
//                                       height: proportionalHeight,
//                                       color: Colors.red,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
