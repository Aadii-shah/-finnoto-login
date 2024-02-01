import 'dart:convert';

import 'package:flutter/material.dart';
import '../data/models/business_model.dart';
import '../provider/user_preference.dart';
import '../services/api_service.dart';
import 'dashboard_dart.dart';
import 'package:http/http.dart' as http;

class UserOrganization extends StatefulWidget {
  final Map<String, dynamic>? responseData;

  const UserOrganization({super.key, required this.responseData});

  @override
  State<UserOrganization> createState() => _UserOrganizationState();
}

class _UserOrganizationState extends State<UserOrganization> {
  List<BusinessModel> businesses = [];
  final ApiService apiService = ApiService();
  bool isLoading = true;
  Map<String, dynamic>? responseData;

  @override
  void initState() {
    super.initState();
    fetchData(widget.responseData!);
    responseData = widget.responseData;
  }

  Future<void> fetchData(Map<String, dynamic> responseData) async {
    try {
      final List<dynamic> businessesData = responseData['businesses'];
      List<dynamic> filteredBusinessesData = [];

      if (businessesData.isNotEmpty) {

        Set<int> uniqueBusinessIds = <int>{};

        for(dynamic businessData in businessesData) {
        //  print(businessData);
          if(businessData['product_id'] == 3) filteredBusinessesData.add(businessData);

        }


        // final List<BusinessModel> fetchedBusinesses = filteredBusinessesData
        //
        //     .map((businessData) => BusinessModel(
        //           id: businessData['id'],
        //           name: businessData['name'],
        //           productId: businessData['product_id'],
        //         ))
        //     .toList();

        final List<BusinessModel> fetchedBusinesses = businessesData
            .where((businessData) {
              int businessId = businessData['id'];
              return uniqueBusinessIds.add(businessId);
            })
            .map((businessData) => BusinessModel(
                  id: businessData['id'],
                  name: businessData['name'],
                  productId: businessData['product_id'],
                ))
            .toList();

        setState(() {
          businesses = fetchedBusinesses;
          isLoading = false;
        });
      } else {
        print('No businesses found in the response');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> fetchBusinessToken(
      int businessId, Map<String, dynamic>? responseData) async {
    try {
      if (responseData == null) {
        print('Error: responseData is null');
        return;
      }

      final String? accessToken = responseData['user']?['access_token'];

      if (accessToken == null) {
        print('Error: access_token is null');
        return;
      }

      final String businessTokenUrl =
          'https://meta.finnoto.dev/api/business/$businessId/token';

      final response = await http.post(
        Uri.parse(businessTokenUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'businesses': 'product_id'}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String businessToken = responseData['token'];

        // Call the validation function
        await validateTokenAndUpdateProperties(businessToken);

        print('Business Token: $businessToken');
        // Do something with the token, e.g., store it or navigate to a new screen
      } else {
        print(
            'Error fetching business token. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching business token: $error');
    }
  }

  Future<void> validateTokenAndUpdateProperties(String businessToken) async {
    try {
      final String validationUrl =
          'https://eapi.finnoto.dev/auth/validate-token';

      final response = await http.post(
        Uri.parse(validationUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $businessToken',
        },
        body: jsonEncode({'token': businessToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        print('Validation Response: $responseData');

        // Access the relevant properties from the parsed data
        final String userName = responseData['name'];
        final String imageUrl = responseData['image_url'];
        final String accessToken = responseData['access_token'];

        // Set properties
        await UserPreferences.setAccessToken(accessToken);
        await UserPreferences.setUserName(userName);
        await UserPreferences.setImageUrl(imageUrl);

        // For demonstration, print the user properties
        print('User Name: $userName');
        print('Image URL: $imageUrl');
      } else {
        print('Error validating token. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error validating token: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = screenSize.width * 0.1;
    const double maxHorizontalPadding = 16.0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding.clamp(0.0, maxHorizontalPadding),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/images/business.png',
                height: screenSize.height * 0.2,
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Organization',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please select the organization you would like to connect with',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              // Header and description

              Expanded(
                child: ListView.separated(
                  itemCount: businesses.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    final business = businesses[index];

                    return GestureDetector(
                      onTap: () async {
                        print("Business Name: ${business.name}");
                        print("Business ID: ${business.id}");
                        print("Product ID: ${business.productId}");
                        await fetchBusinessToken(business.id, responseData);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>MyDashBoard(),
                          ),
                        );
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Image.asset('lib/images/business.png',
                                  height: 50, width: 50),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  business.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Login with different user",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  Text("Login as vendor",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                ],
              ),

              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
