import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class ThreeDots extends StatelessWidget {
  ThreeDots({super.key, required this.pageIndex});

  int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dot(dotIndex: 0, pageIndex: pageIndex),
        Dot(dotIndex: 1, pageIndex: pageIndex),
        Dot(dotIndex: 2, pageIndex: pageIndex),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  Dot({
    super.key,
    required this.dotIndex,
    required this.pageIndex,
  });

  int? dotIndex;
  int? pageIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color:
            dotIndex == pageIndex ? MyColors.purpleColor : MyColors.pinkColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
