import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

class AccountPageViewDotsIndicator extends StatelessWidget {
  const AccountPageViewDotsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();

    final accounts = accountController.accounts;
    final dark = WHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: WSizes.defaultSpace,
      left: 0,
      right: 0,
      child: Stack(  // Wrap with Stack
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: WSizes.defaultSpace),
            child: SmoothPageIndicator(
              controller: accountController.pageController,
              onDotClicked: (index) {
                accountController.pageController.jumpToPage(index);
              },
              count: accounts.length,
              effect: WormEffect(
                dotColor: dark ? WColors.light : WColors.dark,
                activeDotColor: dark ? WColors.primary : WColors.secondary,
                spacing: 8,
                dotWidth: 10,
                dotHeight: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
