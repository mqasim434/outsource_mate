import 'package:flutter/material.dart';

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int daysInMonth = DateTime(year, month + 1, 0).day;

    List<Widget> calendarDays = [];

    // Add the days of the month to the calendarDays list
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(year, month, day);
      calendarDays.add(
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            '$day',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      );
    }

    // Create rows for the calendar
    List<Widget> rows = [];
    for (int i = 0; i < calendarDays.length; i += 7) {
      List<Widget> rowChildren = calendarDays.sublist(
          i, i + 7 < calendarDays.length ? i + 7 : calendarDays.length);
      rows.add(Row(children: rowChildren));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Column(children: rows),
          ],
        ),
      ),
    );
  }
}