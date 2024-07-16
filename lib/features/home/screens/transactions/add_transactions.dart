import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/chips/choice_chip.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/expense_and_income_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transfer_widget.dart';
import 'package:wallet_view/utils/constants/size.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({super.key});

  final _transactionController = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Form(
            key: _transactionController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  children: [
                    Obx(
                      () => TChoiceChip(
                        text: 'Expense',
                        selected: _transactionController.selectedType.value == 'expense',
                        onSelected: (selected) {
                          if (selected) {
                            _transactionController.setSelectedType('expense');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => TChoiceChip(
                        text: 'Income',
                        selected: _transactionController.selectedType.value == 'income',
                        onSelected: (selected) {
                          if (selected) {
                            _transactionController.setSelectedType('income');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => TChoiceChip(
                        text: 'Transfer',
                        selected: _transactionController.selectedType.value == 'transfer',
                        onSelected: (selected) {
                          if (selected) {
                            _transactionController.setSelectedType('transfer');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: WSizes.spaceBtwInputFields),
                Obx(() {
                  if (_transactionController.selectedType.value == 'transfer') {
                    return TransferWidget(
                      amountController: _transactionController.amountController,
                    );
                  } else {
                    return ExpenseIncomeWidget(
                      nameController: _transactionController.nameController,
                      descriptionController: _transactionController.descriptionController,
                      amountController: _transactionController.amountController,
                    );
                  }
                }),
                const SizedBox(height: WSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _transactionController.createTransaction,
                    child: const Text('Add Transaction'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
