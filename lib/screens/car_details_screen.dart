import 'package:flutter/material.dart';
import '../models/car.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the Car object passed via the arguments
    final car = ModalRoute.of(context)?.settings.arguments as Car;

    // Use the `car` object to populate the UI
    return Scaffold(
      appBar: AppBar(title: Text("${car.brand} ${car.model}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(car.imagePath, height: 200, fit: BoxFit.cover),
            Container(
              height: 200,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Text(
                "Image for ${car.brand} ${car.model}",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            // Car details
            Text(
              "${car.brand} ${car.model}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text("Type: ${car.type}"),
            Text("Capacity: ${car.capacity} people"),
            Text("Location: ${car.location}"),
            const SizedBox(height: 20),
            // Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/carLocation', arguments: car);
              },
              child: const Text("View Location"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/checkout',
                  arguments: car,
                );
              },
              child: const Text("Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
