import 'package:flutter/material.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';


class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key, required this.dividerText,
  });
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? WColors.darkGrey : WColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? WColors.darkGrey : WColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
