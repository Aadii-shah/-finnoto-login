
import 'package:finnoto_login/pages/dashboard_dart.dart';
import 'package:finnoto_login/pages/login_register.dart';
import 'package:finnoto_login/pages/user_organization.dart';
import 'package:finnoto_login/provider/user_preference.dart';
import 'package:finnoto_login/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:finnoto_login/pages/login_page.dart';

import 'package:http/http.dart' as http;

import 'data/models/login_credential.dart';

void main() async {



  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override

  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  final loginService = LoginService();




  @override
  void initState()   {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: MyDashBoard()

    );
    //LoginPage(onTap: ()=> {}));

  }



}


