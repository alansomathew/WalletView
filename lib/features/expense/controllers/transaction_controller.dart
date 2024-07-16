// Flutter imports
import 'package:flutter/material.dart';

// Third-party package imports
import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/categories/category_repository.dart';

// Project-specific imports - Models and Repositories
import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/features/expense/models/transaction_model.dart'; // Import category model
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/transaction/transaction_repository.dart'; // Import category repository
import 'package:wallet_view/features/personalization/model/category_model.dart';

// Project-specific imports - Utils
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

// Project-specific imports - Controllers
import 'package:wallet_view/features/expense/controllers/account_controller.dart';

class TransactionController extends GetxController {
  // Singleton instance of TransactionController
  static TransactionController get instance => Get.find();

  // Observables and Reactive Variables
  final isLoading = false.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxList<CategoryModel> categories =
      <CategoryModel>[].obs; // List of categories
  final selectedAccountId = ''.obs;
  var selectedCategoryId = RxString('');
  var selectedType = 'expense'.obs;
  var transactionAmount = 0.0.obs; // Transaction amount state
  var selectedDate = DateTime.now().obs; // Selected date and time
  var currentDescription = ''.obs; // Description
  var currentTransactionName = ''.obs; // Transaction name
  var fromAccount = Rxn<AccountModel>();
  var toAccount = Rxn<AccountModel>();
  var selectedaAccountId = ''.obs;

  // Form controllers and keys
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final nameController = TextEditingController();

  // Repositories
  final transactionRepository = Get.put(TransactionRepository());
  final authRepository = Get.put(AuthenticationRepository());
  final categoryRepository =
      Get.put(CategoryRepository()); // Category repository

  // Methods

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
    fetchCategories(); // Fetch categories
  }

  // // Fetch transactions for the current user
  // Future<void> fetchTransactions() async {
  //   try {
  //     isLoading.value = true;
  //     final fetchedTransactions =
  //         await transactionRepository.getTransactionsByUser(userId);
  //     transactions.assignAll(fetchedTransactions);
  //   } catch (e) {
  //     WLoaders.errorSnackBar(title: 'Error', message: e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Fetch categories
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final fetchedCategories =
          await categoryRepository.getCategoriesByUser(userId);
      categories.assignAll(fetchedCategories);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Fetch transactions for the current user
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      final fetchedTransactions = await transactionRepository.getTransactionsByUser(userId);

      // Sort transactions by date in descending order
      fetchedTransactions.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));

      transactions.assignAll(fetchedTransactions);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Get category by ID
  CategoryModel? getCategoryById(String categoryId) {
    return categories.firstWhereOrNull((category) => category.id == categoryId);
  }

  // Create a new transaction
  Future<void> createTransaction() async {
    try {
      isLoading.value = true;

      // Open loading dialog
      WFullscreenLoader.openLoadingDialog(
          'We are processing your information', WImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Validate Form
      if (!formKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Create Transaction
      final transaction = TransactionModel(
        id: '', // Firestore will generate the ID
        name: nameController.text,
        userId: userId,
        accountId: selectedAccountId.value,
        categoryId: selectedCategoryId.value,
        description: descriptionController.text,
        amount: double.parse(amountController.text),
        date: selectedDate.value.toIso8601String(),
        type: selectedType.value,
        fromAccountId:
            selectedType.value == 'transfer' ? fromAccount.value?.id : null,
        toAccountId:
            selectedType.value == 'transfer' ? toAccount.value?.id : null,
      );

      await transactionRepository.createTransaction(transaction);

      final accountController = Get.find<AccountController>();

      if (transaction.type == 'transfer') {
        // Deduct amount from 'from' account
        final fromAccount = accountController.accounts
            .firstWhere((acc) => acc.id == transaction.fromAccountId);
        final updatedFromBalance = fromAccount.balance - transaction.amount;
        await accountController.updateAccountBalance(
            transaction.fromAccountId!, updatedFromBalance);

        // Add amount to 'to' account
        final toAccount = accountController.accounts
            .firstWhere((acc) => acc.id == transaction.toAccountId);
        final updatedToBalance = toAccount.balance + transaction.amount;
        await accountController.updateAccountBalance(
            transaction.toAccountId!, updatedToBalance);
      } else {
        // Regular transaction logic
        final account = accountController.accounts
            .firstWhere((acc) => acc.id == transaction.accountId);
        final updatedBalance = account.balance - transaction.amount;
        await accountController.updateAccountBalance(
            transaction.accountId, updatedBalance);
      }

      await fetchTransactions();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Transaction created successfully');
      Get.back(); // Close the screen after success
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      WFullscreenLoader.stopLoadingDialog();
      isLoading.value = false;
    }
  }

  // Update an existing transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    try {
      isLoading.value = true;
      await transactionRepository.updateTransaction(transaction);
      await fetchTransactions();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Transaction updated successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Delete a transaction by ID
  Future<void> deleteTransaction(String transactionId) async {
    try {
      isLoading.value = true;
      await transactionRepository.deleteTransaction(transactionId);
      await fetchTransactions();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Transaction deleted successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Additional methods for setting values

  void setSelectedAccountId(String accountId) {
    selectedAccountId.value = accountId;
  }

  void setSelectedCategoryId(String categoryId) {
    selectedCategoryId.value = categoryId;
  }

  void setSelectedType(String type) {
    selectedType.value = type;
  }

  void setTransactionAmount(double amount) {
    transactionAmount.value = amount;
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void setCurrentDescription(String description) {
    currentDescription.value = description;
  }

  void setCurrentTransactionName(String name) {
    currentTransactionName.value = name;
  }

  void setFromAccount(AccountModel account) {
    fromAccount.value = account;
    if (toAccount.value?.id == account.id) {
      toAccount.value = null;
    }
  }

  void setToAccount(AccountModel account) {
    toAccount.value = account;
    if (fromAccount.value?.id == account.id) {
      fromAccount.value = null;
    }
  }

  // Method to get the current user ID
  String get userId => authRepository.authUser!.uid;
}
