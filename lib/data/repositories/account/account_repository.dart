import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/utils/exceptions/firebase_exceptions.dart';
import 'package:wallet_view/utils/exceptions/platform_exceptions.dart';

class AccountRepository extends GetxController {
  static AccountRepository get instance => Get.find();

  // Firestore instance
  final _db = FirebaseFirestore.instance;

  // Get all accounts for a specific user
  Future<List<AccountModel>> getAccountsByUser(String userId) async {
    try {
      final snapshot = await _db.collection('accounts')
          .where('userId', isEqualTo: userId)
          .get();
      final accounts = snapshot.docs.map((doc) => AccountModel.fromSnapShot(doc)).toList();
      return accounts;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Create a new account

  Future<void> createAccount(AccountModel account) async {
    try {
      // Automatically generate a unique ID for the account
      String accountId = _db.collection('accounts').doc().id;
      account = account.copyWith(id: accountId); // Assuming you have a copyWith method in your AccountModel

      await _db.collection('accounts').doc(account.id).set(account.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update an existing account
  Future<void> updateAccount(AccountModel account) async {
    try {
      await _db.collection('accounts').doc(account.id).update(account.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete an account
  Future<void> deleteAccount(String accountId) async {
    try {
      await _db.collection('accounts').doc(accountId).delete();
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
