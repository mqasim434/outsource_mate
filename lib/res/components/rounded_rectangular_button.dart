import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class RoundedRectangularButton extends StatelessWidget {
  RoundedRectangularButton({
    super.key,
    required this.buttonText,
    required this.onPress,
  });

  String? buttonText;
  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.055,
        decoration: BoxDecoration(
          gradient: MyColors.purplePinkGradient,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            buttonText.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}