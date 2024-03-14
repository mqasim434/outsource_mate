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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50,
          ),
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
                    title: 'Task Assignment',
                    text:
                        'Simplify your workload by seamlessly assigning tasks to your team members, and gain real-time insights into their progress, ensuring every project stays on track',
                    img: 'assets/vectors/revenue.jpg',
                  ),
                  IntroPage(
                    title: 'Task Assignment',
                    text:
                        'Simplify your workload by seamlessly assigning tasks to your team members, and gain real-time insights into their progress, ensuring every project stays on track',
                    img: 'assets/vectors/time_mgt.jpg',
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: ThreeDots(
                    pageIndex: pageNumber,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RoundedRectangularButton(
                  buttonText: 'Get Started',
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.dashboardScreen);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
