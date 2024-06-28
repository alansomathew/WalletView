import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/features/personalization/controllers/category/category_controller.dart';
import 'package:wallet_view/features/personalization/screens/category/category.dart';
import 'package:wallet_view/features/personalization/screens/category/widgets/category_icon_picker.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, this.category});

  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    // Use addPostFrameCallback to defer state updates until after build completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (category != null) {
        controller.initializeCategoryData(category!);
        controller.isAddCategory.value = false;
      } else {
        controller.clearCategoryData();
        controller.isAddCategory.value = true;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            controller.isAddCategory.value ? 'Add Category' : 'Edit Category')),
        actions: [
          if (!controller.isAddCategory.value)
            IconButton(
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
              onPressed: () => _showDeleteDialog(context, controller),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    _CategoryNameWidget(controller: controller),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const CategoryIconPickerWidget(),
              const TransferCategoryWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              controller.createOrUpdateCategory(category);
            },
            child: Text(controller.isAddCategory.value ? 'Add' : 'Update'),
          ),
        ),
      ),
    );
  }
  void _showDeleteDialog(BuildContext context, CategoryController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (category != null) {
                controller.deleteCategory(category!.id);
                Get.off(() => const CategoryScreen());
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class TransferCategoryWidget extends StatelessWidget {
  const TransferCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return Obx(
      () => SwitchListTile(
        secondary: Icon(MdiIcons.swapHorizontal, color: Colors.blue),
        subtitle: const Text('This is an Expense category'),
        title: const Text('Expense Category'),
        value: controller.isExpenase.value,
        onChanged: (value) {
          controller.isExpenase.value = !controller.isExpenase.value;
        },
      ),
    );
  }
}

class _CategoryNameWidget extends StatelessWidget {
  final CategoryController controller;

  _CategoryNameWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.categoryName,
      decoration: const InputDecoration(hintText: 'Enter Category Name'),
      onChanged: (value) {
        controller.categoryName.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a valid name';
        }
        return null;
      },
    );
  }
}

class CategoryIconPickerWidget extends StatelessWidget {
  const CategoryIconPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(() {
      return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text('Select Icon Title'),
        subtitle: Text('Select Icon SubTitle'),
        leading: Icon(
          IconData(controller.selectedIcon.value.codePoint,
              fontFamily: controller.selectedIcon.value.fontFamily,
              fontPackage: controller.selectedIcon.value.fontPackage),
          color: WColors.primary,
        ),
        onTap: () async {
          final IconData? result =
              await Get.to(() => const CategoryIconPickerPage());
          if (result != null) {
            controller.selectIcon(result);
          }
        },
      );
    });
  }
}
