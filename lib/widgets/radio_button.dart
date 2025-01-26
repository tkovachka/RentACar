import 'package:flutter/material.dart';

enum PaymentMethod { card, cash }

class PaymentOptionRadio extends StatelessWidget {
  final String title;
  final PaymentMethod value;
  final PaymentMethod? groupValue;
  final Function(PaymentMethod?) onChanged;

  const PaymentOptionRadio({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        trailing: Radio<PaymentMethod>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Colors.purple,
        ),
      ),
    );
  }
}