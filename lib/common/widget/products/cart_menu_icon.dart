import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


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
          onPressed:onPressed,
          icon: Icon(
            Iconsax.user,
            color: iconColor,
          ),
        ),
      ],
    );
  }
}
