import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/profile_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

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
        body: Column(
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
                                borderRadius: BorderRadius.circular(150),
                                image: UserModel.currentUser.imageUrl==null? const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/icons/male_user.png')
                                ):DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(UserModel.currentUser.imageUrl),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 15,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: MyColors.pinkColor,
                            child: Icon(Icons.add_a_photo),
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
                      label: UserModel.currentUser.name??'N/A',
                      textController: nameController,
                      icon: Icons.person,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      label: UserModel.currentUser.email??'N/A',
                      textController: emailController,
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      label: UserModel.currentUser.phone??'N/A',
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
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.textController,
  });

  final String label;
  final IconData icon;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        suffixIcon: const Icon(Icons.edit),
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
        print(label);
        print(value);
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
