import 'package:flutter/material.dart';

class SearchByDateScreen extends StatefulWidget {
  const SearchByDateScreen({super.key});

  @override
  _SearchByDateScreenState createState() => _SearchByDateScreenState();
}

class _SearchByDateScreenState extends State<SearchByDateScreen> {
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search by Date")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Select a Date Range",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026),
                );
                if (picked != null) {
                  setState(() {
                    selectedDateRange = picked;
                  });
                }
              },
              child: Text(selectedDateRange == null
                  ? "Choose Dates"
                  : "${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Search results are not implemented.")),
                );
              },
              child: const Text("Show Results"),
            ),
          ],
        ),
      ),
    );
  }
}
