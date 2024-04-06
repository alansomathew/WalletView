import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletview/features/authentication/screens/login/login.dart';

import 'package:walletview/utils/constants/image_strings.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(VerifyEmailController());
    return Scaffold(
      //? The close icon in the app bar is used to log out the user and redirect them to the login screen

      //? This approach is taken to handle scenarios where the user enters the registration process

      //? and the data is stored upon reopening the app ,it checks if the email is verified

      //? if not verfied the app always navigates to the verfication screen

      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Column(
            children: [
              //* image
              Image(
                image: const AssetImage(WImages.deliveredEmailIllustration),
                width: WHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //* title and subTitle
              Text(
                WTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwItems,
              ),
              Text(
                email ?? "",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwItems,
              ),
              Text(
                WTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //* buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text(
                    WTexts.tContinue,
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
