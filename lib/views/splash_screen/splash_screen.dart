import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/services/session_manager.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<dynamic> fetchUserByEmail(String email, String collection) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    DocumentSnapshot userDoc = querySnapshot.docs.first;
    print('Data: ${userDoc.data().toString()}');
    if (collection == "clients") {
      return ClientModel.fromJson(userDoc.data() as Map<String, dynamic>);
    } else if (collection == "freelancers") {
      return FreelancerModel.fromJson(userDoc.data() as Map<String, dynamic>);
    } else {
      return EmployeeModel.fromJson(userDoc.data() as Map<String, dynamic>);
    }
  }

  Future<Map<String, String>?> getDataFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> data = {
      'email': prefs.getString('email').toString(),
      'collection': prefs.getString('collection').toString(),
    };
    return data;
  }

  @override
  void initState() {
    SessionManager.checkSession().then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        if (value['email'] == null) {
          Navigator.pushNamed(context, RouteName.signinScreen);
        } else {
          // getDataFromSharedPrefs().then((data){
          //   if(data!=null){
          //     fetchUserByEmail(data['email'].toString(), data['collection'].toString()).then((user){
          //       UserModel.currentUser = user;
          //     });
          //
          //     setState(() {
          //
          //     });
          //   }
          // }).then((value){
          //   Navigator.pushNamed(context, RouteName.dashboard);
          // });
          fetchUserByEmail(value['email'],
              UtilityFunctions.getCollectionName(value['userType']));
          Navigator.pushNamed(context, RouteName.signinScreen);
        }
      });
    });
    // Future.delayed(const Duration(seconds: 3),(){
    //   Navigator.pushNamed(context, RouteName.signinScreen);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Image.asset('assets/logo/logo_new.png'),
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.8,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: MyColors.pinkColor),
              child: const Center(
                child: Text(
                  'Where Projects meet productivity',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
