import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_amount_widget.dart';


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
      ]
    );
  }
}
