import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_view/features/personalization/controllers/category/icon_picker_controller.dart';
import 'package:wallet_view/features/personalization/screens/category/widgets/icon_pickerwidget.dart';

Future<IconData?> paisaIconPicker({
  required BuildContext context,
  IconData defaultIcon = Icons.home_rounded,
}) async {
  IconData? selectedIcon = defaultIcon;

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      icon: Icon(defaultIcon),
      title: Text(
        'Select Icon', // Replace with your localized text
        style: Theme.of(context).textTheme.labelMedium,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: IconPickerWidget(
          defaultIcon: defaultIcon,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel', // Replace with your localized text
          ),
        ),
        TextButton(
          onPressed: () {
            final controller = Get.find<IconPickerController>();
            selectedIcon = controller.selectedIcon.value;
            Navigator.of(context).pop();
          },
          child: const Text(
            'Done', // Replace with your localized text
          ),
        ),
      ],
    ),
  );
  return selectedIcon;
}
