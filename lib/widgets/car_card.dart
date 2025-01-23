import 'package:flutter/material.dart';
import 'package:proekt/models/car.dart'; // Ensure this is the path to your Car model file.

class CarCard extends StatelessWidget {
  final Car car;

  // Constructor
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${car.brand} ${car.model}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Type: ${car.type}'),
            Text('Capacity: ${car.capacity} people'),
            Text('Location: ${car.location}'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: car.characteristics
                  .map((char) => Chip(label: Text(char)))
                  .toList(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/carDetail', arguments: car);
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
