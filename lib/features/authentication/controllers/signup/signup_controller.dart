import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/user/user_repository.dart';
import 'package:wallet_view/features/authentication/models/user_model.dart';
import 'package:wallet_view/features/authentication/screens/signup/verify_email.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //* variables

  final email = TextEditingController(); //Controller for email input
  final password = TextEditingController(); //Controller for password input
  final firstName = TextEditingController(); //Controller for first name input
  final lastName = TextEditingController(); //Controller for last name input
  final upiId = TextEditingController(); //Controller for username input
  final phoneNumber = TextEditingController(); //Controller for phone input
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //Form key for Form validation

  final hidePassword = true.obs; //observable for hiding / showing password
  final privacyPolicy =
      true.obs; //observable for check / uncheck privacy policy

  //* SIGNUP

  void signup() async {
    try {
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are processing your information', WImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
         WFullscreenLoader.stopLoadingDialog();
        return;
      }
      

      // Validate Form

      if (!signupFormKey.currentState!.validate()) {
         WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Privacy Policy Check

      if (!privacyPolicy.value) {
        WFullscreenLoader.stopLoadingDialog();
        WLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use',
        );
        return;
      }

      // Register user in the firebase Authentication & save user data in the firebase

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        upiId: upiId.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove loader
      WFullscreenLoader.stopLoadingDialog();

      // Show Sucess Message
      WLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue',
      );

      // Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Remove loader
      WFullscreenLoader.stopLoadingDialog();
      if (kDebugMode) {
        print(e);

        // show some Generic Error to the user
      }
      WLoaders.errorSnackBar(title: 'oh Snap!', message: e.toString());
    } 
  }
}
