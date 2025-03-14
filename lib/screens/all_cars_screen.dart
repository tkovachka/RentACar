import 'package:flutter/material.dart';
import 'package:rent_a_car/widgets/cards/car_card.dart';
import '../models/car.dart';

class AllCarsScreen extends StatelessWidget {
  //todo implement filtering logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: mockCars.map((car) => CarCard(car: car)).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
final List<Car> mockCars = [
  Car(
    id: '1',
    brand: 'Toyota',
    model: 'Corolla',
    type: 'Economy',
    capacity: 4,
    imagePath: 'assets/images/car.png',
    location: 'Skopje City Center',
    characteristics: ['Fuel-efficient', 'Compact size'],
    unavailableDates: [],
    pricePerDay: 400,
    rating: 4.5,
  ),
  Car(
    id: '2',
    brand: 'Ford',
    model: 'Escape',
    type: 'SUV',
    capacity: 6,
    imagePath: 'assets/images/car.png',
    location: 'Skopje East',
    characteristics: ['Spacious', 'Four-wheel drive'],
    unavailableDates: [],
    pricePerDay: 200,
    rating: 4.3,
  ),
  Car(
    id: '3',
    brand: 'Mercedes-Benz',
    model: 'S-Class',
    type: 'Luxury',
    capacity: 4,
    imagePath: 'assets/images/car.png',
    location: 'Skopje West',
    characteristics: ['Luxury interior', 'Advanced safety features'],
    unavailableDates: [],
    pricePerDay: 350,
    rating: 4.9,
  ),
];