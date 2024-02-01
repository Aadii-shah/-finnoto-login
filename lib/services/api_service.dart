import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  static const String apiUrl =
      'https://meta.finnoto.dev/api/business';

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${await getAccessToken()}',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Error fetching data: ${response.statusCode}');
        throw Exception('Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw Exception('Error during API call: $error');
    }
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<void> saveAccessToken(String accessToken) async {
    await secureStorage.write(key: 'access_token', value: accessToken);
  }
}
