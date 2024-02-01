import 'package:flutter/material.dart';
import '../data/models/business_model.dart';
 // Assuming the BusinessModel class is defined here

// Function to build a list item with a box border
Widget buildListItem(BusinessModel organization) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey), // Adjust border color as needed
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(15),
    child: Row(
      children: [
        Image.asset('lib/images/business.png', height: 36),
        const SizedBox(width: 10),

        Text(
            organization.name,

            style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),

      ],
    ),
  );
}
