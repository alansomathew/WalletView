import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String userId;
  final String name;
  final String type;
  final int iconData;
  final int color;
  final String? fontFamily;
  final String? fontPackage;
  final bool isDefault;
  final bool isPrebuilt;
  final double? budget;
  final bool isBudget;

  static const int defaultColor = 0xFFFFC107;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.iconData,
    this.color = defaultColor,
    this.fontFamily,
    this.fontPackage,
    this.isDefault = false,
    this.isPrebuilt = false,
    this.budget,
    this.isBudget = false,
  });

  CategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? type,
    int? iconData,
    int? color,
    String? fontFamily,
    String? fontPackage,
    bool? isDefault,
    bool? isPrebuilt,
    double? budget,
    bool? isBudget,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      iconData: iconData ?? this.iconData,
      color: color ?? this.color,
      fontFamily: fontFamily ?? this.fontFamily,
      fontPackage: fontPackage ?? this.fontPackage,
      isDefault: isDefault ?? this.isDefault,
      isPrebuilt: isPrebuilt ?? this.isPrebuilt,
      budget: budget ?? this.budget,
      isBudget: isBudget ?? this.isBudget,
    );
  }

  static CategoryModel empty() => CategoryModel(
        id: '',
        userId: '',
        name: '',
        type: '',
        iconData: 0,
        color: defaultColor,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type,
      'iconData': iconData,
      'color': color,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'isDefault': isDefault,
      'isPrebuilt': isPrebuilt,
      'budget': budget,
      'isBudget': isBudget,
    };
  }

  factory CategoryModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        id: document.id,
        userId: data['userId'] ?? '',
        name: data['name'] ?? '',
        type: data['type'] ?? '',
        iconData: data['iconData'] ?? 0,
        color: data['color'] ?? defaultColor,
        fontFamily: data['fontFamily'],
        fontPackage: data['fontPackage'],
        isDefault: data['isDefault'] ?? false,
        isPrebuilt: data['isPrebuilt'] ?? false,
        budget: (data['budget'] as num?)?.toDouble(),
        isBudget: data['isBudget'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
