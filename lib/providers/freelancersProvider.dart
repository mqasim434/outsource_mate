import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';

class FreelancersProvider extends ChangeNotifier{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<FreelancerModel> _freelancersList = [];

  List<FreelancerModel> get freelancersList => _freelancersList;

  Future<void> fetchFreelancers() async {
    EasyLoading.show(status: 'Loading');
    final QuerySnapshot result = await firebaseFirestore.collection('freelancers').get();
    _freelancersList = result.docs.map((DocumentSnapshot doc) => FreelancerModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    print(freelancersList[0].name);
    notifyListeners();
    EasyLoading.dismiss();
  }



  Future<void> assignProjectToEmployee(String email, ProjectModel project) async {
    Map<String,dynamic> projectData = project.toJson();
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore.collection('employees').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot freelancerDoc = querySnapshot.docs.first;
        List<dynamic> projects = freelancerDoc.get('projects') ?? [];
        projects.add(projectData);
        await freelancerDoc.reference.update({'projects': projects});

        print('Project assigned to Employee successfully!');
      } else {
        print('No Employee found with the given email.');
      }
    } catch (e) {
      print('Error adding project: $e');
    }
  }




}