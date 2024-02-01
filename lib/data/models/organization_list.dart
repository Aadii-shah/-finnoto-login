import 'package:flutter/material.dart';

import '../../widgets/build_list_item.dart';
import 'business_model.dart';

class OrganizationList extends StatelessWidget {
  final BusinessModel business; // Receive a BusinessModel object as input

  const OrganizationList({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    const String imageName = 'business.png';

    return Padding(
      padding: const EdgeInsets.all(25),
      child: buildListItem(business),
    );



  }
}
