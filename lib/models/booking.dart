class Booking {
  final String carId;
  final DateTime startDate;
  final DateTime endDate;
  final String pickupTime;
  final double totalPrice;

  Booking({
    required this.carId,
    required this.startDate,
    required this.endDate,
    required this.pickupTime,
    required this.totalPrice,
  });
}
