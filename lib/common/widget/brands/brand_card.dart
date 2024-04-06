import 'package:walletview/common/widget/container/rounded_container.dart';
import 'package:walletview/common/widget/image/circular_image.dart';
import 'package:walletview/common/widget/texts/brand_title_text_with_verfied_con.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/enums.dart';
import 'package:walletview/utils/constants/image_strings.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(WSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //* Icon
            Flexible(
              child: CircularImage(
                image: WImages.darkAppLogo,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? WColors.white : WColors.black,
              ),
            ),
            const SizedBox(
              width: WSizes.spaceBtwItems / 2,
            ),

            //* Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandTitleWithVerifiedIcon(
                    title: 'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
