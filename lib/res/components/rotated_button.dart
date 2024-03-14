import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class RotatedButton extends StatelessWidget {
  const RotatedButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final signinProvider = Provider.of<SigninProvider>(context);
    return InkWell(
      onTap: () {
        signinProvider.changeRole(label);
      },
      child: Container(
        width: 40,
        height: 110,
        decoration: BoxDecoration(
            color: signinProvider.currentRoleSelected == label
                ? MyColors.pinkColor
                : Colors.transparent,
            border: signinProvider.currentRoleSelected == label
                ? Border.all(color: Colors.transparent)
                : const Border(
                    top: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white),
                    left: BorderSide(color: Colors.white),
                  )),
        child: RotatedBox(
          quarterTurns: -1,
          child: Center(child: Text(label)),
        ),
      ),
    );
  }
}
