import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_text_field.dart';

class TransactionNameWidget extends StatelessWidget {
  const TransactionNameWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        String hintName = transactionController.selectedType.value == 'expense'
            ? 'expenseHintName'
            : 'incomeHintName';

        return PaisaTextFormField(
          maxLines: 1,
          controller: controller,
          hintText: hintName,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
          ],
          validator: (value) {
            if (value!.isNotEmpty) {
              return null;
            } else {
              return 'validName';
            }
          },
          onChanged: (value) => transactionController.setCurrentTransactionName(value),
        );
      }),
    );
  }
}
