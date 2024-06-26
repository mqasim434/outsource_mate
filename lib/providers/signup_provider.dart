import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outsource_mate/services/notifications_services.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class SignupProvider with ChangeNotifier {
  UserRoles currentRoleSelected = UserRoles.FREELANCER;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final NotificationServices notificationServices = NotificationServices();

  void changeRole(UserRoles role) {
    currentRoleSelected = role;
    notifyListeners();
  }

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void togglePasswordVisibility(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  Future<void> signupWithEmail(
      String email, String password, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Creating Account');
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveUserInDatabase(userCredential).then((value) {
        print('Successfully signed up: ${userCredential.user!.uid}');
        EasyLoading.dismiss();
        OneSignal.login(email);
        Navigator.pushNamed(context, RouteName.dashboard);
      });
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating account: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> saveUserInDatabase(UserCredential userCredential) async {
    print("Selected Role: $currentRoleSelected");
    if (currentRoleSelected == UserRoles.FREELANCER) {
      final freelancer = FreelancerModel(
        email: userCredential.user!.email,
        userType: UserRoles.FREELANCER.name,
        // deviceToken: await notificationServices.getDeviceToken(),
      );
      UserModel.currentUser = freelancer;
      final jsonData = freelancer.toJson();
      _firestore.collection('freelancers').add(jsonData).then((value) {
        print('Freelancer added with ID: ${value.id}');
      }).catchError((e) {
        print('Error adding Freelancer: $e');
      });
    } else if (currentRoleSelected == UserRoles.CLIENT) {
      final client = ClientModel(
        email: userCredential.user!.email,
        userType: UserRoles.CLIENT.name,
        // deviceToken: await notificationServices.getDeviceToken(),
      );
      UserModel.currentUser = client;
      final jsonData = client.toJson();
      _firestore.collection('clients').add(jsonData).then((value) {
        print('Client added with ID: ${value.id}');
        
      }).catchError((e) {
        print('Error adding client: $e');
      });
    }
    notifyListeners();
  }
}
