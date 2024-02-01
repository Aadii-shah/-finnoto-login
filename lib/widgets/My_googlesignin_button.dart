import 'package:flutter/material.dart';

class MyGoogleSignIn extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyGoogleSignIn({super.key,
    required this.onTap,
    required this.text,});

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          border: Border.all(color: Colors.black, width: 1), // Add black border
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In With Google',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Colors.black, // Adjust text color if needed
              ),
            ),
            const SizedBox(width: 10), // Add spacing between text and icon
            Image.asset('lib/images/img.png', height: 22),
          ],
        ),
      ),
    );
  }

}
