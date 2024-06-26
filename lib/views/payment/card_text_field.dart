import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onChanged
  });

  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  final Function(String value) onChanged;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(widget.label.toString()),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText.toString(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          onChanged: (value){
            print('Value from field $value');
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}