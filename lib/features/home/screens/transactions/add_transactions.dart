import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/chips/choice_chip.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/expense/models/transaction_model.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/expense_and_income_widget.dart';
import 'package:wallet_view/features/home/screens/transactions/widgets/transfer_widget.dart';
import 'package:wallet_view/features/personalization/controllers/category/category_controller.dart';
import 'package:wallet_view/utils/constants/size.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();
  final _transactionController = Get.put(TransactionController());
  final _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Transaction Type Chips
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
                // Conditionally render widgets based on transaction type
                Obx(() {
                  if (_transactionController.selectedType.value == 'transfer') {
                    return TransferWidget(
                      amountController: _amountController,
                     
                    );
                  } else {
                    return ExpenseIncomeWidget(
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      amountController: _amountController,
                    );
                  }
                }),
                const SizedBox(height: WSizes.spaceBtwInputFields),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final transaction = TransactionModel(
                          id: '', // Generate a new ID or use Firebase to generate it
                          userId: _transactionController.authRepository.authUser?.uid ?? '',
                          accountId:_transactionController.selectedAccountId.value,
                          categoryId: _transactionController.selectedType.value == 'transfer'
                              ? ''
                              : _transactionController.selectedCategoryId.value,
                          description: _descriptionController.text,
                          amount: double.parse(_amountController.text),
                          date: DateTime.now().toIso8601String(),
                          type: _transactionController.selectedType.value,
                          name: _nameController.text,
                        );

                        _transactionController.createTransaction(transaction);
                        Get.back();
                      }
                    },
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
