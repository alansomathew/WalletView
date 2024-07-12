import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_view/data/repositories/account/account_repository.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/user/user_repository.dart';
import 'package:wallet_view/features/authentication/models/user_model.dart';
import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/features/expense/screens/account_screen.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();

  final isLoading = false.obs;
  RxList<AccountModel> accounts = <AccountModel>[].obs;
  final accountRepository = Get.put(AccountRepository());
  final authRepository = Get.put(AuthenticationRepository());
  final userRepository = Get.put(UserRepository());

  // variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final initialBalanceController = TextEditingController();
  RxMap<String, UserModel> userMap =
      <String, UserModel>{}.obs; // Map to store user data

  final RxBool bankSelected = false.obs;
  final RxBool walletSelected = false.obs;
  final RxBool creditCardSelected = false.obs;
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
    var selectedAccountId = ''.obs;

  //* update current index wwhen page scrolls
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //* jumb to spectfic dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
  }

  // Fetch all accounts for a specific user
  Future<void> fetchAccounts() async {
    try {
      isLoading.value = true;
      final userId =
          authRepository.authUser?.uid ?? ''; // Replace with actual user ID
      final fetchedAccounts = await accountRepository.getAccountsByUser(userId);
      accounts.assignAll(fetchedAccounts);
      // Fetch user data for each account
      for (var account in fetchedAccounts) {
        final user = await userRepository.getUserById(account.userId);
        if (user != null) {
          userMap[account.userId] = user;
        }
      }
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new account
  Future<void> createAccount() async {
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

      final userId = authRepository.authUser?.uid ?? '';
      String accountType = '';
      if (bankSelected.value) {
        accountType = 'Bank';
      } else if (walletSelected.value) {
        accountType = 'Wallet';
      } else if (creditCardSelected.value) {
        accountType = 'Credit Card';
      }

      final account = AccountModel(
        userId: userId,
        name: nameController.text,
        type: accountType,
        id: '',
        balance: double.parse(initialBalanceController.text),
      );

      await accountRepository.createAccount(account);
      await fetchAccounts();

      WLoaders.successSnackBar(
          title: 'Success', message: 'Account created successfully');
      WFullscreenLoader.stopLoadingDialog();
      Get.to(() => const AccountScreen());
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
      WFullscreenLoader.stopLoadingDialog();
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
   Future<void> updateAccountBalance(String accountId, double newBalance) async {
    try {
      isLoading.value = true;
      await accountRepository.updateAccountBalance(accountId, newBalance);
      await fetchAccounts();
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
   void selectAccount( accountId) {
    selectedAccountId.value = accountId;
  }
}
