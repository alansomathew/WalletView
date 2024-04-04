import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletview/common/styles/spacing_styles.dart';
import 'package:walletview/common/widget/login_signup/form_divider.dart';
import 'package:walletview/common/widget/login_signup/social_buttons.dart';
import 'package:walletview/features/authentication/screens/login/widgets/login_form.dart';
import 'package:walletview/features/authentication/screens/login/widgets/login_header.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: WSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: <Widget>[
              const LoginHeader(),
              const LoginForm(),
              FormDivider(dividerText: WTexts.orSignInWith.capitalize!),
              const SizedBox(
                height: WSizes.spaceBtwSections,
              ),
              //* Footer
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
