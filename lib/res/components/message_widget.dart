import 'package:flutter/material.dart';
import 'package:outsource_mate/res/myColors.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({
    super.key,
    required this.messageText,
    this.isSender = true,
  });

  String? messageText;
  bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isSender?MyColors.pinkColor:MyColors.purpleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomLeft: isSender?const Radius.circular(25):const Radius.circular(0),
                  bottomRight: isSender?const Radius.circular(0):const Radius.circular(25),
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Text(
                messageText.toString(),
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: const [
              Text('12:12 PM'),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.check)
            ],
          )
        ],
      ),
    );
  }
}
