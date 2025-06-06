import 'package:rent_a_car/models/car.dart';

class AppDataCache {
  static final AppDataCache _instance = AppDataCache._internal();

  factory AppDataCache() => _instance;

  AppDataCache._internal();

  List<Car> cars = [];
  String url = '';

  bool get hasCachedCars => cars.isNotEmpty;
  bool get hasUrl => url.isNotEmpty;
}
