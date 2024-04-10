import 'package:flutter/material.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class OverView extends StatelessWidget {
  const OverView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Row(
        children: <Widget>[
          ///LINEAR INDICATOR
          const Expanded(child: Text('aa')),

          ///MONTHLY STATS SUMMARY
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              children: <Widget>[
                ///INCOME
                Icon(Icons.arrow_drop_up,
                    color: dark ? WColors.success : WColors.secondary),
                Text(
                  '\u{20B9}2500',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                ),

                ///EXPENSE
                Icon(Icons.arrow_drop_down,
                    color: dark ? WColors.error : WColors.warning),
                Text(
                  '\u{20B9}350',
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
