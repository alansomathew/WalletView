import 'package:get/get.dart';

import 'package:wallet_view/data/repositories/categories/category_repository.dart';
import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // Variables
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // --Load Category data
  Future<void> fetchCategories() async {
    try {
      // show loaders while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore,APi, etc)
      final categories = await _categoryRepository.getAllCategories();

      // update the category list
      allCategories.assignAll(categories);

      // filter feaured category list
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // remove loaders
      isLoading.value = false;
    }
  }

  // --Load Selected Category data

  // Get Category or Sub category Products
}
