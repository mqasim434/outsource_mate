import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/services/encrpyion_services.dart';

class EmployeeProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<EmployeeModel> employeeList = [];

  Future<void> fetchEmployees() async {
    EasyLoading.show(status: 'Loading');
    final QuerySnapshot result = await _firestore.collection('employees').get();
    employeeList = result.docs
        .map((DocumentSnapshot doc) =>
            EmployeeModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    print(employeeList[0].name);
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> createEmployee(
      EmployeeModel employee, BuildContext context) async {
    try {
      EasyLoading.show(status: 'Adding new Employee');
      var jsonData = employee.toJson();
      String password = 'emp12345';
      String encryptedPassword = EncryptionService.encryptPassword(password);
      jsonData['password'] = password;
      // jsonData['password'] = encryptedPassword;
      _firestore.collection('employees').add(jsonData).then((value) {
        print('Employee added with ID: ${value.id}');
        EasyLoading.dismiss();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding employee: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error adding employee: $e');
    }
  }
}
