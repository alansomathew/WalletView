import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:walletview/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/device/device_utility.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = WHelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: WDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: WSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? WColors.light : WColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
