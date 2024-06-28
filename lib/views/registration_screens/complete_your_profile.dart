// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/services/email_service.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';

class CompleteYourProfileScreen extends StatelessWidget {
  CompleteYourProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/vectors/vector.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Complete Your Profile',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        hintText: 'Enter your name',
                        textFieldController: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      MyTextField(
                        hintText: 'Enter your phone',
                        textFieldController: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.pinkColor,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 50),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // EmailService.sendEmail(
                            //   "You've successfully signed up to Outsource Mate",
                            //   "Signup alert from Outsource Mate",
                            //   UserModel.currentUser.email,
                            // ).then((value) => null);
                            EasyLoading.show(status: 'Updating');
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUserField(
                                    fieldName: 'name',
                                    newValue: nameController.text)
                                .then((value) {
                              Provider.of<UserProvider>(context, listen: false)
                                  .updateUserField(
                                      fieldName: 'phone',
                                      newValue: phoneController.text)
                                  .then((value) {
                                Navigator.pushNamed(
                                    context, RouteName.introScreen);
                              });
                            });
                          }
                          EasyLoading.dismiss();
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
