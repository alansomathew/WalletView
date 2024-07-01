import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/glassmorphism/glassmorphism.dart';
import 'package:wallet_view/features/expense/screens/widgets/account_summary.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.totalBalance,
    required this.cardHolder,

    this.onDelete,
    this.onTap,
    required this.income,
    required this.expense,
  });

  final String cardHolder;
  final String income, expense;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final String totalBalance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassmorphicContainer(
          height: 256,
          width: MediaQuery.of(context).size.width,
          borderRadius: 24,
          blur: 25,
          alignment: Alignment.bottomCenter,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.1),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
            ],
          ),
          border: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                minVerticalPadding: 10,
                title: Text(cardHolder),
                subtitle: Text(cardHolder),
                leading: Icon(
                  Icons.account_balance_outlined,
                  
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
                trailing: onDelete != null
                    ? GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              ListTile(
                minVerticalPadding: 10,
                title: Text(
                  'Total Balance',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color:WColors.white),
                ),
                subtitle: Text(
                  totalBalance,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AccountSummaryTail(
                      title: 'income'.capitalize,
                      subtitle: income,
                    ),
                  ),
                  Expanded(
                    child: AccountSummaryTail(
                      title: ('expense').capitalize,
                      subtitle: expense,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
