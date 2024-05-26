import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/signin_provider.dart';

class UtilityFunctions {
  static String getCollectionName(String role) {
    if (role == UserRoles.FREELANCER.name) {
      return 'freelancers';
    } else if (role == UserRoles.CLIENT.name) {
      return 'clients';
    } else if (role == UserRoles.EMPLOYEE.name) {
      return 'employees';
    } else {
      return 'N/A';
    }
  }

  static EmployeeModel convertDocumentToUserModel(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    String? name = json['name'];
    String? email = json['email'];
    String? phone = json['phone'];
    String? position = json['position'];
    String? empId = json['empId'];
    String? password = json['password'];
    String? imageUrl = json['imageUrl'];
    List<ProjectModel> projects = (json['projects'] as List)
        .map((project) => ProjectModel.fromJson(project as Map<String, dynamic>))
        .toList();
    String? userType = json['userType'];
    bool? isOnline = json['isOnline'];
    bool? isTyping = json['isTyping'];
    String? lastSeen = json['lastSeen'];

    return EmployeeModel(
      name: name,
      email: email,
      phone: phone,
      position: position,
      empId: empId,
      password: password,
      projects: projects,
      userType: userType,
      imageUrl: imageUrl,
      isOnline: isOnline,
      isTyping: isTyping,
      lastSeen: lastSeen
    );
  }
}
