import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_a_car/data/app_data_cache.dart';
import 'package:rent_a_car/widgets/cards/car_card.dart';
import 'package:rent_a_car/widgets/buttons/filter_button.dart';
import 'package:rent_a_car/services/car_service.dart';
import 'package:rent_a_car/services/firestore_service.dart';
import 'package:rent_a_car/services/images_service.dart';
import 'package:rent_a_car/models/car.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarService _carService = CarService();
  final FirestoreService _firestoreService = FirestoreService();
  List<Car> _cars = [];
  bool _isLoading = true;
  Set<String> selectedFilters = {};
  String? userProfilePicture;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    List<Car> cars;
    String? url;

    if(AppDataCache().hasCachedCars){
      cars = AppDataCache().cars;
    } else {
      cars = await _carService.getAllCars();
      AppDataCache().cars = cars;
    }

    if (AppDataCache().hasUrl) {
      url = AppDataCache().url;
    } else {
      String? cachedUrl = await ImageService.loadImageUrlFromCache('user_profile_picture_url');
      if(cachedUrl != null && cachedUrl.isNotEmpty){
        url = cachedUrl;
        AppDataCache().url = url;
      } else {
        url = await _firestoreService.getProfilePictureUrl();

        if (url != null && url.isNotEmpty) {
          AppDataCache().url = url;
          await ImageService.saveImageToCache(url, 'user_profile_picture_url');
        }
      }
    }

    setState(() {
      userProfilePicture = url;
      _cars = cars.take(4).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Location',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            //todo (not important) get real location
                            'Skopje, Macedonia',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: ClipOval(
                      child: userProfilePicture != null
                          ? CachedNetworkImage(
                            imageUrl: userProfilePicture!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                          : Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person, color: Colors.white),
                          ),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/myAccount'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select or search your',
                    style: TextStyle(fontSize: 20),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Favourite vehicle',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/filter');
                        },
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.filter_list,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Filter buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  ...mockFilters.map((filter) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterButton(
                          label: filter['label'],
                          isSelected: selectedFilters.contains(filter['label']),
                          icon: filter['icon'],
                          onTap: () {
                            setState(() {
                              if (selectedFilters.contains(filter['label'])) {
                                selectedFilters
                                    .remove(filter['label']); // Deselect
                              } else {
                                selectedFilters.add(filter['label']); // Select
                              }
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NormalText(text: "Browse Cars", bold: true, size: 18,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/allCars');
                    },
                    child: const LinkText(text: "View All", size: 16,)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _isLoading ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _cars.length,
                  itemBuilder: (context, index){
                    return CarCard(car: _cars[index]);
                  },
                ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        // Adjust based on the current screen
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/myBookings');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/myAccount');
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

final List<Map<String, dynamic>> mockFilters = [
  {'label': 'BMW', 'icon': Icons.directions_car},
  {'label': 'Audi', 'icon': Icons.directions_car},
  {'label': 'Mercedes', 'icon': Icons.directions_car},
  {'label': 'Porsche', 'icon': Icons.directions_car},
];
