import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';

class ProgressBarSlider extends StatelessWidget {
  const ProgressBarSlider({
    super.key,
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: WSizes.lg,
      animationDuration: 2500,
      // percent: 0.8,
      percent: (percent > 1) ? 1 : percent,
      // center: Text("80.0%"),
      barRadius: const Radius.circular(16),
      // progressColor: Colors.green,
      linearGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [WColors.borderPrimary, WColors.secondary]),
      backgroundColor: WColors.white,
    );
  }
}
