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
  String? deviceToken;
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
    this.projects = const [],
    this.deviceToken,
  });
  static dynamic currentUser;
}

class EmployeeModel extends UserModel {
  String? empId;
  String? position;
  String? password;
  List<String>? freelancersList;

  EmployeeModel({
    super.name,
    super.email,
    super.phone,
    super.projects = const [],
    super.userType,
    super.imageUrl,
    super.isOnline,
    super.isTyping,
    super.lastSeen,
    super.deviceToken,
    this.position,
    this.password,
    this.empId,
    this.freelancersList,
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
    userType = json['userType'];
    isOnline = json['isOnline'];
    isTyping = json['isTyping'];
    lastSeen = json['lastSeen'];
    deviceToken = json['deviceToken'];
    if (json['freelancersList'] != null) {
      freelancersList = [];
      json['freelancersList'].forEach((value) {
        freelancersList!.add(value);
      });
    }
    if (json['projects'] != null) {
      projects = [];
      json['projects'].forEach((v) {
        projects!.add(ProjectModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['position'] = position;
    data['empId'] = empId;
    data['imageUrl'] = imageUrl;
    data['userType'] = userType;
    data['isOnline'] = isOnline;
    data['isTyping'] = isTyping;
    data['lastSeen'] = lastSeen;
    data['deviceToken'] = deviceToken;
    if (freelancersList != null) {
      {
        data['freelancersList'] = freelancersList!.map((e) => e).toList();
      }
    }
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String _generateEmployeeId() {
    var random = Random();
    return 'EMP-OM${random.nextInt(9000) + 1000}';
  }
}

class FreelancerModel extends UserModel {
  List<String>? clientsList;
  List<String>? employeesList;
  FreelancerModel(
      {super.name,
      super.email,
      super.phone,
      super.imageUrl,
      super.userType,
      super.isOnline,
      super.isTyping,
      super.lastSeen,
      super.projects = const [],
      super.deviceToken,
      this.clientsList,
      this.employeesList});

  FreelancerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    imageUrl = json['imageUrl'];
    userType = json['userType'];
    isOnline = json['isOnline'];
    isTyping = json['isTyping'];
    lastSeen = json['lastSeen'];
    deviceToken = json['deviceToken'];
    if (json['projects'] != null) {
      projects = [];
      json['projects'].forEach((v) {
        projects!.add(ProjectModel.fromJson(v));
      });
    }
    if (json['clientsList'] != null) {
      clientsList = [];
      json['clientsList'].forEach((value) {
        clientsList!.add(value);
      });
    }
    if (json['employeesList'] != null) {
      employeesList = [];
      json['employeesList'].forEach((value) {
        employeesList!.add(value);
      });
    }
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
    data['deviceToken'] = deviceToken;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    if (clientsList != null) {
      {
        data['clientsList'] = clientsList!.map((e) => e).toList();
      }
    }
    if (employeesList != null) {
      {
        data['employeesList'] = employeesList!.map((e) => e).toList();
      }
    }
    return data;
  }
}

class ClientModel extends UserModel {
  List<String>? freelancersList;
  ClientModel({
    super.name,
    super.email,
    super.phone,
    super.imageUrl,
    super.userType,
    super.isOnline,
    super.isTyping,
    super.lastSeen,
    super.projects = const [],
    super.deviceToken,
    this.freelancersList,
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
    deviceToken = json['deviceToken'];
    if (json['projects'] != null) {
      projects = [];
      json['projects'].forEach((v) {
        projects!.add(ProjectModel.fromJson(v));
      });
    }
    if (json['freelancersList'] != null) {
      freelancersList = [];
      json['freelancersList'].forEach((value) {
        freelancersList!.add(value);
      });
    }
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
    data['deviceToken'] = deviceToken;
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    if (freelancersList != null) {
      {
        data['freelancersList'] = freelancersList!.map((e) => e).toList();
      }
    }
    return data;
  }
}
