import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_date_time_picker.dart';
import 'package:intl/intl.dart';

class ExpenseDatePickerWidget extends StatelessWidget {
  const ExpenseDatePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        DateTime selectedDateTime = transactionController.selectedDate.value;

        return Row(
          children: [
            Expanded(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onTap: () async {
                  final DateTime? dateTime = await paisaDatePicker(
                    context,
                    selectedDateTime: selectedDateTime,
                  );
                  if (dateTime != null) {
                    transactionController.setSelectedDate(dateTime);
                  }
                },
                leading: Icon(
                  Icons.today_rounded,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                title: Text(
                  DateFormat.yMMMd().format(selectedDateTime), // Date formatting
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onTap: () async {
                  final TimeOfDay? timeOfDay = await paisaTimerPicker(context);
                  if (timeOfDay != null) {
                    selectedDateTime = DateTime(
                      selectedDateTime.year,
                      selectedDateTime.month,
                      selectedDateTime.day,
                      timeOfDay.hour,
                      timeOfDay.minute,
                    );
                    transactionController.setSelectedDate(selectedDateTime);
                  }
                },
                leading: Icon(
                  MdiIcons.clockOutline,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                title: Text(
                  DateFormat.jm().format(selectedDateTime), // Time formatting
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
