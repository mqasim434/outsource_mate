import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/services/session_manager.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/utils/utility_functions.dart';

class SigninProvider extends ChangeNotifier {
  UserRoles currentRoleSelected = UserRoles.FREELANCER;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void changeRole(UserRoles role) {
    print("Role passed $role");
    currentRoleSelected = role;
    print("Chagned Role: $currentRoleSelected");
    notifyListeners();
  }

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void togglePasswordVisibility(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  Future<bool> userExists(String email, String collection) async {
    final QuerySnapshot result = await _firestore
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }

  Future<void> signinWithEmail(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Logging In');
      if (await userExists(email,
          UtilityFunctions.getCollectionName(currentRoleSelected.name))) {
        UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) async {
          if (currentRoleSelected == UserRoles.FREELANCER) {
            UserModel.currentUser =
                await getUserDataByEmail(email, 'freelancers');
            SessionManager.createSession(
                    email: email,
                    password: password,
                    userRole: UserRoles.FREELANCER.name)
                .then((value) async {
              // final querySnapshot = await FirebaseFirestore.instance
              //     .collection('freelancers')
              //     .where('email', isEqualTo: email)
              //     .get();
              // for (final docSnapshot in querySnapshot.docs) {
              //   await docSnapshot.reference.update({
              //     'deviceToken': await notificationServices.getDeviceToken()
              //   });
              // }
              // print(await notificationServices.getDeviceToken());
              OneSignal.login(email);
              Navigator.pushNamed(context, RouteName.dashboard);
            });
          } else if (currentRoleSelected == UserRoles.CLIENT) {
            UserModel.currentUser = await getUserDataByEmail(email, 'clients');
            SessionManager.createSession(
                    email: email,
                    password: password,
                    userRole: UserRoles.CLIENT.name)
                .then((value) async {
              // final querySnapshot = await FirebaseFirestore.instance
              //     .collection('clients')
              //     .where('email', isEqualTo: email)
              //     .get();
              // for (final docSnapshot in querySnapshot.docs) {
              //   await docSnapshot.reference.update({
              //     'deviceToken': await notificationServices.getDeviceToken()
              //   });
              // }
              Navigator.pushNamed(context, RouteName.dashboard);
            });
          }
          notifyListeners();
          OneSignal.login(email);
          return value;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User does not exist'),
            backgroundColor: Colors.red,
          ),
        );
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Logging in: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> signinWithEmployeeId(
      String employeeId, String password, BuildContext context) async {
    print(employeeId);
    print(password);
    try {
      EasyLoading.show(status: 'Logging in');
      CollectionReference employees =
          FirebaseFirestore.instance.collection('employees');

      QuerySnapshot querySnapshot =
          await employees.where('empId', isEqualTo: employeeId).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot employeeDoc = querySnapshot.docs.first;

        print('HELLO');
        if (employeeDoc['password'] == password) {
          UserModel.currentUser =
              UtilityFunctions.convertDocumentToUserModel(employeeDoc);
          EasyLoading.dismiss();
          SessionManager.createSession(
            email: employeeId,
            password: password,
            userRole: UserRoles.CLIENT.name,
          );
          // final querySnapshot = await FirebaseFirestore.instance
          //     .collection('employees')
          //     .where('empId', isEqualTo: employeeId)
          //     .get();
          // for (final docSnapshot in querySnapshot.docs) {
          //   await docSnapshot.reference
          //       .update({'token': await notificationServices.getDeviceToken()});
          // }
          OneSignal.login(employeeId);
          return true;
        } else {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid Credentials'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Credentials'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
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

  Future<UserModel?> getUserDataByEmail(String email, String collection) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (result.docs.isEmpty) {
      return null;
    }

    final DocumentSnapshot document = result.docs.first;
    final Map<String, dynamic> userData =
        document.data() as Map<String, dynamic>;
    if (collection == 'freelancers') {
      return FreelancerModel.fromJson(userData);
    } else if (collection == 'clients') {
      return ClientModel.fromJson(userData);
    } else {
      return EmployeeModel.fromJson(userData);
    }
  }
}

enum UserRoles {
  FREELANCER,
  EMPLOYEE,
  CLIENT,
}
