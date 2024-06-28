import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/features/personalization/screens/category/widgets/add_category.dart';

/// A widget that displays a single category item.
///
/// This widget is used to display a category item in a list, with an icon, name, and optional type.
///
/// Example:
/// ```dart
/// CategoryItemWidget(
///   category: CategoryModel(
///     id: 1,
///     name: 'Food',
///     iconData: 0xf1234,
///     fontFamily: 'MaterialDesignIcons',
///     fontPackage: 'aterial_design_icons_flutter',
///     color: 0xFFff0000,
///     isDefault: true,
///     type: 'Expense',
///   ),
/// )
/// ```
class CategoryItemWidget extends StatelessWidget {
  /// Creates a new instance of CategoryItemWidget.
  ///
  /// category is the category model to display.
  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        if (category.isPrebuilt) {
          return;
        } else {
          Get.to(() =>   CategoryPage(category: category));
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(category.color).withOpacity(0.3),
          child: Icon(
            IconData(
              category.iconData,
              fontFamily: category.fontFamily?? 'MaterialIcons',
              fontPackage: category.fontPackage,
            ),
            color: Color(category.color),
          ),
        ),
        title: Text(
          category.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        trailing: category.isDefault ? Icon(MdiIcons.swapHorizontal) : null,
        subtitle: category.type == ''
            ? null
            : Text(
                category.type,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurfaceVariant
                          .withOpacity(0.75),
                    ),
              ),
      ),
    );
  }
}
