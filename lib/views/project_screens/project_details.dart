import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/providers/custom_timer_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
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

  @override
  Widget build(BuildContext context) {
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
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.7,
                  child: Text(
                    widget.project.projectTitle.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.project.projectDescription.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Modules',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.project.modules!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: MyColors.purpleColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(height: 0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      widget.project.modules?[index] != null
                          ? Text(
                              widget.project.modules![index].keys
                                  .toList()
                                  .first,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: widget
                                            .project.modules![index].values
                                            .toList()
                                            .first ==
                                        false
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough,
                              ),
                            )
                          : const Text('data'),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Change Module Status'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RadioListTile(
                                          title: const Text('Not Completed'),
                                          value: 'Not Completed',
                                          groupValue: widget.project
                                                      .modules![index].values
                                                      .toList()
                                                      .first ==
                                                  true
                                              ? 'Completed'
                                              : 'Not Completed',
                                          onChanged: (String? newValue) {},
                                        ),
                                        RadioListTile(
                                          title: const Text('Completed'),
                                          value: 'Completed',
                                          groupValue: widget.project
                                                      .modules![index].values
                                                      .toList()
                                                      .first ==
                                                  true
                                              ? 'Completed'
                                              : 'Not Completed',
                                          onChanged: (String? newValue) {},
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                          )),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Project Progress',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 50 + 1,
                  width: (screenWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
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
              days: DateTime.now().day,
              hours: DateTime.now().hour,
              minutes: DateTime.now().month,
              seconds: DateTime.now().second,
            ),
          ],
        ),
      ),
    ));
  }
}

class CustomTimerWidget extends StatefulWidget {
  const CustomTimerWidget({
    super.key,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  @override
  State<CustomTimerWidget> createState() => _CustomTimerWidgetState();
}

class _CustomTimerWidgetState extends State<CustomTimerWidget> {
  late CustomTimerProvider customTimerProvider;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    customTimerProvider =
        Provider.of<CustomTimerProvider>(context, listen: false);
    customTimerProvider.setTime(
      days: widget.days,
      hours: widget.hours,
      minutes: widget.minutes,
      seconds: widget.seconds,
    );
    _streamSubscription = customTimerProvider.timerStream.listen((_) {
      setState(() {});
    });
    customTimerProvider.startTimer();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: customTimerProvider.timerStream,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimerDisplayBox(
              label: "Days",
              digit: customTimerProvider.days.toString(),
            ),
            TimerDisplayBox(
              label: "Hours",
              digit: customTimerProvider.hours.toString(),
            ),
            TimerDisplayBox(
              label: "Minutes",
              digit: customTimerProvider.minutes.toString(),
            ),
            TimerDisplayBox(
              label: "Seconds",
              digit: customTimerProvider.seconds.toString(),
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
