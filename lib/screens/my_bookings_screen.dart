import 'package:flutter/material.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: const Center(
        child: Text("Your bookings will be shown here.", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
