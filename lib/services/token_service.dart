import 'dart:convert';
import 'package:http/http.dart' as http;



class TokenManager {
  static String? _accessToken;
  static String? _refreshToken;

  // Setters for access token and refresh token
  static setAccessToken(String? accessToken) {
    _accessToken = accessToken;
  }

  static setRefreshToken(String? refreshToken) {
    _refreshToken = refreshToken;
  }

  // Getter for the current access token
  static String? getAccessToken() {
    return _accessToken;
  }

  static String? getRefreshToken() {
    return _refreshToken;
  }




  // Function to handle login and extract tokens from the response
  static void handleLoginResponse(Map<String, dynamic> responseData) {
    _accessToken = responseData['user']?['access_token'];
    _refreshToken = responseData['user']?['refresh_token'];
  }

  static DateTime? getExpiryTime() {
    // Retrieve the access token from storage (adjust this based on your storage mechanism)
    final String? accessToken = _accessToken;

    if (accessToken != null) {
      try {
        // Decode the payload of the JWT token to extract expiration time
        final Map<String, dynamic> decodedToken = json.decode(
          ascii.decode(base64.decode(base64.normalize(accessToken.split('.')[1]))),
        );

        if (decodedToken.containsKey('exp')) {
          // 'exp' is the key for expiration time in the token payload
          final int expiryTimeStamp = decodedToken['exp'];
          return DateTime.fromMillisecondsSinceEpoch(expiryTimeStamp * 1000);
        }
      } catch (error) {
        print('Error decoding token payload: $error');
      }
    }

    return null; // Return null if expiration time is not found or there's an error
  }

  // Function to refresh the access token
  // static Future<String?> refreshAccessToken() async {
  //   final currentRefreshToken = _refreshToken;
  //
  //   if (currentRefreshToken == null) {
  //     // Handle the case where no refresh token is available
  //     print('No refresh token available.');
  //     return null;
  //   }
  //
  //   try {
  //     // Make a request to your token refresh endpoint
  //     final response = await http.post(
  //       Uri.parse('https://your-auth-server.com/refresh-token'),
  //       body: {
  //         'refresh_token': currentRefreshToken,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       final newAccessToken = responseData['access_token'];
  //
  //       // Update the current access token
  //       _accessToken = newAccessToken;
  //       return newAccessToken;
  //     } else {
  //       // Handle the case where token refresh fails
  //       print('Failed to refresh access token. Status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       return null;
  //     }
  //   } catch (error) {
  //     // Handle errors during the refresh process
  //     print('Error refreshing access token: $error');
  //     return null;
  //   }
  // }
}
