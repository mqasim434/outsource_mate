import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/profile_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:provider/provider.dart';

// Ignoring the lint rule
// ignore_for_file: use_key_in_widget_constructors
// ignore_for_file: prefer_const_constructors
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                  UtilityFunctions.getCollectionName(
                    UserModel.currentUser.userType,
                  ),
                )
                .where('email', isEqualTo: UserModel.currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text('Profile Not Found'),
                );
              } else {
                var userData = snapshot.data!.docs.first.data();
                nameController.text = userData['name'] ?? '';
                emailController.text = userData['email'] ?? '';
                phoneController.text = userData['phone'] ?? '';
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 30,
                            left: 20,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: MyColors.purplePinkGradient,
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 30,
                            top: 30,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                gradient: MyColors.purplePinkGradient,
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    gradient: MyColors.pinkPurpleGradient,
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        image: userData['imageUrl'] == null
                                            ? const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/icons/male_user.png'))
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    userData['imageUrl']),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Select an Option:'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      ImagePicker picker =
                                                          ImagePicker();
                                                      XFile? pickedImage =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                    },
                                                    child: ListTile(
                                                      title: Text('Camera'),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      ImagePicker picker =
                                                          ImagePicker();
                                                      XFile? pickedImage =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                      if (pickedImage != null) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Image Preview'),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    SizedBox(
                                                                        width:
                                                                            200,
                                                                        height:
                                                                            200,
                                                                        child: Image.file(
                                                                            File(pickedImage.path))),
                                                                    RoundedRectangularButton(
                                                                        buttonText:
                                                                            'Upload',
                                                                        onPress:
                                                                            () async {
                                                                          String
                                                                              imageUrl =
                                                                              await UtilityFunctions.uploadFileToFirebaseStorage(pickedImage.path);
                                                                          Provider.of<UserProvider>(context, listen: false)
                                                                              .updateUserField(fieldName: 'imageUrl', newValue: imageUrl)
                                                                              .then((value) {
                                                                            Navigator.pop(context);
                                                                          });
                                                                        })
                                                                  ],
                                                                ),
                                                              );
                                                            });
                                                      }
                                                    },
                                                    child: ListTile(
                                                      title: Text('Gallery'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: MyColors.pinkColor,
                                      child: Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 30,
                            bottom: 30,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: MyColors.purplePinkGradient,
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.5,
                      decoration: const BoxDecoration(
                        color: MyColors.purpleColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            MyTextField(
                              label: userData['name'] ?? 'N/A',
                              textController: nameController,
                              icon: Icons.person,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              label: userData['email'] ?? 'N/A',
                              textController: emailController,
                              icon: Icons.email,
                              isEditable: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              label: userData['phone'] ?? 'N/A',
                              textController: phoneController,
                              icon: Icons.phone,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RoundedRectangularButton(
                              buttonText: 'Save',
                              color: MyColors.pinkColor,
                              onPress: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.textController,
    this.isEditable = true,
  });

  final String label;
  final IconData icon;
  final bool isEditable;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return TextFormField(
      controller: textController,
      readOnly: !isEditable,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: isEditable ? Icon(Icons.edit) : SizedBox(),
        hintText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          profileProvider.switchEditing(true);
        } else {
          profileProvider.switchEditing(false);
        }
      },
      onEditingComplete: () {
        if (textController.text == label) {
          profileProvider.switchEditing(false);
        }
      },
    );
  }
}
