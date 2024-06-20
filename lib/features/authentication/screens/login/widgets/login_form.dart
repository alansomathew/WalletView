import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallet_view/features/authentication/controllers/login/login_controller.dart';

import 'package:wallet_view/features/authentication/screens/password/forget_password.dart';
import 'package:wallet_view/features/authentication/screens/signup/signup.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/validators/validtion.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: WSizes.spaceBtwSections),
        child: Column(
          children: [
            //* email field
            TextFormField(
              controller: controller.email,
              validator: (value) => WValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: WTexts.email,
              ),
            ),
            const SizedBox(
              height: WSizes.spaceBtwInputFields,
            ),
            //* password field
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    WValidator.validateEmptyText("Password", value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: WTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
                //* validator:,
              ),
            ),

            const SizedBox(
              height: WSizes.spaceBtwInputFields / 2,
            ),
            //* remember and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*/ remember Me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    const Text(WTexts.rememberMe),
                  ],
                ),
                //* forget Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(WTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(
              height: WSizes.spaceBtwSections,
            ),
            //* signIn  button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(WTexts.signIn),
              ),
            ),

            const SizedBox(
              height: WSizes.spaceBtwItems,
            ),
            //* create accoount button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(WTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
