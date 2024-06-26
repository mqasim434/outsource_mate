import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/views/payment/card_text_field.dart';
import 'package:outsource_mate/views/payment/card_widget.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  String? selectedCard = 'Master Card';

  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvNumberController = TextEditingController();

  String? cardName;
  String? cardNumber;
  String? expiryDate;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.4,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff07111B),
                    Color(0xff205081),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        Text(
                          'Add New Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  CardWidget(
                    cardName: cardName,
                    cardNumber: cardNumber,
                    cardExpiryDate: expiryDate,
                    cardType: selectedCard,
                  ),
                  const Text(
                    'Card Preview',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 'Master Card',
                  groupValue: selectedCard,
                  onChanged: (value) {
                    setState(() {
                      selectedCard = value;
                    });
                  },
                ),
                const Text('Master Card'),
                const SizedBox(width: 20),
                Radio(
                  value: 'Visa Card',
                  groupValue: selectedCard,
                  onChanged: (value) {
                    setState(() {
                      selectedCard = value;
                    });
                  },
                ),
                const Text('Visa Card'),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextField(
                        label: 'Card Name',
                        hintText: 'Enter Card Name',
                        controller: cardNameController,
                        onChanged: (value) {
                          setState(() {
                            cardName = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      MyTextField(
                        label: 'Card Number',
                        hintText: 'Enter Card Number',
                        controller: cardNumberController,
                        onChanged: (value) {
                          setState(() {
                            cardNumber = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: MyTextField(
                              label: 'Expiry Date',
                              hintText: 'Enter Expiry Date',
                              controller: expiryDateController,
                              onChanged: (value) {
                                setState(() {
                                  expiryDate = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 2,
                            child: MyTextField(
                              label: 'CCV/CVV',
                              hintText: 'Enter CCV/CVV',
                              controller: cvvNumberController,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            backgroundColor: const Color(0xff205081),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Pay',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
