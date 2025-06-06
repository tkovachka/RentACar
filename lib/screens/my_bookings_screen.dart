import 'package:flutter/material.dart';
import 'package:rent_a_car/models/booking.dart';

import 'package:rent_a_car/models/car.dart';
import 'package:rent_a_car/services/booking_service.dart';
import 'package:rent_a_car/services/car_service.dart';
import 'package:rent_a_car/widgets/cards/booking_card.dart';
import 'package:rent_a_car/widgets/cards/car_card.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final BookingsService _bookingsService = BookingsService();
  late Future<List<Map<String, dynamic>>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    _bookingsFuture = _bookingsService.getUserBookingsWithCars();
  }

  Future<void> _deleteBooking(String bookingId) async {
    await _bookingsService.removeBooking(bookingId);
    setState(_loadBookings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load bookings."));
          }
          final bookings = snapshot.data ?? [];
          if (bookings.isEmpty) {
            return const Center(child: Text("No bookings found."));
          }
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index){
              final booking = bookings[index]['booking'] as Booking;
              final car = bookings[index]['car'] as Car;

              return BookingCard(
                booking: booking,
                car: car,
                onDelete: () => _deleteBooking(booking.id),
              );
            },
          );
        },
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
