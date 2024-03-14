class UserModel {
  String? name;
  String? email;
  String? phone;
  String? role;
  String? empId;

  UserModel({this.name, this.email, this.phone, this.role, this.empId});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    empId = json['empId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['empId'] = empId;
    return data;
  }
}
