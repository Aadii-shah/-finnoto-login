// import 'package:finnoto_login/pages/user_organization.dart';
// import 'package:flutter/material.dart';
// import '../data/models/login_credential.dart';
// import '../provider/auth_provider.dart';
// import '../services/login_service.dart';
//
// class LogRegister extends StatefulWidget {
//   final LoginCredentials credentials;
//
//   const LogRegister({super.key, required this.credentials});
//
//   @override
//   State<LogRegister> createState() => _LogRegisterState(credentials: credentials);
// }
//
// class _LogRegisterState extends State<LogRegister> {
//
//   bool showLoginPage = true;
//
//
//
//   final LoginCredentials credentials;
//   Map<String, dynamic>? responseData;
//   _LogRegisterState({required this.credentials});
//
//
//   // void moveToUserOrganization() async {
//   //   //String email = 'hemant111@finnoto.com';
//   //   //String password = '123456';
//   //   final loginService = LoginService();
//   //   responseData = await loginService.login(credentials);
//   //   setState(() {});
//   //
//   // }
//
//   @override
//   void initState()  {
//
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       checkLoginStatus();
//       moveToUserOrganization();
//       print(responseData);
//     });
//     //print(responseData);
//
//   }
//
//
//   Future<void> checkLoginStatus() async {
//     bool isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
//     if (isLoggedIn) {
//       // User is logged in, navigate to home or any other screen
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserOrganization(responseData: responseData)));
//     } else {
//       // User is not logged in, show login or register page
//       setState(() {});
//     }
//   }
//
//   void moveToUserOrganization() async {
//     final loginService = LoginService();
//     responseData = await loginService.login(credentials);
//     setState(() {
//       SharedPreferencesHelper.setLoggedIn(true);
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(
//           child: Center(
//         child: Text(
//           "LOG OR REGISTER",
//           style: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       )),
//     );
//   }
// }
