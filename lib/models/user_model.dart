import 'dart:math';

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
  });

  static dynamic currentUser;

}

class EmployeeModel extends UserModel {
  String? empId;
  String? position;
  String? password;

  EmployeeModel({
    super.name,
    super.email,
    super.phone,
    this.position,
    this.password,
  }){
    empId = _generateEmployeeId();
    password = empId;
  }

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    position = json['position'];
    empId = json['empId'];
    password = json['password'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['position'] = position;
    data['empId'] = empId;
    data['imageUrl'] = imageUrl;
    return data;
  }

  String _generateEmployeeId() {
    var random = Random();
    return 'EMP-OM${random.nextInt(9000) + 1000}';
  }
}


class FreelancerModel extends UserModel {
  FreelancerModel({
    super.name,
    super.email,
    super.phone,
    super.imageUrl,
  });

  FreelancerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class ClientModel extends UserModel {
  ClientModel({
    super.name,
    super.email,
    super.phone,
    super.imageUrl,
  });

  ClientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }

}
