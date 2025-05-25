import 'package:flutter/material.dart';
import 'package:rent_a_car/models/car.dart';

import 'package:rent_a_car/screens/car_details_screen.dart';

class CarCard extends StatefulWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(car: widget.car),
          ),
        );      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Car image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.car.imageUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Favorite icon in the top-right corner
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.purple,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Car brand, model, and rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.car.brand} ${widget.car.model}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.car.type,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Car capacity and price per day
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Capacity: ${widget.car.seats} people',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '\$${widget.car.pricePerDay}/day',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
