import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/components/rotated_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key});

  final emailController = TextEditingController();
  final empIdController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final signinProvider = Provider.of<SigninProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(gradient: MyColors.purplePinkGradient),
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
                            signinProvider.changeRole(UserRoles.FREELANCER);
                          },
                          page: 'signin',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RotatedButton(
                          label: UserRoles.EMPLOYEE,
                          onTap: () {
                            signinProvider.changeRole(UserRoles.EMPLOYEE);
                          },
                          page: 'signin',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RotatedButton(
                          label: UserRoles.CLIENT,
                          onTap: () {
                            signinProvider.changeRole(UserRoles.CLIENT);
                          },
                          page: 'signin',
                        ),
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
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 50),
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
                              key: formKey,
                              child: Column(
                                children: [
                                  (signinProvider.currentRoleSelected ==
                                              UserRoles.FREELANCER ||
                                          signinProvider.currentRoleSelected ==
                                              UserRoles.CLIENT)
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
                                          controller: empIdController,
                                          decoration: InputDecoration(
                                            hintText: 'Enter your Employee ID',
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
                                            if (value!.isEmpty) {
                                              return "Employee Id Can't be empty";
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
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          signinProvider
                                              .togglePasswordVisibility(
                                                  !signinProvider.isVisible);
                                        },
                                        child: Icon(
                                          signinProvider.isVisible
                                              ? Icons.remove_red_eye
                                              : Icons.remove_red_eye_outlined,
                                        ),
                                      ),
                                    ),
                                    obscureText: signinProvider.isVisible,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password Can't be empty";
                                      } else if (value.length < 6) {
                                        return "Invalid Password Length";
                                      } else {
                                        return null;
                                      }
                                    },
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
                                          Navigator.pushNamed(
                                              context, RouteName.signupScreen);
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
                                if (formKey.currentState!.validate()) {
                                  if (signinProvider.currentRoleSelected ==
                                          UserRoles.FREELANCER ||
                                      signinProvider.currentRoleSelected ==
                                          UserRoles.CLIENT) {
                                    signinProvider.signinWithEmail(
                                        emailController.text,
                                        passwordController.text,
                                        context);
                                  } else {
                                    signinProvider
                                        .signinWithEmployeeId(
                                            empIdController.text,
                                            passwordController.text,
                                            context)
                                        .then(
                                      (value) {
                                        if (value) {
                                          Navigator.pushNamed(
                                              context, RouteName.dashboard);
                                        }
                                      },
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Sign in',
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
    );
  }
}
