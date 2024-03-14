import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class RoundedIconButton extends StatelessWidget {
  RoundedIconButton({super.key,required this.onPress});

  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: MyColors.purplePinkGradient,
          borderRadius: BorderRadius.circular(
            50.0,
          ),
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
