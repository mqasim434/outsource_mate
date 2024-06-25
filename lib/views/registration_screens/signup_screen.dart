import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/providers/signup_provider.dart';
import 'package:outsource_mate/res/components/rotated_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/registration_screens/signin_screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final signupProvider = Provider.of<SignupProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: MyColors.purplePinkGradient),
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          RotatedButton(
                            label: UserRoles.FREELANCER,
                            onTap: () {
                              signupProvider.changeRole(UserRoles.FREELANCER);
                            },
                            page: 'signup',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RotatedButton(
                            label: UserRoles.CLIENT,
                            onTap: () {
                              signupProvider.changeRole(UserRoles.CLIENT);
                            },
                            page: 'signup',
                          ),
                        ],
                      ),
                      Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/vectors/Signup_vector.jpg',
                                width: 250,
                              ),
                              const Text(
                                'Welcome To\nOutsource Mate',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              const Text(
                                'Signup',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    signupProvider.currentRoleSelected ==
                                            UserRoles.FREELANCER
                                        ? TextFormField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your Email',
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return "Email can't be empty.";
                                              } else if (!RegExp(
                                                      r'^[^@]+@[^@]+\.[^@]+')
                                                  .hasMatch(value.toString())) {
                                                return "Email is not valid";
                                              } else {
                                                return null;
                                              }
                                            },
                                          )
                                        : TextFormField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your email',
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value.toString().isEmpty) {
                                                return "Email can't be empty.";
                                              } else if (!RegExp(
                                                      r'^[^@]+@[^@]+\.[^@]+')
                                                  .hasMatch(value.toString())) {
                                                return "Email is not valid";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your password',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              signupProvider
                                                  .togglePasswordVisibility(
                                                      !signupProvider
                                                          .isVisible);
                                            },
                                            child: Icon(
                                              signupProvider.isVisible
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                            ),
                                          )),
                                      obscureText: signupProvider.isVisible,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password Can't be empty";
                                        } else if (value.length < 8) {
                                          return "Invalid Password Length";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: confirmPasswordController,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm your password',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              signupProvider
                                                  .togglePasswordVisibility(
                                                      !signupProvider
                                                          .isVisible);
                                            },
                                            child: Icon(
                                              signupProvider.isVisible
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                            ),
                                          )),
                                      obscureText: signupProvider.isVisible,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password Can't be empty";
                                        } else if (value.length < 8) {
                                          return "Invalid Password Length";
                                        } else if (value !=
                                            passwordController.text) {
                                          return "Passwords dont't match";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Already have an account? '),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.signinScreen);
                                          },
                                          child: const Text(
                                            'Sign in',
                                            style: TextStyle(
                                                color: MyColors.purpleColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.purpleColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    signupProvider.signupWithEmail(
                                        emailController.text,
                                        passwordController.text,
                                        context);
                                  }
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
