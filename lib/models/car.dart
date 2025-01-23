import 'package:flutter/material.dart';

class Car {
  final String id;
  final String brand;
  final String model;
  final String type; // Economy, Compact, etc.
  final int capacity; // Number of people
  final String location;
  final String imagePath;
  final List<String> characteristics;
  final DateTimeRange unavailableDates;

  Car({
    required this.id,
    required this.type,
    required this.brand,
    required this.model,
    required this.characteristics,
    required this.capacity,
    required this.location,
    required this.imagePath,
    required this.unavailableDates,
  });
}
