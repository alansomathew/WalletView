import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/styles/spacing_styles.dart';
import 'package:wallet_view/common/widget/login_signup/form_divider.dart';
import 'package:wallet_view/common/widget/login_signup/social_buttons.dart';
import 'package:wallet_view/features/authentication/screens/login/widgets/login_form.dart';
import 'package:wallet_view/features/authentication/screens/login/widgets/login_header.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';

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
