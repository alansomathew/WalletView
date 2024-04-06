import 'package:flutter/material.dart';

import 'package:walletview/common/widget/shimmers/shimmer_effect.dart';
import 'package:walletview/utils/constants/size.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) =>
            const SizedBox(width: WSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              ShimmerEffect(width: 55, height: 55, radius: 55),

              SizedBox(height: WSizes.spaceBtwItems / 2),

              // Text

              ShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
