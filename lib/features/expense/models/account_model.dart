import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  //? Keep those values final which you do not want to update later
  final String id;
  final String userId;
  final String name; // e.g., bank, wallet, etc.
  final String type; // e.g., bank, wallet, etc.
  double balance;

  AccountModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.balance,
  });

  //? Static Function to create an empty user model
  static AccountModel empty() => AccountModel(
        id: '',
        userId: '',
        name: '',
        type: '',
        balance: 0.0,
      );

  //? Convert model to Json Structure for saving in the Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type,
      'balance': balance,
    };
  }

//? Factory method to create a user model from a Firebase DocumentSnapshot
  factory AccountModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AccountModel(
        id: document.id,
        userId: data['userId'],
        name: data['name'],
        type: data['type'],
        balance: data['balance'],
      );
    } else {
      return AccountModel.empty();
    }
  }
  AccountModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    double? balance,
  }) {
    return AccountModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }
}
