import 'package:flutter/material.dart';

class Car {
  final String id;
  final String brand;
  final String model;
  final String type; // Economy, Compact, etc.
  final int capacity; // Number of people
  final int pricePerDay;
  final String location;
  final String imagePath;
  final double rating;
  final List<String> characteristics;
  final List<DateTimeRange> unavailableDates;

  Car({
    required this.id,
    required this.type,
    required this.brand,
    required this.model,
    required this.characteristics,
    required this.capacity,
    required this.pricePerDay,
    required this.location,
    required this.imagePath,
    required this.rating,
    required this.unavailableDates,
  });
}
