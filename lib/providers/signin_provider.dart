import 'package:flutter/cupertino.dart';

class SigninProvider extends ChangeNotifier{

  // Change Sign in Role
  String currentRoleSelected = 'FREELANCER';

  void changeRole(String role){
    currentRoleSelected = role;
    notifyListeners();
  }


  // Toggle Password Visibility
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void togglePasswordVisibility(bool value){
    _isVisible = value;
    notifyListeners();
  }




}