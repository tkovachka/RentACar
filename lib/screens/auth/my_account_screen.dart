import 'package:flutter/material.dart';

import '../../widgets/filter_button.dart';

class MyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
              radius: 20,
            ),
            SizedBox(width: 16),
            Text(
              'Rent A Car',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButton(
                  label: 'License',
                  icon: Icons.card_membership,
                  isSelected: true,
                  onTap: () {}, // Non-clickable for now
                ),
                FilterButton(
                  label: 'Password',
                  icon: Icons.lock,
                  isSelected: true,
                  onTap: () {}, // Non-clickable for now
                ),
                FilterButton(
                  label: 'Contract',
                  icon: Icons.file_copy,
                  isSelected: true,
                  onTap: () {}, // Non-clickable for now
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Options List
            _buildOptionItem(context, Icons.person, 'My Profile'),
            _buildOptionItem(context, Icons.directions_car, 'My Bookings'),
            _buildOptionItem(context, Icons.settings, 'Settings'),
            const Spacer(),
            // Logout Option
            Row(
              children: [
                const Icon(Icons.logout, color: Colors.purple),
                ElevatedButton(
                  onPressed: () => Navigator.popAndPushNamed(context, '/login'),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 14,
                      ),
                    ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Account is selected
        onTap: (index) {
          if (index == 0) {
            Navigator.popAndPushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.popAndPushNamed(context, '/myBookings');
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

  Widget _buildOptionItem(BuildContext context, IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}