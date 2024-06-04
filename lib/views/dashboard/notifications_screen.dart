import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context,index){
          return NotificationWidget(
            notificationTitle: 'New Project',
            notificationDescription: 'Create an app Outsource Mate',
            notificationType: (index%2==0)?NotificationType.project:NotificationType.review,
            onTap: (){},
          );
        }),
      )
    ));
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.notificationTitle,
    required this.notificationDescription,
    required this.notificationType,
    required this.onTap,
  });

  final String? notificationTitle;
  final String? notificationDescription;
  final NotificationType? notificationType;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: notificationType == NotificationType.project
            ? MyColors.pinkColor
            : MyColors.purpleColor,
        child: ListTile(
          leading: notificationType == NotificationType.project
              ? const Icon(Icons.task)
              : const Icon(Icons.notifications),
          title: Text(notificationTitle.toString()),
          subtitle: Text(notificationDescription.toString()),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

enum NotificationType {
  project,
  review,
}
