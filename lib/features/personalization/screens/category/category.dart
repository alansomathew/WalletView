import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/features/personalization/controllers/category/category_controller.dart';
import 'package:wallet_view/features/personalization/screens/category/widgets/add_category.dart';
import 'package:wallet_view/features/personalization/screens/category/widgets/category_item.dart';
import 'package:wallet_view/utils/constants/size.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(
      CategoryController(),
    );

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Categories',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: WSizes.defaultSpace,
          top: WSizes.defaultSpace,
          bottom: WSizes.defaultSpace,
        ),
        child: Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (categoryController.categories.isEmpty) {
            return Center(
              child: Text(
                'No categories available.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(indent: 72),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: WSizes.defaultSpace),
            itemCount: categoryController.categories.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return CategoryItemWidget(
                category: categoryController.categories[index],
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CategoryPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
