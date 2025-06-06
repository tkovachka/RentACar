import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String carId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String pickupTime; // 'Morning' or 'Evening'
  final Timestamp createdAt;

  Booking({
    required this.id,
    required this.carId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.pickupTime,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'userId': userId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'pickupTime': pickupTime,
      'createdAt': createdAt,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      carId: map['carId'],
      userId: map['userId'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      pickupTime: map['pickupTime'],
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }


}
