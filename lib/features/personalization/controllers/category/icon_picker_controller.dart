// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// GetX Controller
class IconPickerController extends GetxController {
  var iconKeys = iconMap.keys.toList().obs;
  var categoryIcon = MdiIcons.home.codePoint.obs;
  final String fontFamilyName = 'MaterialIcons';
  final String fontFamilyPackageName = 'material_design_icons_flutter';
  var selectedIcon = MdiIcons.home.obs;
  var filterText = ''.obs;

  // Update the selected icon
  void updateSelectedIcon(IconData icon) {
    selectedIcon.value = icon;
    print(selectedIcon);
  }

  // Select an icon by its code point
  void selectIcon(int iconCodePoint) {
    categoryIcon.value = iconCodePoint;
    print(selectedIcon);
  }

  // Filter icons based on the query
  void filterIcons(String query) {
    filterText.value = query;
    iconKeys.value = iconMap.keys
        .where((element) => element
            .toLowerCase()
            .contains(query.toLowerCase().replaceAll(' ', '')))
        .toList();
  }
}
