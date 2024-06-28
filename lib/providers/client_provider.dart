import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';

class ClientProvider extends ChangeNotifier{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<ClientModel> _clientsList = [];

  List<ClientModel> get clientsList => _clientsList;

  Future<void> fetchClients() async {
    EasyLoading.show(status: 'Loading');
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('clients').get();
    _clientsList = result.docs.map((DocumentSnapshot doc) => ClientModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    print(_clientsList[0].name);
    EasyLoading.dismiss();
    notifyListeners();
    
  }

  Future<void> addProjectToFreelancerByEmail(String email, ProjectModel project) async {
    print('HELLO');
    print(email);
    Map<String,dynamic> projectData = project.toJson();
    try {
      QuerySnapshot querySnapshot = await _db.collection('freelancers').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        print(project.toString());
        DocumentSnapshot freelancerDoc = querySnapshot.docs.first;
        List<dynamic> projects = freelancerDoc.get('projects') ?? [];
        projects.add(projectData);
        await freelancerDoc.reference.update({'projects': projects});

        print('Project added successfully!');
      } else {
        print('No freelancer found with the given email.');
      }
    } catch (e) {
      print('Error adding project: $e');
    }
  }

  Future<void> addEmailToFreelancersList(String newEmailToAdd) async {
  try {
    // Reference to the 'clients' collection in Firestore
    final clientsRef = FirebaseFirestore.instance.collection('clients');

    // Query to find the client document based on email
    QuerySnapshot querySnapshot = await clientsRef.where('email', isEqualTo: UserModel.currentUser.email).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there's only one client document per unique email (or handling if multiple found)
      DocumentSnapshot clientSnapshot = querySnapshot.docs.first;

      // Retrieve the current freelancers list from the document
      List<String> currentFreelancers = List<String>.from(clientSnapshot['freelancers']);

      // Add the new email to the freelancers list if it's not already present
      if (!currentFreelancers.contains(newEmailToAdd)) {
        currentFreelancers.add(newEmailToAdd);

        // Update the document in Firestore with the updated freelancers list
        await clientsRef.doc(clientSnapshot.id).update({'freelancers': currentFreelancers});
        
        print('Email added to freelancers list successfully.');
      } else {
        print('Email $newEmailToAdd already exists in the freelancers list.');
      }
    } else {
      print('Client document not found for email: ${UserModel.currentUser.email}');
    }
  } catch (e) {
    print('Error adding email to freelancers list: $e');
  }
}
}