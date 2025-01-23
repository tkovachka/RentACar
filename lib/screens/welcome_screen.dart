import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image above the title
          Image.asset(
            'assets/images/logo.jpg', // Replace with your actual image path
            height: 200, // Set a fixed height for the image
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 40),
          // App Title
          Text(
            'RentACar',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  blurRadius: 6,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Navigation Icon
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, '/onBoarding'),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                size: 32,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
