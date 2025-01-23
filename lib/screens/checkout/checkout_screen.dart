import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _paymentMethod = 'credit_card'; // Default selected payment method
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Payment for ${car['brand']} ${car['model']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Payment Method:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text("Credit Card"),
              leading: Radio<String>(
                value: 'credit_card',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
            ),
            if (_paymentMethod == 'credit_card') ...[
              TextField(
                controller: _cardNumberController,
                decoration: const InputDecoration(labelText: "Card Number"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _expiryDateController,
                decoration:
                    const InputDecoration(labelText: "Expiry Date (MM/YY)"),
              ),
              TextField(
                controller: _cvvController,
                decoration: const InputDecoration(labelText: "CVV"),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ],
            ListTile(
              title: const Text("Cash on Pickup"),
              leading: Radio<String>(
                value: 'cash',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_paymentMethod == 'credit_card') {
                  if (_cardNumberController.text.isEmpty ||
                      _expiryDateController.text.isEmpty ||
                      _cvvController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please fill out all card details.")),
                    );
                    return;
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Booking Confirmed!")),
                );
                Navigator.pushReplacementNamed(context, '/bookingConfirmed');
              },
              child: const Text("Confirm Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
