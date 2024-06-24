import 'package:get/get.dart';

import 'package:wallet_view/data/repositories/account/account_repository.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();

  final isLoading = false.obs;
  RxList<AccountModel> accounts = <AccountModel>[].obs;
  final accountRepository = Get.put(AccountRepository());
  final authRepository = Get.put(AuthenticationRepository());

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
  }

  // Fetch all accounts for a specific user
  Future<void> fetchAccounts() async {
    try {
      isLoading.value = true;
     final userId = authRepository.authUser?.uid?? ''; // Replace with actual user ID
      final fetchedAccounts = await accountRepository.getAccountsByUser(userId);
      accounts.assignAll(fetchedAccounts);
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new account
  Future<void> createAccount(AccountModel account) async {
    try {
      isLoading.value = true;
      await accountRepository.createAccount(account);
      await fetchAccounts();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Account created successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Update an existing account
  Future<void> updateAccount(AccountModel account) async {
    try {
      isLoading.value = true;
      await accountRepository.updateAccount(account);
      await fetchAccounts();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Account updated successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Delete an account
  Future<void> deleteAccount(String accountId) async {
    try {
      isLoading.value = true;
      await accountRepository.deleteAccount(accountId);
      await fetchAccounts();
      WLoaders.successSnackBar(
          title: 'Success', message: 'Account deleted successfully');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
