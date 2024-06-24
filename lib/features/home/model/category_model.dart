import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String userId;
  final String name;
  final String type;
  final int iconData;
  final bool isPrebuilt;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.iconData,
    this.isPrebuilt = false,
  });

  // Method to create a copy with updated fields
  CategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    int? iconData,
    bool? isPrebuilt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      iconData: iconData ?? this.iconData,
      isPrebuilt: isPrebuilt ?? this.isPrebuilt,
    );
  }

  // Static Function to create an empty category model
  static CategoryModel empty() => CategoryModel(
        id: '',
        userId: '',
        name: '',
        type: '',
        iconData: 0, // default icon
      );

  // Convert model to Json Structure for saving in the Firebase Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type,
      'isPrebuilt': isPrebuilt,
      'iconData': iconData, // store icon as integer
    };
  }

  // Factory method to create a category model from a Firebase DocumentSnapshot
  factory CategoryModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        id: document.id,
        userId: data['userId'] ?? '',
        name: data['name'] ?? '',
        type: data['type'] ?? '',
        isPrebuilt: data['isPrebuilt'] ?? false,
        iconData: data['iconData'] ?? 0,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
