import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/rotated_button.dart';
import 'package:outsource_mate/res/components/rounded_icon_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/registration_screens/signup_screen.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    final signinProvider = Provider.of<SigninProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: MyColors.purplePinkGradient
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Column(
                    children: [
                      RotatedButton(label: 'FREELANCER'),
                      SizedBox(height: 20,),
                      RotatedButton(label: 'EMPLOYEE'),
                      SizedBox(height: 20,),
                      RotatedButton(label: 'CLIENT'),
                    ],
                  ),
                  Container(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, bottom: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/vectors/signin_vector.jpg',
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
                            'Login',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Form(
                            child: Column(
                              children: [
                                (signinProvider.currentRoleSelected ==
                                            'FREELANCER' ||
                                        signinProvider.currentRoleSelected ==
                                            'CLIENT')
                                    ? TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter your Email',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                      )
                                    : TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Enter your Employee ID',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          signinProvider.togglePasswordVisibility(
                                              !signinProvider.isVisible);
                                        },
                                        child: Icon(
                                          signinProvider.isVisible
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined,
                                        ),
                                      )),
                                  obscureText: signinProvider.isVisible,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: MyColors.purpleColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Don\'t have an account? '),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, RouteName.signupScreen);
                                      },
                                      child: const Text(
                                        'Sign up',
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
                              Navigator.pushNamed(context, RouteName.dashboardScreen);
                            },
                            child: const Text('Sign in'),
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
    );
  }
}
