import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proekt/widgets/car_card.dart';
import 'package:proekt/widgets/filter_button.dart';

import '../models/car.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<String> selectedFilters = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Location',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            'Skopje, Macedonia',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile_picture.jpg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select or search your',
                    style: TextStyle(fontSize: 20),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Favourite vehicle',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/filter');
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.filter_list,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Filter buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  ...mockFilters.map((filter) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterButton(
                          label: filter['label'],
                          isSelected: selectedFilters.contains(filter['label']),
                          icon: filter['icon'],
                          onTap: () {
                            setState(() {
                              if (selectedFilters.contains(filter['label'])) {
                                selectedFilters
                                    .remove(filter['label']); // Deselect
                              } else {
                                selectedFilters.add(filter['label']); // Select
                              }
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Cars',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/allCars');
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
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
        // Adjust based on the current screen
        onTap: (index) {
          if (index == 0) {
            Navigator.popAndPushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.popAndPushNamed(context, '/myBookings');
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

final List<Map<String, dynamic>> mockFilters = [
  {'label': 'BMW', 'icon': Icons.directions_car},
  {'label': 'Audi', 'icon': Icons.directions_car},
  {'label': 'Mercedes', 'icon': Icons.directions_car},
  {'label': 'Porsche', 'icon': Icons.directions_car},
];
