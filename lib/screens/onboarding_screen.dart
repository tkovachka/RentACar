import 'package:flutter/material.dart';
import 'package:rent_a_car/widgets/buttons/custom_button.dart';
import 'package:rent_a_car/widgets/page_indicator.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  //Edit the number of onboarding pages simply by adding the data here
  final List<Map<String, String>> onboardingData = [
    {
      'title': "Locate the Car",
      'description': "Your car is at your fingertips. Open the app & find the perfect car according to your needs.",
      'imagePath': "assets/images/on_boarding.png",
    },
    {
      'title': "Choose the Date",
      'description': "Available dates are shown directly in your calendar. Choose the date as easy as 1-2-3.",
      'imagePath': "assets/images/car.png",
    },
    {
      'title': "Enjoy Your Ride",
      'description': "Explore and enjoy your trip with ease.",
      'imagePath': "assets/images/on_boarding.png",
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.35,
            //todo get image from firestore, and load from network image
            child: Image.asset(
              onboardingData[_currentPage]['imagePath']!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      final data = onboardingData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(text: data['title']!),
                            const SizedBox(height: 16),
                            SubtitleText(text: data['description']!),
                            const SizedBox(height: 16),
                            PageIndicator(
                              itemCount: onboardingData.length,
                              currentIndex: _currentPage,
                            ),
                            CustomButton(
                              onPressed: () {
                                if (_currentPage < onboardingData.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                }
                              },
                              color: Colors.purple.shade300,
                              icon: Icons.arrow_forward_ios,
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
