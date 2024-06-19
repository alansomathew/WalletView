// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:walletview/data/services/storage/firebase_storage_service.dart';
// import 'package:walletview/features/shop/models/category_model.dart';
// import 'package:walletview/utils/exceptions/firebase_exceptions.dart';
// import 'package:walletview/utils/exceptions/platform_exceptions.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class CategoryRepository extends GetxController {
//   static CategoryRepository get instance => Get.find();

//   // Variables
//   final _db = FirebaseFirestore.instance;

//   // get All categories
//   Future<List<CategoryModel>> getAllCategories() async {
//     try {
//       final snapshot = await _db.collection('Categories').get();
//       final list =
//           snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
//       return list;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again';
//     }
//   }

//   // get Sub categories

//   // upload Categories yo the cloud firebase
//   Future<void> uploadDummyData(List<CategoryModel> categories) async {
//     try {
//       // upload all the categories along with their image
//       final storage = Get.put(FirebaseStorageService());

//       // loop through each category
//       for (var category in categories) {
//         // Get ImageData link from the local assets
//         final file = await storage.getImageDataFromAssets(category.image);

//         // upload the category image and get the url
//         final url = await storage.uploadImageData(
//             'Categories', file, category.name.toLowerCase());

//         // Assign the url to category image attribute
//         category.image = url;

//         // store category in Firestore
//         await _db
//             .collection('Categories')
//             .doc(category.id)
//             .set(category.toJson());
//       }
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again';
//     }
//   }
// }
