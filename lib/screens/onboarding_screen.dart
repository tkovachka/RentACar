import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          const OnboardingPage(
            title: "Easy Booking",
            description: "Book a car with just a few taps.",
            imagePath: "assets/images/onboarding2.png",
          ),
          OnboardingPage(
            title: "Enjoy Your Ride",
            description: "Explore and enjoy your trip.",
            imagePath: "assets/images/onboarding3.png",
            isLastPage: true,
            onLastPageTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;
  final VoidCallback? onLastPageTap;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastPage = false,
    this.onLastPageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 300),
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(description,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 30),
        if (isLastPage)
          ElevatedButton(
            onPressed: onLastPageTap,
            child: const Text("Get Started"),
          ),
      ],
    );
  }
}
