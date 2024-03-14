import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class Toffee extends StatelessWidget {
  final int Number;
  final String Label;
  // final String svg;
  final VoidCallback onPressed;
  final Color numberColor;

  Toffee(
      {Key? key,
        required this.Number,
        required this.Label,
        // required this.svg,
        required this.onPressed,
        this.numberColor = MyColors.purpleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 3, offset: Offset(0, 3), color: Colors.black12)
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Number.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: numberColor),
                ),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Label,
                  style: Theme.of(context).textTheme.bodyText1!,
                )),
          ],
        ),
      ),
    );
  }
}

enum ToffeeType { profile, setting }

class Toffee2 extends StatelessWidget {
  final ToffeeType type;
  final String Title;
  final String? Subtitle;
  // final String svg;
  final bool enabled;
  final VoidCallback onPressed;
  final Color? numberColor;

  Toffee2(
      {Key? key,
        required this.Title,
        this.Subtitle,
        // required this.svg,
        required this.onPressed,
        this.enabled = true,
        this.numberColor = MyColors.purpleColor,
        required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        margin: type == ToffeeType.profile
            ? EdgeInsets.only(bottom: 10)
            : EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 3, offset: Offset(0, 3), color: Colors.black12)
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white),
        padding: EdgeInsets.all(15),
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 10),
                  // child: SvgPicture.asset(
                  //   svg,
                  //   width: 40,
                  //   height: 40,
                  //   fit: BoxFit.contain,
                  // ),
            ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Title.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: numberColor),
                    ),
                    if (Subtitle != null)
                      Text(
                        Subtitle.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: numberColor),
                      ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }
}

// class NotificationTile extends StatelessWidget {
//   final NotificationType notificationType;
//   const NotificationTile({
//     required this.notificationType,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       padding: EdgeInsets.symmetric(vertical: 10),
//       color: Colors.white,
//       margin: EdgeInsets.only(bottom: 3),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: CircleAvatar(
//                 child: Icon(
//                   notificationType == NotificationType.success
//                       ? Icons.check
//                       : notificationType == NotificationType.alert
//                       ? Typicons.warning_empty
//                       : FontAwesome5.question,
//                   color: notificationType == NotificationType.success
//                       ? MyColors.greenColor
//                       : notificationType == NotificationType.alert
//                       ? Colors.orange
//                       : MyColors.blueColor,
//                 ),
//                 backgroundColor: notificationType == NotificationType.success
//                     ? Colors.green[200]
//                     : notificationType == NotificationType.alert
//                     ? Colors.orange[100]
//                     : Colors.grey[350],
//                 radius: 25,
//               )),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Education details in your profile have been updated"),
//                 Text(
//                   "2022-01-02",
//                   style: Theme.of(context).textTheme.caption,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// enum NotificationType {
//   information,
//   alert,
//   success,
// }