class Car {
  final String id;
  final String brand;
  final String model;
  final int year;
  final String description;
  final String type;
  final int seats;
  final String fuelType;
  final double cargoCapacity;
  final int pricePerDay;
  final String imageUrl;
  final String transmission;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.description,
    required this.type,
    required this.seats,
    required this.fuelType,
    required this.cargoCapacity,
    required this.pricePerDay,
    required this.imageUrl,
    required this.transmission,
  });

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'year': year,
      'description': description,
      'type': type,
      'seats': seats,
      'fuelType': fuelType,
      'cargoCapacity': cargoCapacity,
      'pricePerDay': pricePerDay,
      'imageUrl': imageUrl,
      'transmission': transmission,
    };
  }

  factory Car.fromMap(String id, Map<String, dynamic> map) {
    return Car(
      id: id,
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      year: (map['year'] is int) ? map['year'] : int.tryParse(map['year'].toString()) ?? 0,
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      seats: (map['seats'] is int) ? map['seats'] : int.tryParse(map['seats'].toString()) ?? 0,
      fuelType: map['fuelType'] ?? '',
      cargoCapacity: (map['cargoCapacity'] is double)
          ? map['cargoCapacity']
          : double.tryParse(map['cargoCapacity'].toString()) ?? 0.0,
      pricePerDay: (map['pricePerDay'] is int)
          ? map['pricePerDay']
          : int.tryParse(map['pricePerDay'].toString()) ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      transmission: map['transmission'] ?? '',
    );
  }
}
