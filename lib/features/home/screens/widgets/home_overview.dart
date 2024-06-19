import 'package:flutter/material.dart';
import 'package:wallet_view/common/widget/progressbar/slider.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

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
          const Expanded(child: ProgressBarSlider(percent: .85,)),

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
                  style:  Theme.of(context).textTheme.bodyMedium!.apply(color: WColors.white),
                ),

                ///EXPENSE
                Icon(Icons.arrow_drop_down,
                    color: dark ? WColors.error : WColors.warning),
                Text(
                  '\u{20B9}350',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: WColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
