import 'package:flutter/material.dart';
import 'package:walletview/common/widget/appbar/appbar.dart';
import 'package:walletview/common/widget/appbar/drawer.dart';
import 'package:walletview/common/widget/lava/lava_clock.dart';
import 'package:walletview/features/expense/screens/widgets/account_card.dart';
import 'package:walletview/features/expense/screens/widgets/page_contoller.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      drawer: WDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LavaAnimation(
            child: SizedBox(
              height: 256,
              child: PageView.builder(
                itemCount: 2,
                itemBuilder: (_, index) {
                  return AccountCard(
                    expense: '100',
                    income: '1000',
                    totalBalance: '10000',
                    cardHolder: 'account.name' ?? '',
                    bankName: 'account.bankName' ?? '',
                    onDelete: () {},
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
          AccountPageViewDotsIndicator(
            pageController: PageController(),
            accounts: [],
          ),
        ],
      ),
    );
  }
}
