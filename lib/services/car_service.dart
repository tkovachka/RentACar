import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_a_car/models/car.dart';

class CarService {
  final FirebaseFirestore _firestore;

  CarService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final String _collection = 'cars';

  Future<List<Car>> getAllCars() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data())).toList();
    } catch (e) {
      print('Error fetching cars: $e');
      return [];
    }
  }

  Future<Car?> getCarById(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return Car.fromMap(doc.id, doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error fetching car by ID: $e');
      return null;
    }
  }

  Future<List<Car>> getTopCars({int limit = 6}) async {
    try {
      final snapshot = await _firestore.collection(_collection)
          .limit(limit)
          .get();
      return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching top cars $e');
      return [];
    }
  }

}
