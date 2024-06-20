// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/signin_provider.dart';

class ProjectProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final List<ProjectModel> _projectsList = [];

  List<ProjectModel> get projectsList => _projectsList;

  List<Map<String, bool>> modules = [];
  String? fileUrl;

  void addModule(Map<String, bool> module) {
    modules.add(module);
    notifyListeners();
  }

  void addFileUrl(String url) {
    fileUrl = url;
    notifyListeners();
  }

  Future<void> updateModuleInFirebase(
      String projectId, int index, bool newValue) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('projects')
          .where('projectId', isEqualTo: projectId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        ProjectModel project = ProjectModel.fromJson(data);

        project.updateModuleByIndex(index, newValue);

        await firebaseFirestore
            .collection('projects')
            .doc(doc.id)
            .update(project.toJson());
        getProjects();
        notifyListeners();
        print('Module updated successfully.');
      } else {
        print('Project with given projectId does not exist.');
      }
    } catch (e) {
      print('Error updating module: $e');
    }
  }

  Future<void> updateProjectStatus(
    String projectId,
    String status,
  ) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('projects')
          .where('projectId', isEqualTo: projectId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        ProjectModel project = ProjectModel.fromJson(data);
        project.projectStatus = status;
        await firebaseFirestore
            .collection('projects')
            .doc(doc.id)
            .update(project.toJson());
        getProjects();
        notifyListeners();
        print('Project Staus Changed to $status successfully.');
      } else {
        print('Project with given projectId does not exist.');
      }
    } catch (e) {
      print('Error updating module: $e');
    }
  }

  Future<void> getProjects() async {
    print("Getting Projects");
    EasyLoading.show(status: 'Fetching Projects');

    try {
      String emailField;

      switch (UserModel.currentUser.userType) {
        case 'CLIENT':
          emailField = 'clientEmail';
          break;
        case 'FREELANCER':
          emailField = 'freelancerEmail';
          break;
        case 'EMPLOYEE':
          emailField = 'employeeEmail';
          break;
        default:
          throw Exception("Invalid user type");
      }

      QuerySnapshot<Map<String, dynamic>> response = await firebaseFirestore
          .collection("projects")
          .where(emailField, isEqualTo: UserModel.currentUser.email)
          .get();

      projectsList.clear();
      for (var project in response.docs) {
        projectsList.add(ProjectModel.fromJson(project.data()));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  String getCollectionName(String userRole) {
    if (userRole == UserRoles.FREELANCER.name) {
      return 'freelancers';
    } else if (userRole == UserRoles.CLIENT.name) {
      return 'clients';
    } else if (userRole == UserRoles.EMPLOYEE.name) {
      return 'employees';
    } else {
      return 'N/A';
    }
  }

  Future<void> addProject(ProjectModel project, BuildContext context) async {
    EasyLoading.show(status: 'Addding Project');
    try {
      firebaseFirestore.collection("projects").add(project.toJson());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Project Added Successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    EasyLoading.dismiss();
  }

  int getProjectsTypeCount(String type) {
    var filteredProjects = _projectsList.where((element) {
      return (element.projectStatus == type);
    });

    return filteredProjects.length;
  }

  int selectedProjectIndex = -1;

  void updateIndex(int index) {
    selectedProjectIndex = index;
    notifyListeners();
  }

  
}
