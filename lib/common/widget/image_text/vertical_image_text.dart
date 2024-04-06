import 'package:walletview/common/widget/image/circular_image.dart';
import 'package:flutter/material.dart';

import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = WColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: WSizes.spaceBtwItems),
        child: Column(
          children: [
            //? circular icon

            CircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: WSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark ? WColors.light : WColors.dark,
            ),
            // Container(
            //   width: 56,
            //   height: 56,
            //   padding: const EdgeInsets.all(TSizes.sm),
            //   decoration: BoxDecoration(
            //     color:
            //         backgroundColor ?? (dark ? TColors.black : TColors.white),
            //     borderRadius: BorderRadius.circular(100),
            //   ),
            //   child: Center(
            //     child: Image(
            //       image: AssetImage(image),
            //       fit: BoxFit.cover,
            //       color: dark ? TColors.light : TColors.dark,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: WSizes.spaceBtwItems / 2,
            ),

            //? Text
            Expanded(
              child: SizedBox(
                width: 55,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
