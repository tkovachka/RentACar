import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_a_car/widgets/buttons/custom_button.dart';
import 'package:rent_a_car/widgets/input_text_field.dart';
import 'dart:io';

import '../../services/auth_service.dart';
import '../../widgets/custom_image_picker.dart';
import '../../widgets/text/custom_text.dart';

class RegisterStepOne extends StatefulWidget {
  const RegisterStepOne({super.key});

  @override
  _RegisterStepOneState createState() => _RegisterStepOneState();
}

class _RegisterStepOneState extends State<RegisterStepOne> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegisterStepTwo(
                email: _emailController.text,
                password: _passwordController.text,
              ),
        ),
      );
    }
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
                Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 8),
                const TitleText(text: "Register", color: Colors.black),
                const SizedBox(height: 8),
                const NormalText(
                    text: "Make a new account to be able to reserve a car."),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email_rounded,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (emailValid) return null;
                      return "Please enter a valid email address@";
                    }
                    return "Please enter an email address";
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  isPassword: true,
                  hintText: 'Password',
                  icon: Icons.lock,
                  validator: (value) {
                    //todo make this pretty in provider and for each requirement color it green when it is satisfied
                    if (value != null && value.isNotEmpty) {
                      final bool passwordValid = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value);
                      if (passwordValid) return null;
                      return 'Password is weak. Read the specifications below:';
                    }
                    return "Please enter a password";
                  },
                ),
                const NormalText(text: "Password must be at least 8 characters, contain at least 1 uppercase and 1 lowercase letter, a number and a special character.", size: 12,),
                const SizedBox(height: 16,),
                CustomTextField(
                  controller: _confirmPasswordController,
                  isPassword: true,
                  hintText: 'Confirm Password',
                  icon: Icons.lock,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value == _passwordController.text) return null;
                      return "Passwords do not match";
                    }
                    return "Please repeat your password";
                  },
                ),
                const SizedBox(height: 20),
                //todo make this bigger
                CustomButton(
                  onPressed: _nextStep,
                  text: "Next",
                  icon: Icons.arrow_forward,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterStepTwo extends StatefulWidget {
  final String email;
  final String password;

  const RegisterStepTwo(
      {super.key, required this.email, required this.password});

  @override
  _RegisterStepTwoState createState() => _RegisterStepTwoState();
}

class _RegisterStepTwoState extends State<RegisterStepTwo> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  File? image;


  Future<void> _register(String email, String password, String username,
      File? profilePicture) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      String? errorMessage =
      await _authService.registerUser(email: email,
          password: password,
          username: username,
          profilePicture: image);

      Fluttertoast.showToast(
        msg: errorMessage == null
            ? "Registration successful! You can now log in."
            : "Registration error: $errorMessage",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:
        errorMessage == null ? Colors.green.shade300 : Colors.red.shade300,
        textColor:
        errorMessage == null ? Colors.green.shade900 : Colors.red.shade900,
        fontSize: 16.0,
      );

      if (errorMessage == null && mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
    //todo show errors on screen
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
                Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 8),
                const TitleText(text: "Almost done...", color: Colors.black),
                const SizedBox(height: 8),
                const NormalText(
                    text:
                    "Enter your username, pick your profile picture and you are done!"),
                const SizedBox(height: 32),
                CustomTextField(
                  hintText: "Username",
                  icon: Icons.person,
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                CustomImagePicker(onImageSelected: (File? selectedImage) {
                  setState(() {
                    image = selectedImage;
                  });
                }),
                const SizedBox(height: 10),
                const NormalText(text: "*A picture is necessary for identification when renting a car. You can skip this step now, but you must upload it later in order to rent a car.", size: 14,),
                const SizedBox(height: 20),
                CustomButton(
                    onPressed: () => _register(widget.email, widget.password, _usernameController.text, image),
                    text: "Complete Registration"
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
