import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallet_view/common/widget/container/circular_container.dart';
import 'package:wallet_view/common/widget/products/cart_menu_icon.dart';
import 'package:wallet_view/utils/constants/colors.dart';

import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/device/device_utility.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: WColors.primary,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            right: -50,
            child: CircularContainer(
                backgroundColor: WColors.white.withOpacity(0.1)),
          ),
          Positioned(
            top: 0,
            right: -100,
            child: CircularContainer(
                backgroundColor: WColors.white.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: WSizes.md),
            child: AppBar(
              automaticallyImplyLeading: true,
              leading: showBackArrow
                  ? IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Iconsax.arrow_left))
                  : leadingIcon != null
                      ? IconButton(
                          onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                      : null,
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(WDeviceUtils.getAppBarHeight());
}
