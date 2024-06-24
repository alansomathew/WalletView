import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String accountId;
  final String categoryId;
  final String description;
  final double amount;
  final String date; // ISO 8601 format
  final String type; // e.g., income, expense

  TransactionModel({
    required this.id,
    required this.userId,
    required this.accountId,
    required this.categoryId,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  // Static Function to create an empty transaction model
  static TransactionModel empty() => TransactionModel(
        id: '',
        userId: '',
        accountId: '',
        categoryId: '',
        description: '',
        amount: 0.0,
        date: '',
        type: '',
      );

  // Convert model to Json Structure for saving in the Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'accountId': accountId,
      'categoryId': categoryId,
      'description': description,
      'amount': amount,
      'date': date,
      'type': type,
    };
  }

  // Factory method to create a transaction model from a Firebase DocumentSnapshot
  factory TransactionModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return TransactionModel(
        id: document.id,
        userId: data['userId'],
        accountId: data['accountId'],
        categoryId: data['categoryId'],
        description: data['description'],
        amount: data['amount'],
        date: data['date'],
        type: data['type'],
      );
    } else {
      return TransactionModel.empty();
    }
  }
}
