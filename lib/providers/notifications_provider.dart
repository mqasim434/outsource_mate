import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/notification_model.dart';
import 'package:outsource_mate/models/user_model.dart';

class NotificationsProvider extends ChangeNotifier {
  final List<NotificationModel> _notificationsList = [];

  List<NotificationModel> get notificationsList => _notificationsList;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> fetchNotifications() async {
    EasyLoading.show(status: 'Fetching Notifications');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection('notifications')
        .where('userId', isEqualTo: UserModel.currentUser.email)
        .get();

    querySnapshot.docs.map((e) {
      print(e);
      _notificationsList.add(NotificationModel.fromJson(e.data()));
    });
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> addNotification(NotificationModel notification) async {
    firebaseFirestore.collection('notifications').add(notification.toJson());
    notifyListeners();
  }
}
