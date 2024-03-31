import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/user_model.dart';

class EmployeeProvider extends ChangeNotifier{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<EmployeeModel> employeeList = [];

  Future<void> createEmployee(EmployeeModel employee,BuildContext context)async{
    try{
      EasyLoading.show(status: 'Adding new Employee');
      final jsonData = employee.toJson();
      _firestore.collection('employees').add(jsonData).then((value){
        print('Employee added with ID: ${value.id}');
        EasyLoading.dismiss();
      });
    }catch(e){
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