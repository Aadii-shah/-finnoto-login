import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String ACCESS_TOKEN_KEY = 'access_token';
  static const String USER_NAME_KEY = 'user_name';
  static const String IMAGE_URL_KEY = 'image_url';

  static Future<void> setAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN_KEY, accessToken);
  }

  static Future<void> setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_NAME_KEY, userName);
  }

  static Future<void> setImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(IMAGE_URL_KEY, imageUrl);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_TOKEN_KEY);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_NAME_KEY);
  }

  static Future<String?> getImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(IMAGE_URL_KEY);
  }
}
