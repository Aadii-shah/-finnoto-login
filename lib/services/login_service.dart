import 'dart:convert';
import 'package:finnoto_login/data/models/login_credential.dart';
import 'package:finnoto_login/services/token_service.dart';
import 'package:http/http.dart' as http;

import '../provider/user_preference.dart';

class LoginService {
  static const String apiUrl = 'https://meta.finnoto.dev/auth/login';

  // Future<Map<String, dynamic>?> login(String email, String password) async {
  Future<Map<String, dynamic>?> login(LoginCredentials loginCredentials) async {

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': loginCredentials.email, 'password': loginCredentials.password}),
      );

      print('Response Status Code: ${response.statusCode}');
      //print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        TokenManager.handleLoginResponse(responseData);
        print('Response Data in login service: $responseData');

        return responseData;
      } else {
        print('Login failed. Check your credentials.');
        return null;
      }
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }


  Future<bool> isLogged () async{

    String? accessToken = await UserPreferences.getAccessToken();

    var loggedIn = false;


    if(accessToken != null){
      loggedIn = true;

    }
    return loggedIn;

  }



}



// Future <Map<String, dynamic>> login(String email, String password) async {
  //   try {
  //     print(email);
  //     print(password);
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'username': email, 'password': password}),
  //     );
  //
  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);
  //       return responseData;
  //       // final String? token = responseData['credential']; // Access directly as a string
  //       //
  //       //
  //       // if (token != null) {
  //       //   print('Login successful. Token: $token');
  //       //   return token;
  //       // } else {
  //       //   print('Login failed. Token is missing in the response.');
  //       //   return null;
  //       // }
  //     } else {
  //       print('Login failed. Check your credentials.');
  //       //return null;
  //     }
  //   } catch (error) {
  //     print('Error during login: $error');
  //     //return null;
  //   }
  // }


//}


