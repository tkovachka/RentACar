import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'images_service.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> registerUser({
    required String email,
    required String password,
    required String username,
    File? profilePicture,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? profilePictureUrl;

      if (profilePicture != null) {
        Uint8List compressedImage = await ImageService.compressImage(profilePicture);

        String fileName = ImageService.generateFileName();
        Reference storageRef =
            _storage.ref().child('profile_pictures/$fileName)');

        UploadTask uploadTask = storageRef.putData(
          compressedImage,
          SettableMetadata(contentType: 'image/webp'),
        );
        TaskSnapshot snapshot = await uploadTask;
        profilePictureUrl = await snapshot.ref.getDownloadURL();
      }

      await _firestore
          .collection('app_users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
        'username': username,
        'profilePicture': profilePictureUrl,
        'createdAt': Timestamp.now(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //todo maybe implement logging in with username as well?
  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> logout() async {
    try {
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  User? get currentUser => _auth.currentUser;
}
