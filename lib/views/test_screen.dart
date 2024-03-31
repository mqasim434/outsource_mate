import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../res/components/switch_button_widget.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final switchProvider = Provider.of<SwitchButtonProvider>(context);
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    List<Widget> screensList = [
      const Center(
          child: Text(
            'Screen 1',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      const Center(
          child: Text(
            'Screen 2',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test Screen'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: Colors.deepPurpleAccent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SwitchButton(),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now(),
                      );
                    },
                    child: const Icon(
                      Icons.calendar_month,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return DateWidget(
                          day: DateTime.now().day.toString(),
                          date:
                              '${DateTime.now().day} ${months[DateTime.now().month]}',
                        );
                      },
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: Colors.black,
                    indent: 40,
                    endIndent: 40,
                  ),
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: switchProvider.pageController,

                children: screensList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.day,
    required this.date,
  });

  final String day;
  final String date;

  @override
  Widget build(BuildContext context) {
    bool isToday = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          date,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            color: isToday ? Colors.yellow : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
