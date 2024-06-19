import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/device/device_utility.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: WSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: WDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(WSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? WColors.dark
                    : WColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(WSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: WColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: WColors.darkGrey,
              ),
              const SizedBox(
                width: WSizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
