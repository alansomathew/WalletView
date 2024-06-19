import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:wallet_view/common/widget/texts/baranded_title_text.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/enums.dart';
import 'package:wallet_view/utils/constants/size.dart';

class BrandTitleWithVerifiedIcon extends StatelessWidget {
  const BrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = WColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: BrandedTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        )),
        const SizedBox(width: WSizes.xs),
        Icon(
          Iconsax.verify5,
          size: WSizes.iconXs,
          color: iconColor,
        ),
      ],
    );
  }
}
