import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = WSizes.cardRadiusLg,
    this.child,
    this.showBorder = false,
    this.padding,
    this.margin,
    this.borderColor = WColors.borderPrimary,
    this.backgroundColor = WColors.white,
  });

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final EdgeInsetsGeometry? padding, margin;
  final Color borderColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
