import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarLocationScreen extends StatelessWidget {
  const CarLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: const Text("Car Location")),
      // body:
      // GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(41.9981, 21.4254), // Skopje center coordinates
      //     zoom: 14,
      //   ),
      //   markers: {
      //     Marker(
      //       markerId: MarkerId(car['id']),
      //       position: LatLng(41.9981, 21.4254), // Replace with car location coordinates
      //       infoWindow: InfoWindow(
      //         title: "${car['brand']} ${car['model']}",
      //         snippet: car['location'],
      //       ),
      //     ),
      //   },
      // ),
    );
  }
}
