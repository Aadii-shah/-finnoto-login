import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/models/login_credential.dart';
import '../services/login_service.dart';
import '../widgets/divider.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';
import '../widgets/my_googlesignin_button.dart';
import '../widgets/or_continue_divider.dart';
import 'user_organization.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPasswordField = false;
  bool emailFieldError = false;
  bool passwordVisible = false;

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  void handleLoginButtonTap() async {
    print("handleLoginButtonTap called");
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      print("Dispatching LoginEvent in handleLoginButtonTap");
      final credentials = LoginCredentials(email, password);
      final loginService = LoginService();
      final Map<String, dynamic>? responseData =
          await loginService.login(credentials);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserOrganization(responseData: responseData),
        ),
      );
    } else {
      setState(() {
        emailFieldError = true;
        passwordVisible = true; // Set email error state
      });
      print('Email and password are required');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = screenSize.width * 0.1;
    const double maxHorizontalPadding = 16.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.clamp(0.0, maxHorizontalPadding),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'lib/images/finnoto_logo.png',
                  height: screenSize.height * 0.1,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Enter your credentials to access your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Email/mobile number',
                  style: TextStyle(
                      color: emailFieldError ? Colors.red : Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter Email/Mobile number',
                  obscureText: false,
                  icon: IconButton(
                      icon: Icon(
                        Icons.email_outlined,
                        color: emailFieldError ? Colors.red : null,
                      ),
                      onPressed: () {}),
                ),
                Opacity(
                  opacity: showPasswordField ? 1.0 : 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText:!passwordVisible,
                        icon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const MyDivider(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTap: () {
                    if (showPasswordField) {
                      handleLoginButtonTap();
                    } else {
                      handleNextButtonTap();
                    }
                  },
                  text: showPasswordField ? 'Submit' : 'Next',
                  icon: showPasswordField
                      ? null
                      : const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(height: 20),
                const MyOrContinueDivider(),
                const SizedBox(height: 20),
                MyGoogleSignIn(
                  onTap: widget.onTap,
                  text: 'Sign In With Google',
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleNextButtonTap() {
    if (emailController.text.isNotEmpty) {
      setState(() {
        showPasswordField = true;
        emailFieldError = false;
      });
    } else {
      showPasswordField = false;
      setState(() => emailFieldError = true);
    }
  }
}
