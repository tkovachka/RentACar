import 'package:flutter/material.dart';

import '../widgets/text_filter_button.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double minPrice = 100; // Min price range
  double maxPrice = 1000; // Max price range
  Set<String> selectedTypes = <String>{};
  Set<String> selectedCharacteristics = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Filter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Min Price
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${minPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${maxPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            RangeSlider(
              min: 0,
              max: 2000,
              values: RangeValues(minPrice, maxPrice),
              onChanged: (values) {
                setState(() {
                  minPrice = values.start;
                  maxPrice = values.end;
                });
              },
            ),
            const SizedBox(height: 16),

            const Text(
              'Types',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...['Economy', 'Compact', 'SUV', 'Luxury', 'Sedan'].map((type) {
                  return TextFilterButton(
                    label: type,
                    isSelected: selectedTypes.contains(type),
                    onTap: () {
                      setState(() {
                        if (selectedTypes.contains(type)) {
                          selectedTypes.remove(type);
                        } else {
                          selectedTypes.add(type);
                        }
                      });
                    },
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'Vehicle Characteristics',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...['Air-conditioning', 'Automatic', 'Manual']
                    .map((characteristic) {
                  return TextFilterButton(
                    label: characteristic,
                    isSelected:
                        selectedCharacteristics.contains(characteristic),
                    onTap: () {
                      setState(() {
                        if (selectedCharacteristics.contains(characteristic)) {
                          selectedCharacteristics.remove(characteristic);
                        } else {
                          selectedCharacteristics.add(characteristic);
                        }
                      });
                    },
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  //todo add arguments from filters to the results page
                  Navigator.popAndPushNamed(context, '/allCars', arguments: '');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                ),
                child: const Text(
                  'Show Results',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // White text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
