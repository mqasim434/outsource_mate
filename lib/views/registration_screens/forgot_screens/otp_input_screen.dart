import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/otp_provider.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpInputScreen extends StatelessWidget {
  const OtpInputScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: MyColors.pinkColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: ChangeNotifierProvider(
              create: (_) => OtpProvider(),
              child: Consumer<OtpProvider>(
                builder: (context, provider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Image.asset(
                              'assets/icons/otp.png',
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
                            'Enter the OTP',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('An OTP has been sent to your phone.'),
                        ],
                      ),
                      Column(
                        children: [
                          Pinput(
                            length: 5,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                border: Border.all(color: Colors.green),
                              ),
                            ),
                            onCompleted: (pin) => debugPrint(pin),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Resend OTP in: ${provider.otpCount}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Didn\'t receive an OTP? '),
                              InkWell(
                                onTap: provider.otpCount == 0
                                    ? (){
                                  provider.otpCount=10;
                                }
                                    : null,
                                child: Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    color: provider.otpCount == 0
                                        ? MyColors.purpleColor
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      RoundedRectangularButton(
                          buttonText: 'Verify',
                          onPress: () {
                            Navigator.pushNamed(
                                context, RouteName.newPasswordScreen);
                          }),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
