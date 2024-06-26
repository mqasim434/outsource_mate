// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/myColors.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Forgot Password',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(width: 300, 'assets/vectors/forgot_vector.jpg'),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 20),
                        ]),
                    child: Column(
                      children: [
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Enter email to get password reset link.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        MyTextField(
                          hintText: 'Enter your email',
                          textFieldController: emailController,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Email can't be empty.";
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value.toString())) {
                              return "Email is not valid";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailController.text)
                                  .then((value) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        icon: Icon(Icons.email),
                                        title: Text(
                                            'Email Sent to ${emailController.text}'),
                                        content: Text(
                                            textAlign: TextAlign.center,
                                            "Don't forgot to check Spam Folder"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Ok'))
                                        ],
                                      );
                                    });
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.pinkColor,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                          ),
                          child: Text(
                            'Send Mail',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
