class ProjectModel {
  String? projectId;
  String? projectTitle;
  String? projectDescription;
  String? employeeEmail;
  String? freelancerEmail;
  String? clientEmail;
  DateTime? startingTime;
  DateTime? deadline;
  String? projectStatus;
  List<Map<String, bool>>? modules;
  String? fileUrl;

  // Static counter to keep track of project IDs
  static int _counter = 1;

  ProjectModel({
    this.projectTitle,
    this.projectDescription,
    this.employeeEmail,
    this.freelancerEmail,
    this.clientEmail,
    this.startingTime,
    this.deadline,
    this.projectStatus,
    this.modules,
    this.fileUrl,
  }) {
    // Automatically assign projectId
    projectId = 'OM_P_${_counter++}';
  }

  ProjectModel.fromJson(Map<String, dynamic> json) {
    projectTitle = json['projectTitle'];
    projectId = json['projectId'];
    projectDescription = json['projectDescription'];
    employeeEmail = json['employeeEmail'];
    freelancerEmail = json['freelancerEmail'];
    clientEmail = json['clientEmail'];
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
    data['projectId'] = projectId;
    data['projectTitle'] = projectTitle;
    data['projectDescription'] = projectDescription;
    data['employeeEmail'] = employeeEmail;
    data['freelancerEmail'] = freelancerEmail;
    data['clientEmail'] = clientEmail;
    data['startingTime'] = startingTime!.toIso8601String();
    data['deadline'] = deadline!.toIso8601String();
    data['projectStatus'] = projectStatus;
    data['modules'] = modules;
    data['fileUrl'] = fileUrl;
    return data;
  }
  void updateModuleByIndex(int index, bool newValue) {
    if (modules != null && index >= 0 && index < modules!.length) {
      String key = modules![index].keys.first;
      modules![index][key] = newValue;
    }
  }
}
