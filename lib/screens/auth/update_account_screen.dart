import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_a_car/services/firestore_service.dart';

class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestore = FirestoreService();
  String username = '', email = '';
  File? profilePictureFile;

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
        profilePictureFile = File(pickedFile.path);
      });
    }
  }

  //todo make functions for each separate input field
  //todo make one functions that saves all of the fields
  void _saveProfilePicture() async {
    if (profilePictureFile != null) {
      String? result =
          await _firestore.updateProfilePicture(profilePictureFile!);
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Profile picture updated successfully.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _pickedImage == null
                    ? Image.asset(
                        "assets/images/profile_picture.jpg",
                        height: 200,
                        width: 200,
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(profilePictureFile!),
                      ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Change Profile Picture"),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Edit Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                //todo abstract textFormFiels in separate widgets
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: Colors.purple,
                    ),
                    hintText: "Username",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.purple.shade300),
                    ),
                  ),
                  onSaved: (value) => {username = value ?? ''},
                ),
                const SizedBox(height: 16),
                // Email Input Field
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.purple,
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.purple.shade300),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => {email = value ?? ''},
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveProfilePicture,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
