// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/res/components/my_text_field.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class AddReviewScreen extends StatefulWidget {
  AddReviewScreen({super.key, required this.projectId});

  final String? projectId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double ratingValue = 0;

  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final projectProvider = Provider.of<ProjectProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Give Review',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset(
                  width: screenWidth * 0.5, 'assets/vectors/review.jpg'),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                width: screenWidth,
                height: screenHeight * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Rate the Service',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      RatingStars(
                        value: ratingValue,
                        onValueChanged: (v) {
                          setState(() {
                            ratingValue = v;
                          });
                        },
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          size: 50,
                          color: color,
                        ),
                        starCount: 5,
                        starSize: 50,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelRadius: 10,
                        maxValue: 5,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: false,
                        animationDuration: Duration(milliseconds: 1000),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.yellow,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'Describe your Experience:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MyTextField(
                        hintText: 'Type a Review...',
                        isDescription: true,
                        textFieldController: reviewController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Type a review";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            double.infinity,
                            50,
                          ),
                          backgroundColor: MyColors.purpleColor,
                        ),
                        onPressed: () {
                          projectProvider
                              .addReview(widget.projectId.toString(), {
                            'rating': ratingValue,
                            'comment': reviewController.text,
                          }).then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Add Review',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
