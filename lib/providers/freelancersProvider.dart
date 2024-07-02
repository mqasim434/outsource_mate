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

  Future<void> addEmployeeEmailToFreelnacerList({required String employeeEmail}) async {
    try {
      // Reference to the 'clients' collection in Firestore
      final clientsRef = FirebaseFirestore.instance.collection('freelancers');

      // Query to find the client document based on email
      QuerySnapshot querySnapshot = await clientsRef
          .where('email', isEqualTo: UserModel.currentUser.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one client document per unique email (or handling if multiple found)
        DocumentSnapshot clientSnapshot = querySnapshot.docs.first;

        List<String> currentFreelancers =
            List<String>.from(clientSnapshot['employeesList']);

        if (!currentFreelancers.contains(employeeEmail)) {
          currentFreelancers.add(employeeEmail);
          await clientsRef
              .doc(clientSnapshot.id)
              .update({'employeesList': currentFreelancers});

          print('Email added to Employees list successfully.');
        } else {
          print(
              'Email $employeeEmail already exists in the Employees list.');
        }
      } else {
        print(
            'Employees document not found for email: ${UserModel.currentUser.email}');
      }
    } catch (e) {
      print('Error adding email to Employees list: $e');
    }
  }
  Future<void> addFreelancerEmailToEmployeeList({required String freelancerEmail,required String employeeEmail}) async {
    try {
      // Reference to the 'clients' collection in Firestore
      final clientsRef = FirebaseFirestore.instance.collection('employees');

      // Query to find the client document based on email
      QuerySnapshot querySnapshot = await clientsRef
          .where('email', isEqualTo: employeeEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one client document per unique email (or handling if multiple found)
        DocumentSnapshot clientSnapshot = querySnapshot.docs.first;

        List<String> currentFreelancers =
            List<String>.from(clientSnapshot['freelancersList']);

        if (!currentFreelancers.contains(freelancerEmail)) {
          currentFreelancers.add(freelancerEmail);
          await clientsRef
              .doc(clientSnapshot.id)
              .update({'freelancersList': currentFreelancers});

          print('Email added to Freelancers list successfully.');
        } else {
          print(
              'Email $freelancerEmail already exists in the Freelancers list.');
        }
      } else {
        print(
            'Freelancers document not found for email: ${UserModel.currentUser.email}');
      }
    } catch (e) {
      print('Error adding email to freelancers list: $e');
    }
  }
}
