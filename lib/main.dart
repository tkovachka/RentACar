import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_a_car/firebase_options.dart';
import 'package:rent_a_car/screens/auth/forgot_password_screen.dart';
import 'package:rent_a_car/screens/auth/login_screen.dart';
import 'package:rent_a_car/screens/auth/my_account_screen.dart';
import 'package:rent_a_car/screens/auth/password_changed_screen.dart';
import 'package:rent_a_car/screens/auth/register_screen.dart';
import 'package:rent_a_car/screens/auth/update_account_screen.dart';
import 'package:rent_a_car/screens/car_location_screen.dart';
import 'package:rent_a_car/screens/checkout/checkout_screen.dart';
import 'package:rent_a_car/screens/home_screen.dart';
import 'package:rent_a_car/screens/my_bookings_screen.dart';
import 'package:rent_a_car/screens/onboarding_screen.dart';
import 'package:rent_a_car/screens/search_by_date_screen.dart';
import 'package:rent_a_car/screens/welcome_screen.dart';
import 'package:rent_a_car/screens/filter_screen.dart';
import 'package:rent_a_car/screens/all_cars_screen.dart';
import 'package:rent_a_car/data/app_data_cache.dart';
import 'package:rent_a_car/services/car_service.dart';
import 'package:rent_a_car/services/firestore_service.dart';
import 'package:rent_a_car/services/images_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      routes: {
        '/onBoarding': (context) => const OnboardingScreen(), //done
        '/login': (context) => const LoginScreen(), //done
        '/register': (context) => const RegisterStepOne(), //done
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/passwordChanged': (context) => const PasswordChangedScreen(),
        '/myAccount': (context) => MyAccountScreen(),
        '/updateAccount': (context) => const UpdateAccountScreen(),
        '/home': (context) => HomeScreen(),
        '/carLocation': (context) => const CarLocationScreen(),
        // '/searchByDate': (context) => const SearchByDateScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/myBookings': (context) => const MyBookingsScreen(),
        '/filter': (context) => FilterScreen(),
        '/allCars': (context) => AllCarsScreen(),
      },
    );
  }
}

// Skip manual log in if user has logged in before
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return HomeScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
