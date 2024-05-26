import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/signup_provider.dart';
import 'package:provider/provider.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    required this.textFieldController,
    this.isPassword = false,
    this.isDescription = false,
  });

  final String hintText;
  final bool isPassword;
  final bool isDescription;
  final TextEditingController textFieldController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      obscureText: isPassword,
      maxLines: isDescription?3:1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            isDescription?10:50,
          ),
        ),
        hintText: hintText,
        suffixIcon: isPassword
            ? ChangeNotifierProvider(create: (_)=>SignupProvider(),
              child: Consumer<SignupProvider>(
                builder: (context,provider,child){
                  return InkWell(
                    onTap: (){
                      provider.togglePasswordVisibility(!provider.isVisible);
                    },
                    child: Icon(
                      provider.isVisible?Icons.visibility:Icons.visibility_off
                    ),
                  );
                },
              ),
            )
            : null,
        contentPadding: const EdgeInsets.only(
          left: 20,
          top: 15,
          bottom: 15,
        ),
      ),
    );
  }
}