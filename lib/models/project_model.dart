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
  bool? assigned;
  List<Map<String, bool>>? modules;
  List<Map<String, String>>? files;
  Map<String, dynamic>? review;

  // Static counter to keep track of project IDs
  static int _counter = 1;

  ProjectModel(
      {this.projectTitle,
      this.projectDescription,
      this.employeeEmail,
      this.freelancerEmail,
      this.clientEmail,
      this.startingTime,
      this.deadline,
      this.projectStatus,
      this.modules,
      this.files,
      this.assigned = false,
      this.review}) {
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
    review = json['review'];
    assigned = json['assigned'];
    modules = json['modules'] != null
        ? List<Map<String, bool>>.from(
            json['modules'].map((x) => Map<String, bool>.from(x)))
        : null;
    files = json['files'] != null
        ? List<Map<String, String>>.from(
            json['files'].map((x) => Map<String, String>.from(x)))
        : null;
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
    data['files'] = files;
    data['review'] = review;
    data['assigned'] = assigned;
    return data;
  }

  void updateModuleByIndex(int index, bool newValue) {
    if (modules != null && index >= 0 && index < modules!.length) {
      String key = modules![index].keys.first;
      modules![index][key] = newValue;
    }
  }
}
