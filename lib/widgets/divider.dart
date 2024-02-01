import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
      child: const Row(
        mainAxisSize: MainAxisSize.min, // Ensure minimum width
        children: [
          Expanded(
            child: Divider(
              thickness: 3,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
