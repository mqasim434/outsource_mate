import 'package:flutter/cupertino.dart';
import 'package:outsource_mate/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  final List<UserModel> _usersList = [
    UserModel(
      name: "John Doe",
      email: "john.doe@example.com",
      phone: "1234567890",
      role: "Employee",
      empId: "EMP001",
    ),
  ];

  List<UserModel> get usersList => _usersList;

  void addNewEmployee(UserModel userModel){
    _usersList.add(userModel);
    notifyListeners();
  }

}