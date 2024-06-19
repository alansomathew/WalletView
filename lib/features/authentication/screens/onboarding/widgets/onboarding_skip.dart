import 'package:flutter/material.dart';

import 'package:wallet_view/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: WDeviceUtils.getAppBarHeight(),
      right: WSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(),
        child: const Text(WTexts.skip),
      ),
    );
  }
}

