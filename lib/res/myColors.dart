import 'package:flutter/material.dart';

class MyColors {
  static const Color purpleColor = Color(0xFF9D7CFD);
  static const Color pinkColor = Color(0xFFF895CD);


  static const Color blackTextColor = Color(0xff242424);
  static const Color lightBlackTextColor = Color(0xff323232);
  static const Color whiteTextColor = Colors.white;




  static LinearGradient purplePinkGradient = const LinearGradient(
    begin: Alignment.centerLeft, // Start from the left
    end: Alignment.centerRight, // End on the right
    colors: [
      MyColors.purpleColor,
      MyColors.pinkColor,
    ],
  );

  static LinearGradient pinkPurpleGradient = const LinearGradient(
    begin: Alignment.centerLeft, // Start from the left
    end: Alignment.centerRight, // End on the right
    colors: [
      MyColors.pinkColor,
      MyColors.purpleColor,
    ],
  );
}
