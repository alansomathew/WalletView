import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/pill_accounts_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_amount_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_date_picker_widget.dart';

class TransferWidget extends StatelessWidget {
  const TransferWidget({
    Key? key,
    required this.amountController,
  }) : super(key: key);

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        TransactionAmountWidget(controller: amountController),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'context.loc.dateAndTime',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const ExpenseDatePickerWidget(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'context.loc.fromAccount',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        PillsAccountWidget(
          accountSelected: (account) {
            Get.find<TransactionController>().setFromAccount(account);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'context.loc.toAccount',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        PillsAccountWidget(
          accountSelected: (account) {
            Get.find<TransactionController>().setToAccount(account);
          },
        ),
      ],
    );
  }
}
