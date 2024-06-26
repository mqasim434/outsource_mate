import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.cardExpiryDate,
    required this.cardType,
  });

  final String? cardName;
  final String? cardNumber;
  final String? cardExpiryDate;
  final String? cardType;


  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  Map<String,LinearGradient> gradientsMap = {
    'Master Card': const LinearGradient(
      colors: [
        Color(0xffE42C66),
        Color(0xffF55B46),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    'Visa Card': const LinearGradient(
      colors: [
        Color(0xff9C2CF3),
        Color(0xff3A49F9),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  };
  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWith * 0.8,
      height: screenHeight * 0.23,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: gradientsMap[widget.cardType],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Card Name',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Icon(
                      Icons.payment,
                      size: 30,
                    ),
                  ],
                ),
                Text(
                  (widget.cardName==null||widget.cardName=='')?'Card Name':widget.cardName.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (widget.cardNumber==null||widget.cardNumber=='')?'Card Number':widget.cardNumber.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  (widget.cardExpiryDate==null||widget.cardExpiryDate=='')?'Expiry Date':widget.cardExpiryDate.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}