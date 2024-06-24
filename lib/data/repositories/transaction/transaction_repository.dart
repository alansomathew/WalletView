import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:wallet_view/features/expense/models/transaction_model.dart';
import 'package:wallet_view/utils/exceptions/firebase_exceptions.dart';
import 'package:wallet_view/utils/exceptions/platform_exceptions.dart';

class TransactionRepository extends GetxController {
  static TransactionRepository get instance => Get.find();

  // Firestore instance
  final _db = FirebaseFirestore.instance;

  // Get all transactions for a specific user
  Future<List<TransactionModel>> getTransactionsByUser(String userId) async {
    try {
      final snapshot = await _db.collection('transactions')
          .where('userId', isEqualTo: userId)
          .get();
      final transactions = snapshot.docs.map((doc) => TransactionModel.fromSnapShot(doc)).toList();
      return transactions;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Create a new transaction
  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      await _db.collection('transactions').doc(transaction.id).set(transaction.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update an existing transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      await _db.collection('transactions').doc(transaction.id).update(transaction.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete a transaction
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _db.collection('transactions').doc(transactionId).delete();
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
