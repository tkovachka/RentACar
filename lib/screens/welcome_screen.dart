import 'package:flutter/material.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, '/onBoarding'),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/logo.webp',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/welcome-white.webp',
                fit: BoxFit.contain,
              ),
            ),
            const Align(
              alignment: Alignment(0.0, 0.2), // Adjust this for positioning below center
              child: Text(
                "Rent A Car",
                style: TextStyle(
                  fontSize: 36, // Adjust font size
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // Darker purple
                  letterSpacing: 2,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
