import 'package:flutter/material.dart';
import 'package:proekt/widgets/car_card.dart';
import 'package:proekt/widgets/filter_button.dart';

import '../models/car.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: [
              FilterButton(label: 'Economy', isSelected: false, onTap: () {}),
              FilterButton(label: 'Compact', isSelected: false, onTap: () {}),
              FilterButton(label: 'SUV', isSelected: false, onTap: () {}),
            ],
          ),
          Expanded(
            child: ListView(
                children: mockCars.map((car) => CarCard(car: car)).toList()),
          ),
        ],
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
    imagePath: '',
    location: 'Skopje City Center',
    characteristics: ['Fuel-efficient', 'Compact size'],
    unavailableDates: DateTimeRange(
      start: DateTime(2025, 1, 1),
      end: DateTime(2025, 1, 5),
    ),
  ),
  Car(
    id: '2',
    brand: 'Ford',
    model: 'Escape',
    type: 'SUV',
    capacity: 6,
    imagePath: '',
    location: 'Skopje East',
    characteristics: ['Spacious', 'Four-wheel drive'],
    unavailableDates: DateTimeRange(
      start: DateTime(2025, 1, 10),
      end: DateTime(2025, 1, 12),
    ),
  ),
  Car(
    id: '3',
    brand: 'Mercedes-Benz',
    model: 'S-Class',
    type: 'Luxury',
    capacity: 4,
    imagePath: '',
    location: 'Skopje West',
    characteristics: ['Luxury interior', 'Advanced safety features'],
    unavailableDates: DateTimeRange(
      start: DateTime(2025, 1, 15),
      end: DateTime(2025, 1, 18),
    ),
  ),
];
