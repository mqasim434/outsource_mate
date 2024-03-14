import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class IntroPage extends StatelessWidget {
  IntroPage({
    super.key,
    required this.img,
    required this.title,
    required this.text
  });

  String? img;
  String? title;
  String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(img.toString()),
        //text
        Column(
          children: [
            Text(
              title.toString(),
              style: const TextStyle(
                color: MyColors.blackTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              text.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MyColors.blackTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}