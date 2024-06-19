import 'package:flutter/material.dart';
import 'package:wallet_view/common/widget/container/circular_container.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/device/device_utility.dart';

class WDrawer extends StatelessWidget implements PreferredSizeWidget {
  const WDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: WColors.primary,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: 0,
                  child: CircularContainer(
                      backgroundColor: WColors.white.withOpacity(0.1)),
                ),
                Positioned(
                  top: 10,
                  right: 50,
                  child: CircularContainer(
                      backgroundColor: WColors.white.withOpacity(0.1)),
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: WColors.white,
                      child: Icon(
                        Icons.person,
                        color: WColors.primary,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: WSizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: WColors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: WSizes.spaceBtwItems/2,
                        ),
                        Text(
                          'john_doe@gmail.com',
                          style: TextStyle(color: WColors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(WDeviceUtils.getDrawerHeight());
}
