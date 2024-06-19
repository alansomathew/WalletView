import 'package:flutter/material.dart';

import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';



//* Custom Class for Light & Dark Text Themes
class WCheckboxTheme {
  WCheckboxTheme._(); // To avoid creating instances

  //* Customizable Light Text Theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(WSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return WColors.white;
      } else {
        return WColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return WColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  //* Customizable Dark Text Theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(WSizes.xs)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return WColors.white;
      } else {
        return WColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return WColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
