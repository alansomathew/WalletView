import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/image_strings.dart';
import 'package:walletview/utils/constants/size.dart';



class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: WColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: WSizes.iconMd,
              height: WSizes.iconMd,
              image: AssetImage(WImages.google),
            ),
          ),
        ),
      ],
    );
  }
}
