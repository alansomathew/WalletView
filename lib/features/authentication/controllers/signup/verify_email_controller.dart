import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wallet_view/common/widget/success_screen/success_screen.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  //? Send Email whenever verify screen apperars & set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect() ;
    super.onInit();
  }

  //* Send Email verfication Link

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendMailVerification();
      WLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify your email.');
    } catch (e) {
      WLoaders.errorSnackBar(title: 'Oh Snap!.', message: e.toString());
    }
  }

  //* Timer to automatically redirect on email verification

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _auth.currentUser?.reload();
      final user = _auth.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
              image: WImages.successfullyRegisterAnimation,
              title: WTexts.yourAccountCreatedTitle,
              subTitle: WTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ));
      }
    });
  }

  //* Manully check if email Verified

  checkEmailVerificationStatus() {
    final currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            image: WImages.successfullyRegisterAnimation,
            title: WTexts.yourAccountCreatedTitle,
            subTitle: WTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect(),
          ));
    }
  }
}
