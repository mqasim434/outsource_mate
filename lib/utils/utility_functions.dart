import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  static DateTime calculateRemainingTime(
      DateTime startTime, DateTime deadline) {
    DateTime currentTime = DateTime.now();
    DateTime remainingTime =
        DateTime.parse(deadline.difference(currentTime).toString());
    return remainingTime;
  }

  static Future<String> uploadFileToFirebaseStorage(String filePath) async {
    print('Uploading file');
    EasyLoading.show(status: 'Uploading File');
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chat_files')
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    final UploadTask uploadTask = storageReference.putFile(File(filePath));

    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    EasyLoading.dismiss();
    return downloadUrl;
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
    List<ProjectModel> projects = (json['projects'] as List<dynamic>)
        .map(
            (project) => ProjectModel.fromJson(project as Map<String, dynamic>))
        .toList();
    String? userType = json['userType'];
    bool? isOnline = json['isOnline'];
    bool? isTyping = json['isTyping'];
    String? lastSeen = json['lastSeen'];
    List<String> freelancersList = (json['freelancersList'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

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
      lastSeen: lastSeen,
      freelancersList: freelancersList,
    );
  }
}
