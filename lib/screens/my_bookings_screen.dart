import 'package:flutter/material.dart';

import 'package:rent_a_car/models/car.dart';
import 'package:rent_a_car/widgets/cards/car_card.dart';

//todo: Get user's bookings from firestore

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Filter Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Expanded(
            //   child: CarCard(car: )),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.popAndPushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.popAndPushNamed(context, '/myFavourites');
          } else if (index == 2) {
            Navigator.popAndPushNamed(context, '/myAccount');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}