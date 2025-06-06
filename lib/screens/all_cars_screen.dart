import 'package:flutter/material.dart';
import 'package:rent_a_car/data/app_data_cache.dart';
import 'package:rent_a_car/widgets/cards/car_card.dart';
import 'package:rent_a_car/models/car.dart';
import 'package:rent_a_car/services/car_service.dart';

class AllCarsScreen extends StatefulWidget {
  //todo implement filtering logic
  _AllCarsScreenState createState() => _AllCarsScreenState();
}

class _AllCarsScreenState extends State<AllCarsScreen> {
  final CarService _carService = CarService();
  List<Car> _cars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    List<Car> cars;

    if(AppDataCache().hasCachedCars){
      cars = AppDataCache().cars;
    } else {
      cars = await _carService.getAllCars();
      AppDataCache().cars = cars;
    }

    setState(() {
      _cars = cars;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
          ? const Center(child: CircularProgressIndicator())
        : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Filter Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _cars.length,
                itemBuilder: (context, index){
                  return CarCard(car: _cars[index]);
                }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.popAndPushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.popAndPushNamed(context, '/myFavourites');
          } else if (index == 2) {
            Navigator.popAndPushNamed(context, '/myAccount');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
