import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/transactions/history.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class AllTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionController = Get.put(TransactionController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
      ),
      body: Obx(() {
        if (transactionController.transactions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              height: 5,
              color: dark ? WColors.light : WColors.dark,
            ),
            itemCount: transactionController.transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactionController.transactions[index];
              final category = transactionController.getCategoryById(transaction.categoryId);
              return TransactionHistory(
                title: transaction.description,
                subtitle: category?.name ?? 'Unknown',
                amount: transaction.amount,
                dateString: transaction.date,
                type: transaction.type,
                iconCodePoint: category?.iconData ?? 0,
                fontFamily: category?.fontFamily,
                fontPackage: category?.fontPackage,
              );
            },
          );
        }
      }),
    );
  }
}
