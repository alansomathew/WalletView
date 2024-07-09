import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_text_field.dart';

class TransactionDescriptionWidget extends StatelessWidget {
  const TransactionDescriptionWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PaisaTextFormField(
            controller: controller,
            hintText: 'description', // Localized hint text
            keyboardType: TextInputType.name,
            onChanged: (value) {
              transactionController.setCurrentDescription(value);
            },
          ),
    );
  }
}
