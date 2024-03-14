import 'package:flutter/cupertino.dart';
import 'package:outsource_mate/models/project_model.dart';

class ProjectProvider extends ChangeNotifier{

  void addProject(ProjectModel project){
    projectsList.add(project);
    notifyListeners();
  }

  int getProjectsTypeCount(String type){
    var filteredProjects = projectsList.where((element){
      return (element.projectStatus == type);
    });

    return filteredProjects.length;
  }


  List<ProjectModel> projectsList = [
    ProjectModel(
      projectTitle: 'Project 1',
      projectDescription: 'Description for Project 1',
      employeeName: 'John Doe',
      startingTime: '2024-03-01T08:00:00',
      deadline: '2024-03-10T08:00:00',
      projectStatus: 'In Progress',
    ),
    ProjectModel(
      projectTitle: 'Project 2',
      projectDescription: 'Description for Project 2',
      employeeName: 'Alice Smith',
      startingTime: '2024-03-02T08:00:00',
      deadline: '2024-03-11T08:00:00',
      projectStatus: 'In Revision',
    ),
    ProjectModel(
      projectTitle: 'Project 3',
      projectDescription: 'Description for Project 3',
      employeeName: 'Bob Johnson',
      startingTime: '2024-03-03T08:00:00',
      deadline: '2024-03-12T08:00:00',
      projectStatus: 'Completed',
    ),
    ProjectModel(
      projectTitle: 'Project 4',
      projectDescription: 'Description for Project 4',
      employeeName: 'Emily Brown',
      startingTime: '2024-03-04T08:00:00',
      deadline: '2024-03-13T08:00:00',
      projectStatus: 'Cancelled',
    ),
    ProjectModel(
      projectTitle: 'Project 5',
      projectDescription: 'Description for Project 5',
      employeeName: 'Michael Wilson',
      startingTime: '2024-03-05T08:00:00',
      deadline: '2024-03-14T08:00:00',
      projectStatus: 'In Progress',
    ),
  ];




}