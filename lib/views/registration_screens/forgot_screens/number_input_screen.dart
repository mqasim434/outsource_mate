import 'package:flutter/material.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class NumberInputScreen extends StatelessWidget {
  const NumberInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(
                      width: 150,
                      child: Image.asset(
                        'assets/icons/phone.png',
                      )),
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
                    'Enter your phone number',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('We will send you a OTP for Confirmation'),
                ],
              ),
              const IntlPhoneField(
                initialCountryCode: 'PK',
              ),
              RoundedRectangularButton(
                buttonText: 'Verify',
                  onPress: () {
                    Navigator.pushNamed(context, RouteName.otpInputScreen);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
