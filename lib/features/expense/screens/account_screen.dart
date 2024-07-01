import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/lava/lava_clock.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';
import 'package:wallet_view/features/expense/screens/widgets/account_card.dart';
import 'package:wallet_view/features/expense/screens/widgets/add_new_account.dart';
import 'package:wallet_view/features/expense/screens/widgets/account_page_dot_indicator.dart';
import 'package:wallet_view/utils/constants/size.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());

    return Scaffold(
      body: Obx(() {
        if (accountController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final accounts = accountController.accounts;

        if (accounts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No accounts found.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LavaAnimation(
                child: SizedBox(
                  height: 256,
                  child: PageView.builder(
                    controller: PageController(),
                    itemCount: accounts.length,
                    itemBuilder: (_, index) {
                      final account = accounts[index];
                      return AccountCard(
                        expense: '100', // Replace with actual expense data
                        income: '1000', // Replace with actual income data
                        totalBalance: account.balance.toString(),
                        cardHolder: account.name,
  
                        onDelete: () {
                          accountController.deleteAccount(account.id);
                        },
                        onTap: () {
                          // Handle card tap if necessary
                        },
                      );
                    },
                  ),
                ),
              ),
              AccountPageViewDotsIndicator(
                pageController: PageController(),
                accounts: accounts,
              ),
              const SizedBox(height: WSizes.defaultSpace / 2),
              // //* Transactions
              // ListLayout(
              //   itemCount: transactions.length,
              //   itemBuilder: (_, index) {
              //     final transaction = transactions[index];
              //     return TransactionHistory(
              //       title: transaction.title,
              //       subtitle: transaction.subtitle,
              //       amount: transaction.amount,
              //     );
              //   },
              // ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewAccountScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
