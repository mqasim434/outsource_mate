import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/signin_provider.dart';

class ProjectProvider extends ChangeNotifier {
  List<ProjectModel> _projectsList = [];

  List<ProjectModel> get projectsList => _projectsList;

  List<Map<String,bool>> modules = [];
  String? fileUrl;

  void addModule(Map<String,bool> module){
    modules.add(module);
    notifyListeners();
  }

  void addFileUrl(String url){
    fileUrl = url;
    notifyListeners();
  }

  void getProjects(String email, String collection) async {
    print("Getting Projects");
    EasyLoading.show(status: 'Fetching Projects');
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);

    if (!result.exists) {
      EasyLoading.dismiss();
      return null;
    } else {
      final Map<String, dynamic> userData = result.data() as Map<String, dynamic>;
      final List<dynamic> projectsData = userData['projects'] ?? [];
      final List<ProjectModel> projects = projectsData.map((projectData) => ProjectModel.fromJson(projectData)).toList();
      _projectsList = projects;
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  String getCollectionName(String userRole){
    if(userRole==UserRoles.FREELANCER.name){
      return 'freelancers';
    }else if(userRole==UserRoles.CLIENT.name){
      return 'clients';
    }
    else if(userRole==UserRoles.EMPLOYEE.name){
      return 'employees';
    }else{
      return 'N/A';
    }
  }
  void addProject(ProjectModel project) async{
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(getCollectionName(UserModel.currentUser.userType))
        .where('email', isEqualTo: UserModel.currentUser.email)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      throw Exception('User not found');
    }

    final DocumentSnapshot document = result.docs.first;
    final Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
    final List<dynamic> projects = userData['projects'] ?? [];
    projects.add(project.toJson());

    await document.reference.update({
      'projects': projects,
    });
  }

  int getProjectsTypeCount(String type) {
    var filteredProjects = _projectsList.where((element) {
      return (element.projectStatus == type);
    });

    return filteredProjects.length;
  }



  int selectedProjectIndex = -1;

  void updateIndex(int index){
    selectedProjectIndex = index;
    notifyListeners();
  }
}
