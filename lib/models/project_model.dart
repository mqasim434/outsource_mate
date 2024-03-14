class ProjectModel {
  String? projectTitle;
  String? projectDescription;
  String? employeeName;
  String? startingTime;
  String? deadline;
  String? projectStatus;

  ProjectModel(
      {this.projectTitle,
      this.projectDescription,
      this.employeeName,
      this.startingTime,
      this.deadline,
      this.projectStatus});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    projectTitle = json['projectTitle'];
    projectDescription = json['projectDescription'];
    employeeName = json['employeeName'];
    startingTime = json['startingTime'];
    deadline = json['deadline'];
    projectStatus = json['projectStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectTitle'] = projectTitle;
    data['projectDescription'] = projectDescription;
    data['employeeName'] = employeeName;
    data['startingTime'] = startingTime;
    data['deadline'] = deadline;
    data['projectStatus'] = projectStatus;
    return data;
  }
}

