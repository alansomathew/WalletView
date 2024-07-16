import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    // Query Firestore for transactions where userId matches
    final snapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .get();

    // Map each document snapshot to a TransactionModel object and convert to list
    final transactions = snapshot.docs
        .map((doc) => TransactionModel.fromSnapShot(doc))
        .toList();

    return transactions; // Return list of TransactionModel objects
  } on FirebaseException catch (e) {
    // Handle Firebase exceptions (e.g., permission denied, not found)
    throw WFirebaseException(e.code).message; // Custom exception handling for Firebase errors
  } on PlatformException catch (e) {
    // Handle platform-specific exceptions (e.g., network error, device not supported)
    throw WPlatformException(e.code).message; // Custom exception handling for platform-specific errors
  } catch (e) {
    // Handle other generic exceptions
    throw 'Something went wrong. Please try again'; // Generic error message for other exceptions
  }
}
 // Create a new transaction in Firestore
  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      // Generate an ID for the transaction in Firestore
      DocumentReference transactionRef = _db.collection('transactions').doc();
      String transactionId = transactionRef.id;

      // Update the transaction model with the generated ID
      transaction = transaction.copyWith(id: transactionId);

      // Set the transaction data with the updated ID
      await transactionRef.set(transaction.toJson());
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message; // Custom exception handling for Firebase errors
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message; // Custom exception handling for platform-specific errors
    } catch (e) {
      debugPrint(e.toString());
      throw 'Something went wrong. Please try again'; // Generic error message for other exceptions
    }
  }

  // Update an existing transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      await _db
          .collection('transactions')
          .doc(transaction.id)
          .update(transaction.toJson());
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
