import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/providers/signup_provider.dart';
import 'package:outsource_mate/res/components/rotated_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/registration_screens/signin_screen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final emailController = TextEditingController();
    final empIdController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    final signupProvider = Provider.of<SignupProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: MyColors.purplePinkGradient
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Column(
                        children: [
                          RotatedButton(label: UserRoles.FREELANCER),
                          SizedBox(height: 20,),
                          RotatedButton(label: UserRoles.CLIENT),
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
                          const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
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
                                            vertical: 15, horizontal: 15),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      ),
                                    )
                                        : TextFormField(
                                      controller: empIdController,
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
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your password',
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: (){
                                              signupProvider.togglePasswordVisibility(!signupProvider.isVisible);
                                            },
                                            child: Icon(
                                              signupProvider.isVisible
                                                  ? Icons.remove_red_eye
                                                  : Icons.remove_red_eye_outlined,
                                            ),
                                          )),
                                      obscureText: signupProvider.isVisible,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: confirmPasswordController,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm your password',
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: (){
                                              signupProvider.togglePasswordVisibility(!signupProvider.isVisible);
                                            },
                                            child: Icon(
                                              signupProvider.isVisible
                                                  ? Icons.remove_red_eye
                                                  : Icons.remove_red_eye_outlined,
                                            ),
                                          )),
                                      obscureText: signupProvider.isVisible,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Already have an account? '),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, RouteName.signinScreen);
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
                                  signupProvider.signupWithEmail(emailController.text, passwordController.text,context);
                                },
                                child: const Text('Sign up',style: TextStyle(color: Colors.white),),
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
