import 'package:finnoto_login/pages/dashboard_dart.dart';
import 'package:finnoto_login/services/login_service.dart';
import 'package:flutter/material.dart';

void main() async {

  runApp(const MyApp());
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


