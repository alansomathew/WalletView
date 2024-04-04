import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:walletview/features/authentication/screens/signup/widgets/terms_and_condition.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';
import 'package:walletview/utils/validators/validtion.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SignupController());
    return Form(
      // key: controller.signupFormKey,
      child: Column(
        children: [
          //* first and last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // controller: controller.firstName,
                  validator: (value) =>
                      WValidator.validateEmptyText("First Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: WTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: WSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  // controller: controller.lastName,
                  validator: (value) =>
                      WValidator.validateEmptyText("Last Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: WTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: WSizes.spaceBtwInputFields,
          ),

          //* username
          TextFormField(
            // controller: controller.username,
            validator: (value) =>
                WValidator.validateEmptyText("Username", value),
            expands: false,
            decoration: const InputDecoration(
              labelText: WTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: WSizes.spaceBtwInputFields,
          ),

          //* email
          TextFormField(
            // controller: controller.email,
            validator: (value) => WValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: WTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: WSizes.spaceBtwInputFields,
          ),

          //* phone Number
          TextFormField(
            // controller: controller.phoneNumber,
            validator: (value) => WValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: WTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: WSizes.spaceBtwInputFields,
          ),

          //* password
          TextFormField(
            // controller: controller.password,
            validator: (value) => WValidator.validatePassword(value),
            // obscureText: controller.hidePassword.value,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: WTexts.password,
              suffixIcon: IconButton(
                onPressed: () => {},
                icon: const Icon(Iconsax.eye_slash),
              ),
            ),
            //* validator:,
          ),

          const SizedBox(
            height: WSizes.spaceBtwInputFields,
          ),

          //* Terms and conditions checkbox
          const TemsAndCondition(),
          const SizedBox(
            height: WSizes.spaceBtwItems,
          ),
          //* signup button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {},
              child: const Text(WTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
