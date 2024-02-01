import 'package:flutter/material.dart';
class MyOrContinueDivider extends StatelessWidget {
  const MyOrContinueDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the text
        children: [
          Expanded(
            child: Divider(
              thickness: 3,
              color: Colors.black12,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'or',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 17,
              ),
            ),

          ),

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
