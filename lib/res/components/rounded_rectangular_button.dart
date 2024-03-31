import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/profile_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class RoundedRectangularButton extends StatelessWidget {
  const RoundedRectangularButton({
    super.key,
    required this.buttonText,
    required this.onPress,
    this.color = Colors.transparent,
    this.enabled = true,
  });

  final String? buttonText;
  final VoidCallback onPress;
  final Color color;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.055,
        decoration: color==Colors.transparent? BoxDecoration(
          gradient: MyColors.purplePinkGradient,
          borderRadius: BorderRadius.circular(25.0),
        ):BoxDecoration(
          color: profileProvider.isEditing? color:Colors.grey,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            buttonText.toString(),
            style: TextStyle(
              color: profileProvider.isEditing? Colors.white:Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}