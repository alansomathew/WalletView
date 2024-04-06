import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:walletview/features/authentication/screens/password/reset_password.dart';

import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';
import 'package:walletview/utils/validators/validtion.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* hEADINGS
              Text(
                WTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwItems,
              ),
              Text(
                WTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections * 2,
              ),

              //* Text Fields
              Form(
                // key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  // controller: controller.email,
                  validator: WValidator.validateEmail,
                  decoration: const InputDecoration(
                      hintText: WTexts.email,
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
              ),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),

              //* Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() =>
                        const ResetPassword(email: 'alansomathew10@gmail.com')),
                    child: const Text(WTexts.submit)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
