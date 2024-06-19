import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();

  // Variables
  final _firebaseStorage = FirebaseStorage.instance;

  // upload Local Assets from iDE

  // Return a Unit8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);

      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading image Data: $e';
    }
  }

  // upload Image using ImageData and cloud firebase storage
  // return the download URL of the uploaded image
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // handle exception gracefully
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Plateform Exception: ${e.message}';
      } else {
        throw 'Something went wrong!. Please try again';
      }
    }
  }

  // upload Image on cloud firebase storage
  // return the download URL of the uploaded image
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // handle exception gracefully
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Plateform Exception: ${e.message}';
      } else {
        throw 'Something went wrong!. Please try again';
      }
    }
  }
}
