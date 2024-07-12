import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/data/repositories/account/account_repository.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/selectable_item_widget.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class SelectedAccountWidget extends StatelessWidget {
  const SelectedAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final accountRepository = Get.put(AccountRepository());

    return FutureBuilder<List<AccountModel>>(
      future: accountRepository.getAccountsByUser(transactionController.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return ListTile(
            title: const Text('Error loading accounts'),
            subtitle: Text(snapshot.error.toString()),
            trailing: const Icon(Icons.error),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return ListTile(
            onTap: () {
              
            },
            title: const Text('No accounts found'),
            subtitle: const Text('Tap to add a new account'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        final accounts = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AccountSelectedItem(accounts: accounts),
          ],
        );
      },
    );
  }
}

class AccountSelectedItem extends StatelessWidget {
  const AccountSelectedItem({
    Key? key,
    required this.accounts,
  }) : super(key: key);

  final List<AccountModel> accounts;

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();
    final accountController = Get.put(AccountController());

    return SizedBox(
      height: 160,
      child: ListView.builder(

        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: accounts.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return ItemWidget(
              color: Theme.of(context).primaryColor,
              selected: false,
              title: 'Add New',
              icon: MdiIcons.plus,
              onPressed: () {
                
              },
            );
          } else {
            final AccountModel account = accounts[index - 1];
            final user = accountController.userMap[account.userId];
            final userName = user?.fullName ?? 'Unknown User';
            return Obx(
             ()=> ItemWidget(
                color: WColors.info,
                selected:
                    account.id == transactionController.selectedAccountId.value,
                title: account.name,
                icon: MdiIcons.bankOutline,
                onPressed: () {
                  transactionController.setSelectedAccountId(account.id);
                },
                subtitle: userName,
              ),
            );
          }
        },
      ),
    );
  }
}
