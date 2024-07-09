import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:wallet_view/data/repositories/categories/category_repository.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/personalization/model/category_model.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_pill_chip.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TransactionController>();
    final categoryRepository = Get.find<CategoryRepository>();

    return FutureBuilder<List<CategoryModel>>(
      future: categoryRepository
          .getCategoriesByUser('user_id_here'), // Replace with actual user ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context,
                  '/add_category'); // Adjust according to your navigation
            },
            title: const Text('No categories found'),
            subtitle: const Text('Tap to add a new category'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        final categories = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SelectedItem(categories: categories),
          ],
        );
      },
    );
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: List.generate(
          categories.length + 1,
          (index) {
            if (index == 0) {
              return CategoryChip(
                selected: false,
                onSelected: (p0) {
                  Navigator.pushNamed(context,
                      '/add_category'); // Adjust according to your navigation
                },
                icon: MdiIcons.plus.codePoint,
                title: 'Add New',
                color: Theme.of(context).primaryColor,
              );
            } else {
              final CategoryModel category = categories[index - 1];
              return Obx(() {
                final bool selected =
                    category.id == transactionController.selectedCategoryId.value;
                return CategoryChip(
                  selected: selected,
                  onSelected: (value) {
                    transactionController.setSelectedCategoryId(category.id);
                  },
                  icon: category.iconData,
                  fontFamily: category.fontFamily,
                  fontPackage: category.fontPackage,
                  title: category.name,
                  color: Color(category.color),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
