import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';

import 'package:wallet_view/data/repositories/transaction/transaction_repository.dart';
import 'package:wallet_view/features/expense/models/transaction_model.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final isLoading = false.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  final transactionRepository = Get.put(TransactionRepository());
  final authRepository = Get.put(AuthenticationRepository());

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  // Fetch all transactions for a specific user
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      final userId = authRepository.authUser?.uid?? ''; // Replace with actual user ID
      final fetchedTransactions =
          await transactionRepository.getTransactionsByUser(userId);
      transactions.assignAll(fetchedTransactions);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new transaction
  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      isLoading.value = true;
      await transactionRepository.createTransaction(transaction);
      await fetchTransactions();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Transaction created successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
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

  // Delete a transaction
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
}
