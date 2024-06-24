// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/custom_timer_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  DateFormat dateFormat = DateFormat("MM/dd/yyyy hh:mm a");

  int getProgressCount() {
    int progress = 0;
    int count = 0;
    for (int i = 0; i < widget.project.modules!.length; i++) {
      if (widget.project.modules?[i].values.toList().first == true) {
        count++;
      }
    }
    progress = ((count / (widget.project.modules!.length)) * 100).toInt();
    return progress;
  }

  int getProgressWidth(double screenWidth) {
    int progress = 0;
    int count = 0;
    for (int i = 0; i < widget.project.modules!.length; i++) {
      if (widget.project.modules?[i].values.toList().first == true) {
        count++;
      }
    }
    progress =
        ((count / (widget.project.modules!.length)) * screenWidth).toInt();
    return progress;
  }

  String? projectStatus;

  ProjectProvider projectProvider = ProjectProvider();

  initializeProvider(BuildContext context) {
    projectProvider = Provider.of<ProjectProvider>(context);
  }

  bool checkIfOverdue(DateTime deadline) {
    DateTime now = DateTime.now();
    return now.isAfter(deadline);
  }

  @override
  void initState() {
    super.initState();
    projectStatus = widget.project.projectStatus;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (projectStatus != 'Completed' &&
          projectStatus != 'Overdue' &&
          checkIfOverdue(widget.project.deadline as DateTime)) {
        _updateProjectStatusToOverdue();
      }
    });
  }

  Future<void> _updateProjectStatusToOverdue() async {
    await projectProvider.updateProjectStatus(
      widget.project.projectId.toString(),
      'Overdue',
    );
  }

  bool isDescriptionExpanded = false;
  bool isModulesExpanded = false;
  bool isReviewsExpanded = false;
  bool isFilesExpanded = false;

  @override
  Widget build(BuildContext context) {
    initializeProvider(context);

    List<Map<String, String>> filesList = [
      {
        'fileName': 'File1.png',
        'fileUrl': 'File1.png',
      },
      {
        'fileName': 'File2.png',
        'fileUrl': 'File2.png',
      },
      {
        'fileName': 'File3.png',
        'fileUrl': 'File3.png',
      },
    ];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Project Details',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 1,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: screenHeight * 0.50,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.project.projectTitle.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Project Status: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Chip(
                            label: Text(
                              widget.project.projectStatus.toString(),
                            ),
                            backgroundColor: MyColors.pinkColor,
                          ),
                          // DropdownButton(
                          //   style: TextStyle(
                          //       fontSize: 14, color: Colors.black),
                          //   underline: null,
                          //   value: projectStatus,
                          //   items: [
                          //     const DropdownMenuItem(
                          //       value: 'In Progress',
                          //       child: Text('In Progress'),
                          //     ),
                          //     const DropdownMenuItem(
                          //       value: 'In Revision',
                          //       child: Text('In Revision'),
                          //     ),
                          //     const DropdownMenuItem(
                          //       value: 'Completed',
                          //       child: Text('Completed'),
                          //     ),
                          //     const DropdownMenuItem(
                          //       value: 'Cancelled',
                          //       child: Text('Cancelled'),
                          //     ),
                          //   ],
                          //   onChanged: (value) {
                          //     projectStatus = value;
                          //     setState(() {});
                          //   },
                          // )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            if (index == 0) {
                              isDescriptionExpanded = !isDescriptionExpanded;
                            } else if (index == 1) {
                              isModulesExpanded = !isModulesExpanded;
                            } else if (index == 2) {
                              isFilesExpanded = !isFilesExpanded;
                            } else if (index == 3) {
                              isReviewsExpanded = !isReviewsExpanded;
                            }
                          });
                        },
                        children: [
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text('Description'),
                              );
                            },
                            body: ListTile(
                              title: Text(
                                  widget.project.projectDescription.toString()),
                            ),
                            isExpanded: isDescriptionExpanded,
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text('Modules'),
                              );
                            },
                            body: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: widget.project.modules!.length,
                                itemBuilder: ((context, index) {
                                  var module = widget.project.modules![index];
                                  return ListTile(
                                    title: Text(
                                      '${index + 1}) ${module.keys.first}',
                                      style: TextStyle(
                                          decoration:
                                              module.values.first == true
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none),
                                    ),
                                    trailing: UserModel.currentUser.userType ==
                                            UserRoles.EMPLOYEE.name
                                        ? Checkbox(
                                            value: module.values.first,
                                            onChanged: (value) {
                                              projectProvider
                                                  .updateModuleInFirebase(
                                                      widget.project.projectId
                                                          .toString(),
                                                      index,
                                                      value as bool);
                                            },
                                          )
                                        : UserModel.currentUser.userType ==
                                                UserRoles.CLIENT.name
                                            ? InkWell(
                                                onTap: () {
                                                  projectProvider
                                                      .updateModuleInFirebase(
                                                          widget
                                                              .project.projectId
                                                              .toString(),
                                                          index,
                                                          false)
                                                      .then((value) {
                                                    projectProvider
                                                        .updateProjectStatus(
                                                            widget.project
                                                                .projectId
                                                                .toString(),
                                                            'In Revision');
                                                  });
                                                },
                                                child: Icon(Icons.event_repeat))
                                            : Checkbox(
                                                value: module.values.first,
                                                onChanged: (value) {
                                                  projectProvider
                                                      .updateModuleInFirebase(
                                                          widget
                                                              .project.projectId
                                                              .toString(),
                                                          index,
                                                          value as bool);
                                                }),
                                  );
                                }),
                              ),
                            ),
                            isExpanded: isModulesExpanded,
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text('Files'),
                              );
                            },
                            body: widget.project.files != null
                                ? SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount: widget.project.files!.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              style: TextStyle(fontSize: 10),
                                              widget.project
                                                  .files![index]['fileName']
                                                  .toString(),
                                            ),
                                            trailing: Icon(Icons.download),
                                          );
                                        }),
                                  )
                                : Text("No Files Found"),
                            isExpanded: isFilesExpanded,
                          ),
                          if (widget.project.projectStatus == 'Completed')
                            ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text('Review'),
                                );
                              },
                              body: ListTile(
                                subtitle: Text(
                                  widget.project.review != null
                                      ? widget.project.review!['comment']
                                      : "No Comment Given".toString(),
                                ),
                                title: RatingStars(
                                  starCount: 5,
                                  value: widget.project.review!['rating'],
                                ),
                              ),
                              isExpanded: isReviewsExpanded,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Project Progress',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50 + 1,
                            width: (screenWidth),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        width: getProgressWidth(screenWidth).toDouble(),
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: MyColors.pinkPurpleGradient,
                          borderRadius: BorderRadius.circular(50),
                          border: getProgressCount() == 100
                              ? Border.all(color: Colors.black)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${getProgressCount().toString()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomTimerWidget(
                    endDate: widget.project.deadline as DateTime,
                  ),
                  UserModel.currentUser.userType == 'CLIENT'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  projectProvider.updateProjectStatus(
                                      widget.project.projectId.toString(),
                                      'Cancelled');
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.purpleColor),
                                child: Text(
                                  'Cancel Project',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  projectProvider
                                      .updateProjectStatus(
                                          widget.project.projectId.toString(),
                                          'Completed')
                                      .then((value) {
                                    Navigator.pushNamed(
                                        context, RouteName.addReviewScreen,
                                        arguments: {
                                          'projectId': widget.project.projectId,
                                        });
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.pinkColor),
                                child: Text(
                                  'Complete Project',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTimerWidget extends StatefulWidget {
  const CustomTimerWidget({
    super.key,
    required this.endDate,
  });

  final DateTime endDate;

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget>
    with TickerProviderStateMixin {
  late CustomTimerProvider customTimerProvider;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    customTimerProvider =
        Provider.of<CustomTimerProvider>(context, listen: false);

    _initializeTimer();
    if (!checkIfOverdue(widget.endDate)) {
      customTimerProvider.startTimer();
    }

    _streamSubscription = customTimerProvider.timerStream.listen((event) {
      setState(() {});
    });
  }

  void _initializeTimer() {
    final now = DateTime.now();
    final difference = widget.endDate.difference(now);

    if (difference.isNegative) {
      customTimerProvider.setTime(
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
      );
    } else {
      customTimerProvider.setTime(
        days: difference.inDays,
        hours: difference.inHours % 24,
        minutes: difference.inMinutes % 60,
        seconds: difference.inSeconds % 60,
      );
    }
  }

  bool checkIfOverdue(DateTime deadline) {
    DateTime now = DateTime.now();
    return now.isAfter(deadline);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomTimerProvider>(
      builder: (context, timerProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimerDisplayBox(
              label: "Days",
              digit: timerProvider.days.toString(),
            ),
            TimerDisplayBox(
              label: "Hours",
              digit: timerProvider.hours.toString(),
            ),
            TimerDisplayBox(
              label: "Minutes",
              digit: timerProvider.minutes.toString(),
            ),
            TimerDisplayBox(
              label: "Seconds",
              digit: timerProvider.seconds.toString(),
            ),
          ],
        );
      },
    );
  }
}

class TimerDisplayBox extends StatelessWidget {
  const TimerDisplayBox({
    super.key,
    required this.digit,
    required this.label,
  });

  final String? digit;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label.toString(),
          style: const TextStyle(fontSize: 20, height: 2),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            gradient: MyColors.pinkPurpleGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              digit.toString(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
