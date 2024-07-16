import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String name;
  final String userId;
  final String accountId;
  final String categoryId;
  final String description;
  final double amount;
  final String date; // ISO 8601 format
  final String type; // e.g., income, expense
  final String? fromAccountId; // Nullable for non-transfer transactions
  final String? toAccountId; // Nullable for non-transfer transactions

  TransactionModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.accountId,
    required this.categoryId,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    this.fromAccountId,
    this.toAccountId,
  });

  // CopyWith method for immutability and updating fields
  TransactionModel copyWith({
    String? id,
    String? name,
    String? userId,
    String? accountId,
    String? categoryId,
    String? description,
    double? amount,
    String? date,
    String? type,
    String? fromAccountId,
    String? toAccountId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
    );
  }

  // Static Function to create an empty transaction model
  static TransactionModel empty() => TransactionModel(
        id: '',
        name: '',
        userId: '',
        accountId: '',
        categoryId: '',
        description: '',
        amount: 0.0,
        date: '',
        type: '',
        fromAccountId: null,
        toAccountId: null,
      );

  // Convert model to Json Structure for saving in the Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'accountId': accountId,
      'categoryId': categoryId,
      'description': description,
      'amount': amount,
      'date': date,
      'type': type,
      'fromAccountId': fromAccountId,
      'toAccountId': toAccountId,
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
        name: data['name'],
        fromAccountId: data['fromAccountId'],
        toAccountId: data['toAccountId'],
      );
    } else {
      return TransactionModel.empty();
    }
  }
}
