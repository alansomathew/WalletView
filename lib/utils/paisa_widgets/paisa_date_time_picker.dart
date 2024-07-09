// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:


Future<TimeOfDay?> paisaTimerPicker(BuildContext context) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            dayPeriodTextStyle: Theme.of(context).textTheme.bodySmall,
            hourMinuteTextStyle: Theme.of(context).textTheme.headlineSmall,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            hourMinuteShape: const CircleBorder(),
          ),
        ),
        child: child!,
      );
    },
  );
}


Future<DateTime?> paisaDatePicker(
  BuildContext context, {
  required DateTime selectedDateTime,
}) {
  return showDatePicker(
    context: context,
    initialDate: selectedDateTime,
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            headerHelpStyle:Theme.of(context).textTheme.bodySmall,
            headerHeadlineStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        child: child!,
      );
    },
  );
}
