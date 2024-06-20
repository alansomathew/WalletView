import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/authentication/controllers/login/login_controller.dart';
// import 'package:get/get.dart';

import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/constants/size.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: WColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () =>controller.googleSignIn(),
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
