import 'package:flutter/material.dart';

import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/common/widget/products/cart_menu_icon.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            WTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: WColors.grey),
          ),
          // Obx(() {
          //   if (controller.profileLoading.value) {
          //     // Display the Shimmer loader while user profile is being loaded
          //     return const ShimmerEffect(width: 80, height: 15);
          //   } else {
          //     return
           Text(
                'controller.user.value.fullName',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: WColors.white),
              ),
          //   }
          // }),
        ],
      ),
      actions: [
        CardCounterIcon(
          onPressed: () {},
          iconColor: WColors.white,
        )
      ],
    );
  }
}
