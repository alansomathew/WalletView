import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/chips/choice_chip.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';

class AddNewAccountScreen extends StatelessWidget {
  AddNewAccountScreen({super.key});

  final AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(WSizes.defaultSpace),
        child: Form(
          key: accountController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: accountController.nameController,
                decoration: InputDecoration(
                  labelText: 'Account Name',
                  hintText: 'Enter account name',
                  prefixIcon:
                      const Icon(Icons.account_balance, color: WColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: WColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: WColors.primary, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: WSizes.defaultSpace),
              Wrap(
                spacing: 8,
                children: [
                  Obx(() => TChoiceChip(
                        text: 'Bank',
                        selected: accountController.bankSelected.value,
                        onSelected: (selected) {
                          accountController.bankSelected.value = selected;
                          if (selected) {
                            accountController.walletSelected.value = false;
                            accountController.creditCardSelected.value = false;
                          }
                        },
                      )),
                  Obx(() => TChoiceChip(
                        text: 'Wallet',
                        selected: accountController.walletSelected.value,
                        onSelected: (selected) {
                          accountController.walletSelected.value = selected;
                          if (selected) {
                            accountController.bankSelected.value = false;
                            accountController.creditCardSelected.value = false;
                          }
                        },
                      )),
                  Obx(() => TChoiceChip(
                        text: 'Credit Card',
                        selected: accountController.creditCardSelected.value,
                        onSelected: (selected) {
                          accountController.creditCardSelected.value = selected;
                          if (selected) {
                            accountController.bankSelected.value = false;
                            accountController.walletSelected.value = false;
                          }
                        },
                      )),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: accountController.initialBalanceController,
                decoration: InputDecoration(
                  labelText: 'Initial Balance',
                  hintText: 'Enter initial balance',
                  prefixIcon: const Icon(Icons.money, color: WColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: WColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: WColors.primary, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter initial balance';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await accountController.createAccount();
                  },
                  child: const Text('Save Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
