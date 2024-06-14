class ProjectModel {
  String? projectTitle;
  String? projectDescription;
  String? employeeName;
  String? freelancerName;
  String? clientName;
  DateTime? startingTime;
  DateTime? deadline;
  String? projectStatus;
  List<Map<String, bool>>? modules;
  String? fileUrl;

  ProjectModel({
    this.projectTitle,
    this.projectDescription,
    this.employeeName,
    this.freelancerName,
    this.clientName,
    this.startingTime,
    this.deadline,
    this.projectStatus,
    this.modules,
    this.fileUrl,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    projectTitle = json['projectTitle'];
    projectDescription = json['projectDescription'];
    employeeName = json['employeeName'];
    freelancerName = json['freelancerName'];
    clientName = json['clientName'];
    startingTime = DateTime.parse(json['startingTime']);
    deadline = DateTime.parse(json['deadline']);
    projectStatus = json['projectStatus'];
    modules = json['modules'] != null
        ? List<Map<String, bool>>.from(
            json['modules'].map((x) => Map<String, bool>.from(x)))
        : null;
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectTitle'] = projectTitle;
    data['projectDescription'] = projectDescription;
    data['employeeName'] = employeeName;
    data['freelancerName'] = freelancerName;
    data['clientName'] = clientName;
    data['startingTime'] = startingTime!.toIso8601String();
    data['deadline'] = deadline!.toIso8601String();
    data['projectStatus'] = projectStatus;
    data['modules'] = modules;
    data['fileUrl'] = fileUrl;
    return data;
  }
}
