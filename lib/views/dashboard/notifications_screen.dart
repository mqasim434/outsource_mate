// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/notification_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/notifications_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/enums.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationsProvider notificationsProvider = NotificationsProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);
    notificationsProvider.fetchNotifications();
  }

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .where('userId', isEqualTo: UserModel.currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            } else if (snapshot.hasData) {
              var notifications = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  return NotificationWidget(
                      notificationTitle: notification['title'],
                      notificationDescription: notification['description'],
                      notificationType: notification['notificationType'],
                      onTap: () {});
                },
              );
            } else {
              return Center(
                child: Text('No Notifications Yet'),
              );
            }
          }),
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
  final String? notificationType;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: notificationType == NotificationTypes.PROJECT.name
              ? MyColors.pinkColor
              : MyColors.purpleColor,
          child: ListTile(
            leading: notificationType == NotificationTypes.PROJECT.name
                ? const Icon(Icons.task)
                : const Icon(Icons.notifications),
            title: Text(notificationTitle.toString()),
            subtitle: Text(notificationDescription.toString()),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
