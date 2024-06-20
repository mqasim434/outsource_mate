import 'dart:math';

class NotificationModel {
  String? id;
  String? title;
  String? description;
  String? userId;
  DateTime? time;
  String? notificationType;
  String? icon;

  NotificationModel(
      {this.id,
      this.title,
      this.description,
      this.userId,
      this.time,
      this.notificationType,
      this.icon}) {
    id = Random.secure().toString();
  }

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    time = json['time'];
    notificationType = json['notificationType'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['time'] = time!.toIso8601String();
    data['notificationType'] = notificationType;
    data['icon'] = icon;
    return data;
  }
}
