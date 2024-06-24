import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/features/home/controllers/category/category_controller.dart';
import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/utils/constants/size.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
  final authRepository = AuthenticationRepository.instance;


    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WSizes.defaultSpace),
        child: Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: categoryController.categories.length,
            itemBuilder: (context, index) {
              final category = categoryController.categories[index];
              return ListTile(
                leading: Icon(
                  IconData(
                    category.iconData,
                    fontFamily: 'MaterialIcons', // Assuming material icons font
                  ),
                ),
                title: Text(category.name),
                subtitle: Text(category.type),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context, categoryController),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, CategoryController categoryController) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final TextEditingController iconController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Category Type'),
              ),
              TextField(
                controller: iconController,
                decoration: const InputDecoration(labelText: 'Icon Code'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final String name = nameController.text;
                final String type = typeController.text;
                final int iconData = int.tryParse(iconController.text) ?? 0;
                final userId = authRepository.authUser?.uid ?? ''; // Get actual user ID

                if (name.isNotEmpty && type.isNotEmpty && iconData != 0) {
                  final newCategory = CategoryModel(
                    id: '',
                    userId: userId,
                    name: name,
                    type: type,
                    iconData: iconData,
                  );
                  categoryController.createCategory(newCategory);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
