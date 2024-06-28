import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/categories/category_repository.dart';
import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/features/personalization/screens/category/category.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final CategoryRepository categoryRepository = Get.put(CategoryRepository());
  final AuthenticationRepository authRepository =
      AuthenticationRepository.instance;
  final isAddCategory = true.obs;
  final isExpenase = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  var selectedIcon = MdiIcons.home.obs;
  final String fontFamilyName = 'MaterialIcons';
  final String fontFamilyPackageName = 'material_design_icons_flutter';
  var categoryIcon = MdiIcons.home.codePoint.obs;

  // Select an icon by its code point
  void selectIcon(IconData icon) {
    categoryIcon.value = icon.codePoint;
    selectedIcon.value = icon;
    print(selectedIcon);
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void initializeCategoryData(CategoryModel category) {
    categoryName.text = category.name;
    isExpenase.value = category.type == 'expense';
    selectedIcon.value = IconData(category.iconData,
        fontFamily: 'MaterialIcons'); // Assuming you use MaterialIcons
  }

  void clearCategoryData() {
    categoryName.clear();
    isExpenase.value = true;
    selectedIcon.value = MdiIcons.home;
  }

  // Fetch all categories for a specific user
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? '';
      final fetchedCategories =
          await categoryRepository.getCategoriesByUser(userId);
      categories.assignAll(fetchedCategories);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Create or update a user-defined category
  Future<void> createOrUpdateCategory(CategoryModel? category) async {
    try {
      WFullscreenLoader.openLoadingDialog(
          'We are processing your information', WImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      if (!formKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? '';

      final newCategory = CategoryModel(
        userId: userId,
        name: categoryName.text.trim(),
        type: isExpenase.value ? 'expense' : 'income',
        iconData: selectedIcon.value.codePoint,
        fontFamily: selectedIcon.value.fontFamily,
        fontPackage: selectedIcon.value.fontPackage,
        id: category?.id ?? '',
      );

      if (category == null) {
        await categoryRepository.createCategory(userId, newCategory);
        WLoaders.successSnackBar(
            title: 'Success', message: 'Category created successfully');
      } else {
        await categoryRepository.updateCategory(userId, newCategory);
        WLoaders.successSnackBar(
            title: 'Success', message: 'Category updated successfully');
      }

      await fetchCategories();
      WFullscreenLoader.stopLoadingDialog();
      Get.to(() => const CategoryScreen());
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
      clearCategoryData(); // Clear the text controllers here
    }
  }

  // Create a new user-defined category
  void createCategory() async {
    try {
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are processing your information', WImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      // Check Internet Connectivity
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

// Validate Form
      if (!formKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? '';

      CategoryModel category = CategoryModel(
          userId: userId,
          name: categoryName.text.trim(),
          type: isExpenase.value ? 'expense' : 'income',
          iconData: selectedIcon.value.codePoint,
          id: '');

      await categoryRepository.createCategory(userId, category);
      await fetchCategories();
      // Remove loader
      WFullscreenLoader.stopLoadingDialog();

      WLoaders.successSnackBar(
          title: 'Success', message: 'Category created successfully');

      Get.to(() => const CategoryScreen());
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
      clearCategoryData(); // Clear the text controllers here
    }
  }

  // Update an existing user-defined category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? '';

      await categoryRepository.updateCategory(userId, category);
      await fetchCategories();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Category updated successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a user-defined category
  Future<void> deleteCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? '';

      await categoryRepository.deleteCategory(userId, categoryId);
      await fetchCategories();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Category deleted successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Upload predefined categories to Firestore
  Future<void> uploadPrebuiltCategories() async {
    try {
      WFullscreenLoader.openLoadingDialog('Uploading', WImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      await categoryRepository.savePrebuiltCategoriesToFirestore();
      WFullscreenLoader.stopLoadingDialog();
      WLoaders.successSnackBar(
          title: 'Success',
          message: 'Prebuilt categories uploaded successfully');
    } catch (e) {
      WFullscreenLoader.stopLoadingDialog();
      if (kDebugMode) {
        print(e);
      }
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
