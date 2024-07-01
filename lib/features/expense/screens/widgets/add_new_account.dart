import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/chips/choice_chip.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class AddNewAccountScreen extends StatelessWidget {
  AddNewAccountScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final RxBool bankSelected = false.obs;
    final RxBool walletSelected = false.obs;
    final RxBool creditCardSelected = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(WSizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Account Name',
                  hintText: 'Enter account name',
                  prefixIcon: const Icon(Icons.account_balance, color: WColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: WColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: WColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        selected: bankSelected.value,
                        onSelected: (selected) {
                          bankSelected.value = selected;
                          if (selected) {
                            walletSelected.value = false;
                            creditCardSelected.value = false;
                          }
                        },
                      )),
                  Obx(() => TChoiceChip(
                        text: 'Wallet',
                        selected: walletSelected.value,
                        onSelected: (selected) {
                          walletSelected.value = selected;
                          if (selected) {
                            bankSelected.value = false;
                            creditCardSelected.value = false;
                          }
                        },
                      )),
                  Obx(() => TChoiceChip(
                        text: 'Credit Card',
                        selected: creditCardSelected.value,
                        onSelected: (selected) {
                          creditCardSelected.value = selected;
                          if (selected) {
                            bankSelected.value = false;
                            walletSelected.value = false;
                          }
                        },
                      )),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
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
                    borderSide: const BorderSide(color: WColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      // Logic to save account details
                    }
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
