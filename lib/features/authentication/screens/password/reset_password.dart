import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletview/features/authentication/screens/login/login.dart';

import 'package:walletview/utils/constants/image_strings.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Column(
            children: [
              //* Image with 60 % of screen width
              Image(
                image: const AssetImage(WImages.deliveredEmailIllustration),
                width: WHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //* title and subTitle
              Text(
                WTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwItems,
              ),

              Text(
                WTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //* button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(
                    WTexts.done,
                  ),
                ),
              ),
              const SizedBox(
                height: WSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => {},
                  child: const Text(
                    WTexts.resendEmail,
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
