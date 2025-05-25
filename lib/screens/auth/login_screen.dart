import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_a_car/services/auth_service.dart';
import 'package:rent_a_car/widgets/buttons/custom_button.dart';
import 'package:rent_a_car/widgets/buttons/social_signin_button.dart';
import 'package:rent_a_car/widgets/divider.dart';
import 'package:rent_a_car/widgets/input_text_field.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';

import '../../widgets/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(String email, String password) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      String? errorMessage =
          await _authService.loginUser(email: email, password: password);

      Fluttertoast.showToast(
        msg: errorMessage == null
            ? "Log in successful! Welcome."
            : "Log in error: $errorMessage",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:
            errorMessage == null ? Colors.green.shade300 : Colors.red.shade300,
        textColor:
            errorMessage == null ? Colors.green.shade900 : Colors.red.shade900,
        fontSize: 16.0,
      );

      if (errorMessage != null) {
        throw Exception(errorMessage);
      }
    } else {
      throw Exception("Form validation failed.");
    }
    //todo show errors on screen
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //todo get image from firebase and use as network image
                Image.asset(
                  "assets/images/logo.webp",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 8),
                const TitleText(text: "Welcome Back", color: Colors.black),
                const SizedBox(height: 8),
                const NormalText(
                    text:
                        "Log in to your account using email, Google or Facebook"),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  icon: Icons.email,
                  validator: (value) {
                    if (value != null) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (emailValid) return null;
                      return "Please enter a valid email";
                    }
                    return "Please enter an email address";
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  isPassword: true,
                  validator: (value) {
                    if (value != null) return null;
                    return "Please enter your password";
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/forgotPassword'),
                    child: const LinkText(text: "Forgot Password?", size: 14),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                    text: "Log In",
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoadingScreen(
                            loadingTask: () => _login(_emailController.text,
                                _passwordController.text),
                            routeName: '/home'),
                      ));
                    }),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NormalText(text: "First time here?", size: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const LinkText(text: " Register", size: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const DividerWithText("Or sign in with"),
                const SizedBox(height: 16),
                Row(
                  //todo make the buttons the same size
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                        text: "Google",
                        //todo fix this icon
                        icon: Icons.g_mobiledata_rounded,
                        iconColor: Colors.black,
                        //todo implement google auth + picking username and profilePicture
                        onPressed: () {}),
                    const SizedBox(width: 16),
                    SocialLoginButton(
                        text: "Facebook",
                        icon: Icons.facebook_rounded,
                        iconColor: Colors.blue.shade900,
                        onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
