import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get users => _firestore.collection('app_users');

  DocumentReference get currentUserDoc => users.doc(_auth.currentUser?.uid);

  Future<String?> getProfilePictureUrl() async {
    try {
      final snapshot = await currentUserDoc.get();

      if (!snapshot.exists) return null;

      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['profilePicture'] as String?;
    } catch (_) {
      return '';
    }
  }

  Future<String?> getUsername() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('app_users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (snapshot.exists) {
        return snapshot['username'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> updateUsername(String newUsername) async {
    try {
      await currentUserDoc.update({'username': newUsername});
      return null; // Success
    } catch (e) {
      return 'Failed to update username: ${e.toString()}';
    }
  }


  Future<String?> updateProfilePicture(File? profilePictureFile) async {
    try {
      String? oldUrl = await getProfilePictureUrl();

      //delete old picture from storage
      if (oldUrl != null && oldUrl.isNotEmpty) {
        try {
          final oldRef = FirebaseStorage.instance.refFromURL(oldUrl);
          await oldRef.delete();
        } catch (e) {
          print('Warning: Failed to delete old profile picture: $e');
          return 'FAILED TO DELETE OLD PICTURE';
        }
      }

      //if no file sent, just delete the picture
      if(profilePictureFile == null) {
        await currentUserDoc.update(({'profilePicture': FieldValue.delete()}));
        return null;
      }

      String fileName = basename(profilePictureFile.path);
      Reference storageRef =
        FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
      UploadTask uploadTask = storageRef.putFile(profilePictureFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      await currentUserDoc.update({'profilePicture': downloadUrl});

      return null; //Success
      } catch (e) {
      return 'Failed to update profile picture: ${e.toString()}';
    }
  }

  Future<String?> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return 'No authenticated user.';
      }

      await user
          .verifyBeforeUpdateEmail(newEmail); // This sends a confirmation link
      await currentUserDoc.update({'email': newEmail});
      return 'Verification email sent to $newEmail. Please confirm to complete update.';
    } catch (e) {
      return 'Failed to update email: ${e.toString()}';
    }
  }

  Future<String?> updatePassword(
      String newPassword, String confirmPassword) async {
    if (newPassword != confirmPassword) {
      return 'Passwords do not match.';
    }

    try {
      final user = _auth.currentUser;

      if (user == null) {
        return 'No authenticated user.';
      }

      await user.updatePassword(newPassword);
      return null; // Success
    } catch (e) {
      return 'Failed to update password: ${e.toString()}';
    }
  }

  Future<String?> updateProfile({
    String? newUsername,
    File? profilePictureFile,
    String? newEmail,
    String? newPassword,
    String? confirmPassword,
  }) async {
    if (newPassword != null &&
        confirmPassword != null &&
        newPassword != confirmPassword) {
      return 'Passwords do not match.';
    }

    try {
      if (newUsername != null) {
        final usernameResult = await updateUsername(newUsername);
        if (usernameResult != null) return usernameResult;
      }

      if (profilePictureFile != null) {
        final pictureResult = await updateProfilePicture(profilePictureFile);
        if (pictureResult != null) return pictureResult;
      }

      if (newEmail != null) {
        final emailResult = await updateEmail(newEmail);
        if (emailResult != null) return emailResult;
      }

      if (newPassword != null && confirmPassword != null) {
        final passwordResult =
            await updatePassword(newPassword, confirmPassword);
        if (passwordResult != null) return passwordResult;
      }

      return null; // Success
    } catch (e) {
      return 'Failed to update profile: ${e.toString()}';
    }
  }
}
