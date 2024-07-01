import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class AccountPageViewDotsIndicator extends StatelessWidget {
  const AccountPageViewDotsIndicator({
    super.key,
    required this.pageController,
    required this.accounts,
  });

  final List accounts;
  final PageController pageController;

  Widget _indicator(BuildContext context, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? WColors.primary : Theme.of(context).disabledColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (accounts.length == 1) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(accounts.length, (index) {
          return GestureDetector(
            onTap: () {
              pageController.jumpToPage(index);
            },
            child: Obx(() {
              final isActive = pageController.page?.round() == index;
              return _indicator(context, isActive);
            }),
          );
        }),
      ),
    );
  }
}
