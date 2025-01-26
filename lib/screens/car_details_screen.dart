import 'package:flutter/material.dart';
import 'package:proekt/models/car.dart';
import 'package:proekt/widgets/filter_button.dart';
import 'package:proekt/screens/checkout/select_date_screen.dart';

class CarDetailsScreen extends StatelessWidget {
  final Car car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${car.brand} ${car.model}"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  car.imagePath,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              // All Features
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'All Features:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    //todo get these from the cars characteristics
                    FilterButton(
                        label: 'Transmission: Automatic',
                        icon: Icons.directions_car,
                        isSelected: false,
                        onTap: () {}),
                    FilterButton(
                        label: 'Doors: 2',
                        icon: Icons.door_front_door,
                        isSelected: false,
                        onTap: () {}),
                    FilterButton(
                        label: 'Seats: 2',
                        icon: Icons.event_seat,
                        isSelected: false,
                        onTap: () {}),
                    FilterButton(
                        label: 'AC: Climate Control',
                        icon: Icons.ac_unit,
                        isSelected: false,
                        onTap: () {}),
                    FilterButton(
                        label: 'Fuel: Petrol',
                        icon: Icons.local_gas_station,
                        isSelected: false,
                        onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Price:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(),
                        Text(
                          '\$${car.pricePerDay}/day',
                          style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectDateScreen(car: car),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
