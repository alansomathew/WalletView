import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/utils/default/prebuilt_categories.dart';
import 'package:wallet_view/utils/exceptions/firebase_exceptions.dart';
import 'package:wallet_view/utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all categories for a specific user
  Future<List<CategoryModel>> getCategoriesByUser(String userId) async {
    try {
      final userDefinedSnapshot = await _db
          .collection('categories')
          .doc('User-defined')
          .collection(userId)
          .get();

      final prebuiltSnapshot = await _db
          .collection('categories')
          .doc('Prebuilt')
          .collection('PrebuiltCategories')
          .get();

      final userDefinedCategories = userDefinedSnapshot.docs
          .map((doc) => CategoryModel.fromSnapShot(doc))
          .toList();

      final prebuiltCategories = prebuiltSnapshot.docs
          .map((doc) => CategoryModel.fromSnapShot(doc))
          .toList();

      return [...prebuiltCategories, ...userDefinedCategories];
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Something went wrong. Please try again';
    }
  }

  // Create a new category
  Future<void> createCategory(String userId, CategoryModel category) async {
    try {
      await _db
          .collection('categories')
          .doc('UserDefined')
          .collection(userId)
          .doc(category.id)
          .set(category.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update an existing category
  Future<void> updateCategory(String userId, CategoryModel category) async {
    try {
      await _db
          .collection('categories')
          .doc('UserDefined')
          .collection(userId)
          .doc(category.id)
          .update(category.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete a category
  Future<void> deleteCategory(String userId, String categoryId) async {
    try {
      await _db
          .collection('categories')
          .doc('UserDefined')
          .collection(userId)
          .doc(categoryId)
          .delete();
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Save prebuilt categories to Firestore
  Future<void> savePrebuiltCategoriesToFirestore() async {
    final CollectionReference prebuiltCategoriesCollection = _db
        .collection('categories')
        .doc('Prebuilt')
        .collection('PrebuiltCategories');
    WriteBatch batch = _db.batch();

    for (var category in prebuiltCategories) {
      DocumentReference docRef = prebuiltCategoriesCollection.doc();
      batch.set(docRef, {
        'name': category['name'],
        'type': category['type'],
        'iconData': category['iconData'],
        'fontFamily': category['fontFamily'],
        'fontPackage': category['fontPackage'],
        'isPrebuilt': true,
      });
    }

    await batch.commit();
  }

  // Fetch all prebuilt categories
  Future<List<CategoryModel>> fetchPrebuiltCategories() async {
    final querySnapshot = await _db
        .collection('categories')
        .doc('Prebuilt')
        .collection('items')
        .get();
    return querySnapshot.docs
        .map((doc) => CategoryModel.fromSnapShot(doc))
        .toList();
  }
}
