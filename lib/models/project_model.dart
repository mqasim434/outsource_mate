class ProjectModel {
  String? projectTitle;
  String? projectDescription;
  String? employeeName;
  String? freelancerName;
  String? clientName;
  String? startingTime;
  String? deadline;
  String? projectStatus;

  ProjectModel(
      {this.projectTitle,
      this.projectDescription,
      this.employeeName,
      this.freelancerName,
      this.clientName,
      this.startingTime,
      this.deadline,
      this.projectStatus});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    projectTitle = json['projectTitle'];
    projectDescription = json['projectDescription'];
    employeeName = json['employeeName'];
    freelancerName = json['freelancerName'];
    clientName = json['clientName'];
    startingTime = json['startingTime'];
    deadline = json['deadline'];
    projectStatus = json['projectStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectTitle'] = projectTitle;
    data['projectDescription'] = projectDescription;
    data['employeeName'] = employeeName;
    data['freelancerName'] = freelancerName;
    data['clientName'] = clientName;
    data['startingTime'] = startingTime;
    data['deadline'] = deadline;
    data['projectStatus'] = projectStatus;
    return data;
  }
}
