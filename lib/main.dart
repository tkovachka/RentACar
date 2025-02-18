import 'package:flutter/material.dart';
import 'package:proekt/screens/auth/forgot_password_screen.dart';
import 'package:proekt/screens/auth/login_screen.dart';
import 'package:proekt/screens/auth/my_account_screen.dart';
import 'package:proekt/screens/auth/password_changed_screen.dart';
import 'package:proekt/screens/auth/register_screen.dart';
import 'package:proekt/screens/car_location_screen.dart';
import 'package:proekt/screens/checkout/checkout_screen.dart';
import 'package:proekt/screens/home_screen.dart';
import 'package:proekt/screens/my_bookings_screen.dart';
import 'package:proekt/screens/onboarding_screen.dart';
import 'package:proekt/screens/search_by_date_screen.dart';
import 'package:proekt/screens/welcome_screen.dart';
import 'package:proekt/screens/filter_screen.dart';
import 'package:proekt/screens/all_cars_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const WelcomeScreen(),
        '/onBoarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/passwordChanged': (context) => const PasswordChangedScreen(),
        '/myAccount': (context) => MyAccountScreen(),
        '/home': (context) => HomeScreen(),
        '/carLocation': (context) => const CarLocationScreen(),
        // '/searchByDate': (context) => const SearchByDateScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/myBookings': (context) => const MyBookingsScreen(),
        '/filter': (context) => FilterScreen(),
        '/allCars' : (context) => AllCarsScreen(),
      },
    );
  }
}

//todo: /searchByDate