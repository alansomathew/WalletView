import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:walletview/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:walletview/features/authentication/screens/onboarding/widgets/onboarding_navigation.dart';
import 'package:walletview/features/authentication/screens/onboarding/widgets/onboarding_nextbutton.dart';
import 'package:walletview/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:walletview/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:walletview/utils/constants/image_strings.dart';
import 'package:walletview/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
   
    return Scaffold(
      body: Stack(
        children: [
          //* horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: WImages.onBoardingImage1,
                title: WTexts.onBoardingTitle1,
                subTitle: WTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: WImages.onBoardingImage2,
                title: WTexts.onBoardingTitle2,
                subTitle: WTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: WImages.onBoardingImage3,
                title: WTexts.onBoardingTitle3,
                subTitle: WTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          //* skip button
          const OnBoardingSkip(),

          //* bot navigation smooth page indicator
          const OnBoardingNavigation(),

          //* circular button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
