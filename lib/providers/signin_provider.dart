import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class SigninProvider extends ChangeNotifier{
  UserRoles currentRoleSelected = UserRoles.FREELANCER;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void changeRole(UserRoles role){
    currentRoleSelected = role;
    notifyListeners();
  }

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void togglePasswordVisibility(bool value){
    _isVisible = value;
    notifyListeners();
  }

  Future<void> signinWithEmail(String email,String password,BuildContext context) async {
      try {
        EasyLoading.show(status: 'Logging In');
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value){
          if(currentRoleSelected==UserRoles.FREELANCER){
            UserModel.currentUser = FreelancerModel(
              email: email,
            );
          }else if(currentRoleSelected==UserRoles.EMPLOYEE){
            UserModel.currentUser = EmployeeModel(
              email: email,
            );
          }else if(currentRoleSelected==UserRoles.CLIENT){
            UserModel.currentUser = ClientModel(
              email: email,
            );
            notifyListeners();
          }
          Navigator.pushNamed(context, RouteName.dashboard);
              return value;
        });
        EasyLoading.dismiss();
      }catch (e) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error Logging in: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
  }

}

enum UserRoles{
  FREELANCER,
  EMPLOYEE,
  CLIENT,
}