import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';

import 'package:wallet_view/features/personalization/controllers/category/category_controller.dart';
import 'package:wallet_view/features/personalization/model/category_model.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_pill_chip.dart';


class TransferCategoriesWidget extends StatelessWidget {
  const TransferCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());

    return Obx(() {
      final List<CategoryModel> categories = controller.categories;
      if (categories.isEmpty) {
        return ListTile(
          onTap: () {
            // Navigate to Add Category Page
          },
          title: Text('Add a new category'),
          subtitle: Text('No categories found, add one now'),
          trailing: const Icon(Icons.keyboard_arrow_right),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Category',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SelectDefaultCategoryWidget(
              categories: categories,
            ),
          ],
        );
      }
    });
  }
}

class SelectDefaultCategoryWidget extends StatelessWidget {
  const SelectDefaultCategoryWidget({
    super.key,
    required this.categories,
  });
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();

    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: List.generate(
            categories.length + 1,
            (index) {
              if (index == 0) {
                return CategoryChip(
                  selected: false,
                  onSelected: (p0) {
                    // Navigate to Add Category Page
                  },
                  icon: MdiIcons.plus.codePoint,
                  title: 'Add New',
                  color: Theme.of(context).primaryColor,
                );
              } else {
                final CategoryModel category = categories[index - 1];
                final bool selected = category.id == controller.selectedCategoryId.value;
                return CategoryChip(
                  selected: selected,
                  onSelected: (value) {
                    controller.setSelectedCategoryId(category.id);
                  },
                  icon: category.iconData,
                  fontFamily: category.fontFamily,
                  fontPackage: category.fontPackage,
                  title: category.name,
                  color: Color(category.color),
                );
              }
            },
          ),
        ),
      );
    });
  }
}
