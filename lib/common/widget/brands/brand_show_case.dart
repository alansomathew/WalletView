import 'package:flutter/material.dart';

import 'package:walletview/common/widget/container/rounded_container.dart';
import 'package:walletview/common/widget/brands/brand_card.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key,
    required this.images,
  });
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: WColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: WSizes.spaceBtwItems),
      padding: const EdgeInsets.all(WSizes.md),
      child: Column(
        children: [
          //* Brand with Product Count
          const BrandCard(showBorder: false),
          const SizedBox(
            height: WSizes.spaceBtwItems,
          ),

          //* Brand Top 3 Product Images
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: RoundedContainer(
        height: 100,
        backgroundColor: WHelperFunctions.isDarkMode(context)
            ? WColors.darkGrey
            : WColors.light,
        margin: const EdgeInsets.only(right: WSizes.sm),
        padding: const EdgeInsets.all(WSizes.md),
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
