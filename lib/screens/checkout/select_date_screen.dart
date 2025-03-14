import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:table_calendar/table_calendar.dart'; // Import table_calendar package
import 'package:rent_a_car/models/booking.dart'; // Ensure this is the correct path to your Booking model
import 'package:rent_a_car/models/car.dart'; // Your Car model path

class SelectDateScreen extends StatefulWidget {
  final Car car;

  const SelectDateScreen({super.key, required this.car});

  @override
  _SelectDateScreenState createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateTimeRange?
      _dateRange;
  String? _pickupTime;
  double totalPrice = 0.0;

  Car get car => widget.car;

  double _calculateTotalPrice() {
    if (_dateRange != null) {
      final days = _dateRange!.end.difference(_dateRange!.start).inDays;
      return days *
          car.pricePerDay
              .toDouble();
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Date'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2100),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Pick Time:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickupTime == 'Morning'
                          ? null
                          : () {
                              setState(() {
                                _pickupTime = 'Morning';
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pickupTime == 'Morning'
                            ? Colors.purple
                            : Colors.white,
                      ),
                      child: const Text('Morning'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _pickupTime == 'Evening'
                          ? null
                          : () {
                              setState(() {
                                _pickupTime = 'Evening';
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _pickupTime == 'Evening'
                            ? Colors.purple
                            : Colors.white,
                      ),
                      child: const Text('Evening'),
                    ),
                  ],
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(),
                          Text(
                            '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //todo implement car.unavailableDates.add(_dateRange!);
                          //todo implement giving the booking model to checkout page

                          Navigator.popAndPushNamed(context, '/checkout');
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
      ),
    );
  }
}
