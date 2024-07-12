import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/transaction/transaction_repository.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';
import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/features/expense/models/transaction_model.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final isLoading = false.obs;
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  final transactionRepository = Get.put(TransactionRepository());
  final authRepository = Get.put(AuthenticationRepository());
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

  // Method to get the current user ID
  String get userId => authRepository.authUser!.uid;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      final fetchedTransactions =
          await transactionRepository.getTransactionsByUser(userId);
      transactions.assignAll(fetchedTransactions);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      isLoading.value = true;
      await transactionRepository.createTransaction(transaction);

      final accountController = Get.find<AccountController>();
      final account = accountController.accounts
          .firstWhere((acc) => acc.id == transaction.accountId);

      final updatedBalance = account.balance - transaction.amount;
      await accountController.updateAccountBalance(
          transaction.accountId, updatedBalance);

      await fetchTransactions();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Transaction created successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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
}
