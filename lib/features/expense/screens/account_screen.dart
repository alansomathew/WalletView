import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/common/widget/lava/lava_clock.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';
import 'package:wallet_view/features/expense/screens/widgets/account_card.dart';
import 'package:wallet_view/features/expense/screens/widgets/add_new_account.dart';
import 'package:wallet_view/features/expense/screens/widgets/account_page_dot_indicator.dart';
import 'package:wallet_view/utils/constants/size.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Accounts',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LavaAnimation(
              child: SizedBox(
                height: 256,
                child: PageView.builder(
                  controller: accountController.pageController,
                  itemCount: accounts.length,
                  itemBuilder: (_, index) {
                    final account = accounts[index];
                    final user = accountController.userMap[account.userId];
                    final userName = user?.fullName ?? 'Unknown User';
                
                    return AccountCard(
                      expense: '100', // Replace with actual expense data
                      income: '1000', // Replace with actual income data
                      totalBalance: account.balance.toString(),
                      cardHolder: userName,
                      onDelete: () {
                        accountController.deleteAccount(account.id);
                      },
                      onTap: () {
                        // Handle card tap if necessary
                      },
                      bankName: account.name,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: WSizes.defaultSpace / 2),
            const AccountPageViewDotsIndicator(),
          ],
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
