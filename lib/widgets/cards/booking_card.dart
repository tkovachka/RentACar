import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_a_car/models/car.dart';
import 'package:rent_a_car/models/booking.dart';
import 'package:rent_a_car/widgets/buttons/custom_button.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';

class BookingCard extends StatelessWidget {
  final Car car;
  final Booking booking;
  final VoidCallback onDelete;

  const BookingCard({
    super.key,
    required this.car,
    required this.booking,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                car.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            NormalText(text:
              '${car.brand} ${car.model}', bold: true, size: 20,
            ),
            const SizedBox(height: 8),
            NormalText(text: 'From: ${dateFormat.format(booking.startDate)}'),
            NormalText(text: 'To: ${dateFormat.format(booking.endDate)}'),
            NormalText(text: 'Pickup Time: ${booking.pickupTime}'),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                onPressed: onDelete,
                icon: Icons.delete,
                text: "Cancel Booking",
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
