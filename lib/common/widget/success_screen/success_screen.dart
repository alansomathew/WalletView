import 'package:flutter/material.dart';

import 'package:wallet_view/common/styles/spacing_styles.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: WSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //? image
              Image(
                image: AssetImage(image),
                width: WHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //? title and subTitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwItems,
              ),

              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //? button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(
                    WTexts.tContinue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
