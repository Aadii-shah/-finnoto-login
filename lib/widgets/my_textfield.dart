import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconButton icon;

  const MyTextField(
      {super.key,
        required this.controller,
        required this.hintText,
        required this.obscureText,
        required this.icon,});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.01),
      child: Expanded(
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
              suffixIcon: icon,
              suffixIconColor: Colors.black,
              hintText: hintText,
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary)),

        ),

      )

    );
  }
}
