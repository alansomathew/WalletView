import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallet_view/features/personalization/settings.dart';


class CardCounterIcon extends StatelessWidget {
  const CardCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const SettingsScreen()),
          icon: Icon(
            Iconsax.user,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
