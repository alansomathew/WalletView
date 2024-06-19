import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/features/authentication/controllers/signup/signup_controller.dart';

import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

class TemsAndCondition extends StatelessWidget {
  const TemsAndCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = WHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(
          width: WSizes.spaceBtwItems,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${WTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: '${WTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? WColors.white : WColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? WColors.white : WColors.primary,
                    ),
              ),
              TextSpan(
                  text: '${WTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: WTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? WColors.white : WColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? WColors.white : WColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
