import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/categories/category_repository.dart';
import 'package:wallet_view/features/home/model/category_model.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final categoryRepository = Get.put(CategoryRepository());
  final authRepository = AuthenticationRepository.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch all categories for a specific user, including prebuilt categories
  // Fetch all categories for a specific user
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final userId =
          authRepository.authUser?.uid ?? ''; // Replace with actual user ID
      final fetchedCategories =
          await categoryRepository.getCategoriesByUser(userId);
      categories.assignAll(fetchedCategories);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new user-defined category
  Future<void> createCategory(CategoryModel category) async {
    try {
      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? ''; // Get actual user ID

      // Set the userId for the category
      category = category.copyWith(userId: userId);

      await categoryRepository.createCategory(userId, category);
      await fetchCategories();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Category created successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update an existing user-defined category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      isLoading.value = true;
      final userId = authRepository.authUser?.uid ?? ''; // Get actual user ID

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
      final userId = authRepository.authUser?.uid ?? ''; // Get actual user ID

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
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are vUploading', WImages.docerAnimation);

      // Check internet Connectivity
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
