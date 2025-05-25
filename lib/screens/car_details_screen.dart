import 'package:flutter/material.dart';
import 'package:rent_a_car/models/car.dart';
import 'package:rent_a_car/widgets/buttons/filter_button.dart';
import 'package:rent_a_car/screens/checkout/select_date_screen.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';

class CarDetailsScreen extends StatelessWidget {
  final Car car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: "${car.brand} ${car.model}"),
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
                child: Image.network(
                  car.imageUrl,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SubtitleText(text: car.description)
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: NormalText(text: "All Features", bold: true)
              ),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    FilterButton(
                        label: 'Transmission: ${car.transmission}',
                        icon: Icons.directions_car,
                        isSelected: false,
                        onTap: () {}),
                    FilterButton(
                      label: 'Type: ${car.type}',
                      icon: Icons.directions_bus_filled,
                      isSelected: false,
                      onTap: () {},
                    ),
                    FilterButton(
                        label: 'Seats: ${car.seats}',
                        icon: Icons.event_seat,
                        isSelected: false,
                        onTap: () {}),
                    FilterButton(
                      label: 'Fuel: ${car.fuelType}',
                      icon: Icons.local_gas_station,
                      isSelected: false,
                      onTap: () {},
                    ),
                    FilterButton(
                      label: 'Cargo: ${car.cargoCapacity} ft³',
                      icon: Icons.inventory,
                      isSelected: false,
                      onTap: () {},
                    ),
                    FilterButton(
                      label: 'Year: ${car.year}',
                      icon: Icons.calendar_today,
                      isSelected: false,
                      onTap: () {},
                    ),
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
                        const NormalText(text: "Price: ",size: 16,),
                        LinkText(text: "\$${car.pricePerDay}", size: 18,),
                        const NormalText(text: "/day",size: 14,)
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
