

// class AuthenticationRepository {
//   final ApiService apiService;
//
//   AuthenticationRepository(this.apiService);
//
//   Future<UserModel?> login(String email, String password) async {
//     print("login method called in AuthenticationRepository");
//
//     try {
//       final response = await apiService.post('/auth/login', {'username': email, 'password': password});
//       print("Response Status Code: ${response.statusCode}");
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         final String? token = responseData['token'];
//
//         if (token != null) {
//           return UserModel(token);
//         } else {
//           print('Token is null in the response.');
//           return null;
//         }
//       } else {
//         // Handle other status codes if needed
//         print('Login failed. Status Code: ${response.statusCode}');
//         print('Response Body: ${response.body}');
//         return null;
//       }
//
//     } catch (error) {
//       print("Error in AuthenticationRepository: $error");
//       // Handle network or other errors
//       return null;
//     }
//   }
// }
