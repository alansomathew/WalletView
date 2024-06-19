import 'package:flutter/material.dart';

import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/device/device_utility.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';


class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? WColors.black : WColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: WColors.primary,
        labelColor: dark ? WColors.white : WColors.primary,
        unselectedLabelColor: WColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(WDeviceUtils.getAppBarHeight());
}
