import 'package:flutter/material.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/select_account_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/select_category_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_amount_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_date_picker_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_description_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transaction_name_widget.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_sub_title_widget.dart';

class ExpenseIncomeWidget extends StatelessWidget {
  const ExpenseIncomeWidget({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.amountController,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        TransactionNameWidget(controller: nameController),
        const SizedBox(height: 16),
        TransactionAmountWidget(controller: amountController),
        const SizedBox(height: 16),
        TransactionDescriptionWidget(controller: descriptionController),
        const SizedBox(height: 16),
        const PaisaSubTitle(
          title: 'context.loc.dateAndTime', // Replace with actual localization
        ),
        const ExpenseDatePickerWidget(),
        const SizedBox(height: 16),
        const SelectedAccountWidget(),
        const SizedBox(height: 16),
        const SelectCategoryWidget(),
      ],
    );
  }
}
