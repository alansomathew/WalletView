import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_view/common/widget/container/header_component.dart';
import 'package:wallet_view/common/widget/texts/section_heading.dart';
import 'package:wallet_view/common/widget/transactions/history.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/home/screens/transactions/add_transactions.dart';
import 'package:wallet_view/features/home/screens/transactions/all_transactions_screen.dart';
import 'package:wallet_view/features/home/screens/widgets/home_appbar.dart';
import 'package:wallet_view/features/home/screens/widgets/home_overview.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.put(TransactionController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* Header
            const PrimaryHeaderComponent(
              child: Column(
                children: [
                  //* AppBar
                  HomeAppBar(),
                  //* Progress Bar
                  Padding(
                    padding: EdgeInsets.only(left: WSizes.defaultSpace),
                    child: Column(
                      children: [
                        //* Headings
                        SectionHeading(
                          title: WTexts.popularCategories,
                          showActionButton: false,
                          textColor: WColors.white,
                        ),
                        SizedBox(
                          height: WSizes.spaceBtwItems,
                        ),
                        //* Categories
                        OverView(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: WSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(WSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Recent Transactions
                  SectionHeading(
                    title: WTexts.recentSpents,
                    onPressed: () => Get.to(() =>
                        AllTransactionsScreen()), // Navigate to the new screen
                  ),
                  const SizedBox(
                    height: WSizes.spaceBtwItems,
                  ),
                  Obx(() {
                    if (transactionController.transactions.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      // Limit to top 20 transactions
                      final topTransactions =
                          transactionController.transactions.take(20).toList();

                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          height: 5,
                          color: dark ? WColors.light : WColors.dark,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: topTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = topTransactions[index];
                          final category = transactionController
                              .getCategoryById(transaction.categoryId);
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
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTransactionScreen()),
        backgroundColor: WColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
