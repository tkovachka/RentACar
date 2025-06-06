import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_a_car/models/booking.dart';
import 'package:rent_a_car/services/car_service.dart';

class BookingsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionPath = 'bookings';

  Future<void> addBooking(Booking booking) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('No user is currently signed in');
    }

    final start = booking.startDate.isBefore(booking.endDate)
        ? booking.startDate
        : booking.endDate;
    final end = booking.startDate.isBefore(booking.endDate)
        ? booking.endDate
        : booking.startDate;

    final docRef = _db.collection(collectionPath).doc();
    final bookingWithId = Booking(
      id: docRef.id,
      carId: booking.carId,
      userId: currentUser.uid,
      startDate: start,
      endDate: end,
      pickupTime: booking.pickupTime,
      createdAt: booking.createdAt,
    );

    await docRef.set(bookingWithId.toMap());
  }

  Future<List<Booking>> getBookingsForCar(String carId) async {
    final snapshot = await _db
        .collection(collectionPath)
        .where('carId', isEqualTo: carId)
        .get();

    return snapshot.docs
        .map((doc) => Booking.fromMap(doc.data()))
        .toList();
  }

  Future<bool> isDateRangeAvailable(
      String carId, DateTime start, DateTime end) async {
    final bookings = await getBookingsForCar(carId);

    for (var booking in bookings) {
      if (!(end.isBefore(booking.startDate) ||
          start.isAfter(booking.endDate))) {
        return false;
      }
    }
    return true;
  }

  Future<Set<DateTime>> getUnavailableDatesForCar(String carId) async {
    final bookings = await getBookingsForCar(carId);
    final Set<DateTime> blockedDates = {};

    for (var booking in bookings) {
      DateTime current = booking.startDate;
      while (!current.isAfter(booking.endDate)) {
        blockedDates.add(DateTime(current.year, current.month, current.day));
        current = current.add(const Duration(days: 1));
      }
    }

    return blockedDates;
  }

  Future<List<Map<String, dynamic>>> getUserBookingsWithCars() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) throw Exception('No user is currently signed in');

    final snapshot = await _db
        .collection(collectionPath)
        .where('userId', isEqualTo: currentUser.uid)
        .orderBy('startDate')
        .get();

    final bookings = snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList();
    final carService = CarService();

    final List<Map<String, dynamic>> combined = [];

    for (final booking in bookings) {
      final car = await carService.getCarById(booking.carId);
      if (car != null) {
        combined.add({'booking': booking, 'car': car});
      }
    }

    return combined;
  }

  Future<void> removeBooking(String bookingId) async {
    await _db.collection(collectionPath).doc(bookingId).delete();
  }

}
