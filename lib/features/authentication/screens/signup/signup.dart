import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_view/common/widget/login_signup/form_divider.dart';
import 'package:wallet_view/common/widget/login_signup/social_buttons.dart';
import 'package:wallet_view/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  WTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: WSizes.spaceBtwSections),

                const SignupForm(),
                const SizedBox(
                  height: WSizes.spaceBtwSections,
                ),
                //* divider
                FormDivider(dividerText: WTexts.orSignUpWith.capitalize!),
                const SizedBox(
                  height: WSizes.spaceBtwSections,
                ),
                //* social media icons
                const SocialButtons(),
              ]),
        ),
      ),
    );
  }
}
