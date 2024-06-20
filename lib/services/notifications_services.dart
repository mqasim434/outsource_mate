// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage notification) {
      print(notification.notification?.title);
      if (Platform.isAndroid) {
        initNotifications(context, notification);
        showNotification(notification);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage notification) {
      handleNotificationClick(context, notification);
    });
  }

  showNotification(RemoteMessage message) async {
    const String projectId =
        'outsource-mate-f4c50'; // Replace with your actual Firebase project ID
    final String jsonCredentials = await rootBundle
        .loadString('assets/outsource-mate-f4c50-797eec49eae5.json');
    final creds = auth.ServiceAccountCredentials.fromJson(jsonCredentials);

    final client = await auth.clientViaServiceAccount(
      creds,
      ['https://www.googleapis.com/auth/firebase.messaging'],
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id', // Use a fixed channel ID
      "Notifications Channel",
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Ticker',
    );

    final notificationData = {
      'message': {
        'token': message.data['token'](),
        'notification': {
          'title': message.data['title'],
          'body': message.data['message'],
        }
      },
    };

    final response = await client.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode(notificationData),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        1,
        message.data['title'],
        message.data['message'],
        notificationDetails,
      );
    });

    client.close();

    if (response.statusCode == 200) {
      return true; // Success!
    } else {
      print('Failed to send notification: ${response.statusCode}');
      return false;
    }
  }

  void initNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleNotificationClick(context, message);
      },
    );
  }

  void handleNotificationClick(BuildContext context, RemoteMessage message) {
    String? type = message.data['type'];
    if (type == 'chat') {
      Navigator.pushNamed(context, '/chat');
    } else if (type == 'project') {
      Navigator.pushNamed(context, '/project');
    }
  }

  void requestNotificationPermissions() async {
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('Authorized');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Provisional');
    } else {
      print('Not Authorized');
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    print('Token $token');
    return token;
  }

  void refreshToken() {
    firebaseMessaging.onTokenRefresh.listen((String token) {
      print('Token refreshed: $token');
    });
  }
}
