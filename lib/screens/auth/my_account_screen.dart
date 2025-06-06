import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent_a_car/data/app_data_cache.dart';
import 'package:rent_a_car/services/auth_service.dart';
import 'package:rent_a_car/services/firestore_service.dart';
import 'package:rent_a_car/widgets/clickable_text_field.dart';
import 'package:rent_a_car/widgets/custom_image_picker.dart';
import 'package:rent_a_car/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rent_a_car/services/images_service.dart';

//todo think about attaching drivers licence and registration and anything else?
//todo add name and surname in model and registration page
class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({super.key});

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _firestore = FirestoreService();
  final _auth = AuthService();
  File? image;
  String? profilePictureUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeProfilePicture();
  }

  void _initializeProfilePicture() {
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    String? url;
    if(AppDataCache().hasUrl){
      url = AppDataCache().url;
    } else {
      url =
        await ImageService.loadImageUrlFromCache('user_profile_picture_url');

      if (url == null || url.isEmpty) {
        url = await _firestore.getProfilePictureUrl();

        if (url != null && url.isNotEmpty) {
          await ImageService.saveImageToCache(url, 'user_profile_picture_url');
        }
      }
      AppDataCache().url = url!;
    }

    if (mounted) {
      setState(() {
        profilePictureUrl = url;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.purple),
                onPressed: () async {
                  await _auth.logout();
                  Navigator.pushReplacementNamed(context, '/welcome');
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                CustomImagePicker(
                    profilePictureUrl: profilePictureUrl,
                    isLoading: isLoading,
                    onImageSelected: (File? selectedImage) async {
                      setState(() {
                        isLoading = true;
                      });

                      if (selectedImage == null) {
                        //user wants to delete image
                        setState(() {
                          image = null;
                          profilePictureUrl = "";
                        });
                        await _firestore.updateProfilePicture(null);
                      } else {
                        setState(() {
                          image = selectedImage;
                        });
                        await _firestore.updateProfilePicture(selectedImage);
                      }
                      String? newUrl = await _firestore.getProfilePictureUrl();

                      if (newUrl != null && newUrl.isNotEmpty) {
                        await ImageService.saveImageToCache(
                            newUrl, 'user_profile_picture_url');

                        if (mounted) {
                          setState(() {
                            profilePictureUrl = newUrl;
                            isLoading = false;
                          });
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            profilePictureUrl = "";
                            isLoading = false;
                          });
                        }
                      }
                    }),
                const SizedBox(height: 16),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
                label: "Account Information",
                icon: Icons.person,
                onTap: () {} //todo edit username form here
                ),
            const SizedBox(height: 8),
            CustomTextField(
                label: "Privacy and Security",
                icon: Icons.lock,
                onTap:
                    () {} //todo handle changing password and email validation here
                ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        // Adjust based on the current screen
        onTap: (index) {
          if (index == 0) {
            Navigator.popAndPushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.popAndPushNamed(context, '/myBookings');
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
