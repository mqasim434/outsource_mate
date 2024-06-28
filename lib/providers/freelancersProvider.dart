import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';

class FreelancersProvider extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<FreelancerModel> _freelancersList = [];

  List<FreelancerModel> get freelancersList => _freelancersList;

  Future<void> fetchFreelancers() async {
    EasyLoading.show(status: 'Loading');
    final QuerySnapshot result =
        await firebaseFirestore.collection('freelancers').get();
    _freelancersList = result.docs
        .map((DocumentSnapshot doc) =>
            FreelancerModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    print(freelancersList[0].email);
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future<void> assignProjectToEmployee(
      String email, ProjectModel project) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('projects')
          .where('projectId', isEqualTo: project.projectId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        ProjectModel project = ProjectModel.fromJson(data);
        project.employeeEmail = email;
        await firebaseFirestore
            .collection('projects')
            .doc(doc.id)
            .update(project.toJson());
        notifyListeners();
        print('Project assigned to $email successfully.');
      } else {
        print('Project with given projectId does not exist.');
      }
    } catch (e) {
      print('Error adding project: $e');
    }
  }
}
