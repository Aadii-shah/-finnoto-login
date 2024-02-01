
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String isLoggedInKey = 'isLoggedIn';

  static Future<void> setLoggedInState(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> getLoggedInState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
}
