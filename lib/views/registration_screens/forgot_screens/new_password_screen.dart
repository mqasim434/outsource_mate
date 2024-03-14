import 'package:flutter/material.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    child: Image.asset(
                      'assets/icons/reset-password.png',
                    ),
                  ),
                  const SizedBox(
                    width: 250,
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(''),
                ],
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'New Password'
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Confirm New Password'
                    ),
                  ),
                ],
              ),
              RoundedRectangularButton(
                buttonText: 'Reset Password',
                onPress: () {
                  Navigator.pushNamed(context, RouteName.signinScreen);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
