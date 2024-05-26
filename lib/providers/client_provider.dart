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
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> addProjectToFreelancerByEmail(String email, ProjectModel project) async {
    Map<String,dynamic> projectData = project.toJson();
    try {
      QuerySnapshot querySnapshot = await _db.collection('freelancers').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
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
}