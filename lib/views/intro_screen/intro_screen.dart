import 'package:flutter/material.dart';
import 'package:outsource_mate/res/components/three_dots.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/intro_screen/intro_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController();
  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  pageNumber = value;
                });
              },
              scrollDirection: Axis.horizontal,
              children: [
                IntroPage(
                  title: 'Task Assignment',
                  text:
                      'Simplify your workload by seamlessly assigning tasks to your team members, and gain real-time insights into their progress, ensuring every project stays on track',
                  img: 'assets/vectors/task_assignment.jpg',
                ),
                IntroPage(
                  title: 'Employee Management',
                  text:
                      "Efficiently manage your team by monitoring their performance, providing feedback, and fostering a collaborative work environment. Ensure that each employee's strengths are utilized, contributing to the overall success of your projects.",
                  img: 'assets/vectors/revenue.jpg',
                ),
                IntroPage(
                  title: 'Time Management',
                  text:
                      'Optimize your productivity by effectively managing your time. Track deadlines, set priorities, and allocate resources wisely to ensure every project is completed on schedule, minimizing stress and maximizing output.',
                  img: 'assets/vectors/time_mgt.jpg',
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
                child: ThreeDots(
                  pageIndex: pageNumber,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
                  bottom: 50,
                ),
                child: RoundedRectangularButton(
                  buttonText: 'Get Started',
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.dashboard);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
