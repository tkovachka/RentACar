import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageService {
  static String generateFileName() {
    final user = FirebaseAuth.instance.currentUser;
    return '${user?.uid}_${DateTime.now().millisecondsSinceEpoch}.webp';
  }

  static Future<Uint8List> compressImage(File imageFile) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.path, generateFileName());

    XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      targetPath,
      format: CompressFormat.webp,
      quality: 80, // Adjustable quality (0-100)
    );

    if (compressedXFile == null) throw Exception("Failed to compress image");

    File compressedFile = File(compressedXFile.path);
    return compressedFile.readAsBytes();
  }

  static Future<String?> loadImageUrlFromCache(String name) async {
    final prefs = await SharedPreferences.getInstance();

    String? cachedUrl = prefs.getString(name);

    if (cachedUrl != null && cachedUrl.isNotEmpty) {
      return cachedUrl;
    }
    return null;
  }

  static Future<void> saveImageToCache(String url, String name) async {
    final prefs = await SharedPreferences.getInstance();

    if (url.isNotEmpty) {
      await prefs.setString(name, url);
    }
  }

  static Future<void> invalidateCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
