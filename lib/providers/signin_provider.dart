import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/services/encrpyion_services.dart';
import 'package:outsource_mate/utils/login_session_manager.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/utils/utility_functions.dart';

class SigninProvider extends ChangeNotifier{
  UserRoles currentRoleSelected = UserRoles.FREELANCER;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void changeRole(UserRoles role){
    print("Role passed $role" );
    currentRoleSelected = role;
    print("Chagned Role: $currentRoleSelected");
    notifyListeners();
  }

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void togglePasswordVisibility(bool value){
    _isVisible = value;
    notifyListeners();
  }

  Future<bool> userExists(String email,String collection) async {
    final QuerySnapshot result = await _firestore
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  Future<void> signinWithEmail(String email,String password,BuildContext context) async {
      try {
        EasyLoading.show(status: 'Logging In');
        if(await userExists(email, UtilityFunctions.getCollectionName(currentRoleSelected.name))){
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ).then((value) async {
            if(currentRoleSelected==UserRoles.FREELANCER){
              UserModel.currentUser = await getUserDataByEmail(email,'freelancers');
              LoginSessionManager.storeUserSession(email,'freelancers').then((value){
                Navigator.pushNamed(context, RouteName.dashboard);
              });
            }else if(currentRoleSelected==UserRoles.CLIENT){
              UserModel.currentUser = await getUserDataByEmail(email,'clients');
              LoginSessionManager.storeUserSession(email,'clients').then((value){
                Navigator.pushNamed(context, RouteName.dashboard);
              });
            }
            notifyListeners();

            return value;
          });
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User does not exist'),
              backgroundColor: Colors.red,
            ),
          );
        }
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


  Future<bool> signinWithEmployeeId(String employeeId, String password,BuildContext context) async {
    try {
      EasyLoading.show(status: 'Logging in');
      // Reference to the employees collection
      CollectionReference employees = FirebaseFirestore.instance.collection('employees');

      // Query to find the employee with the matching ID
      QuerySnapshot querySnapshot = await employees.where('empId', isEqualTo: employeeId).limit(1).get();

      // Check if an employee with the given ID exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the employee document
        DocumentSnapshot employeeDoc = querySnapshot.docs.first;

        // Compare the stored password with the provided password
        print('HELLO');
        if (employeeDoc['password'] == password) {
          UserModel.currentUser = UtilityFunctions.convertDocumentToUserModel(employeeDoc);
          EasyLoading.dismiss();
          return true; // Cr
          // edentials match
        } else {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credentials'),
              backgroundColor: Colors.red,
            ),
          );
          return false; // Password does not match
        }
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Credentials'),
            backgroundColor: Colors.red,
          ),
        );
        return false; // No employee found with the given ID
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Logging in: $e'),
          backgroundColor: Colors.red,
        ),
      );
      EasyLoading.dismiss();
      return false; // Error occurred
    }
  }

  Future<UserModel?> getUserDataByEmail(String email,String collection) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      return null;
    }

    final DocumentSnapshot document = result.docs.first;
    final Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
    if(collection=='freelancers'){
      return FreelancerModel.fromJson(userData);
    }else if(collection=='clients'){
      return ClientModel.fromJson(userData);
    }else{
      return EmployeeModel.fromJson(userData);
    }

  }

}

enum UserRoles{
  FREELANCER,
  EMPLOYEE,
  CLIENT,
}