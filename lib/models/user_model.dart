import 'dart:math';

import 'package:outsource_mate/models/project_model.dart';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  String? userType;
  bool? isOnline;
  bool? isTyping;
  String? lastSeen;
  List<ProjectModel>? projects;
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.userType,
    this.isOnline,
    this.isTyping,
    this.lastSeen,
    this.projects,
  });
  static dynamic currentUser;
}

class EmployeeModel extends UserModel {
  String? empId;
  String? position;
  String? password;

  EmployeeModel({
    super.name,
    super.email,
    super.phone,
    super.projects,
    super.userType,
    super.imageUrl,
    super.isOnline,
    super.isTyping,
    super.lastSeen,
    this.position,
    this.password,
    this.empId,
  }) {
    empId = _generateEmployeeId();
    password = empId;
  }

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    position = json['position'];
    empId = json['empId'];
    password = json['password'];
    imageUrl = json['imageUrl'];
    projects = projects;
    userType = json['userType'];
    isOnline = json['isOnline'];
    isTyping = json['isTyping'];
    lastSeen = json['lastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['position'] = position;
    data['empId'] = empId;
    data['imageUrl'] = imageUrl;
    projects = projects;
    data['userType'] = userType;
    data['isOnline'] = isOnline;
    data['isTyping'] = isTyping;
    data['lastSeen'] = lastSeen;
    return data;
  }

  String _generateEmployeeId() {
    var random = Random();
    return 'EMP-OM${random.nextInt(9000) + 1000}';
  }
}

class FreelancerModel extends UserModel {
  FreelancerModel({
    super.name,
    super.email,
    super.phone,
    super.imageUrl,
    super.userType,
    super.isOnline,
    super.isTyping,
    super.lastSeen,
    super.projects,
  });

  FreelancerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    userType = json['userType'];
    isOnline = json['isOnline'];
    isTyping = json['isTyping'];
    lastSeen = json['lastSeen'];
    projects = projects;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['imageUrl'] = imageUrl;
    data['userType'] = userType;
    data['isOnline'] = isOnline;
    data['isTyping'] = isTyping;
    data['lastSeen'] = lastSeen;
    projects = projects;
    return data;
  }
}

class ClientModel extends UserModel {
  ClientModel({
    super.name,
    super.email,
    super.phone,
    super.imageUrl,
    super.userType,
    super.isOnline,
    super.isTyping,
    super.lastSeen,
    super.projects,
  });

  ClientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    userType = json['userType'];
    isOnline = json['isOnline'];
    isTyping = json['isTyping'];
    lastSeen = json['lastSeen'];
    projects = projects;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['imageUrl'] = imageUrl;
    data['userType'] = userType;
    data['isOnline'] = isOnline;
    data['isTyping'] = isTyping;
    data['lastSeen'] = lastSeen;
    projects = projects;
    return data;
  }
}
