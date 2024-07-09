import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_text_field.dart';

class TransactionAmountWidget extends StatelessWidget {
  const TransactionAmountWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
            controller: controller,
            hintText: 'Enter Amount', // Updated hintText
            maxLength: 13,
            maxLines: 1,
            counterText: '',
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r"[0-9 '.,-]")),
              TextInputFormatter.withFunction((oldValue, newValue) {
                try {
                  final text = newValue.text;
                  if (text.isNotEmpty) double.parse(text);
                  return newValue;
                } catch (_) {
                  // Return oldValue if parsing fails
                  return oldValue;
                }
              }),
            ],
            onChanged: (value) {
              double? amount = double.tryParse(value);
              transactionController.setTransactionAmount(amount ?? 0.0);
            },
            validator: (value) {
              if (value!.isNotEmpty) {
                return null;
              } else {
                return 'Please enter a valid amount'; // Updated validation message
              }
            },
          ),
    );
  }
}
