
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/features/authentication/screens/password/reset_password.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //* Variables
  // final _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //* Send Reset Password Email
  sendResetPasswordEmail() async {
    try {
      // start loading
      WFullscreenLoader.openLoadingDialog(
          "Processing your request", WImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // send Email to reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Stop Loading
      WFullscreenLoader.stopLoadingDialog();
      // Show Success Screen
      WLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link send to Reset Your Password');
      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      // remove Loader
      WFullscreenLoader.stopLoadingDialog();
      // Show Error
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  resendResetPasswordEmail(String email) async {
    try {
      // start loading
      WFullscreenLoader.openLoadingDialog(
          "Processing your request", WImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // send Email to reset Password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      // Stop Loading
      WFullscreenLoader.stopLoadingDialog();
      // Show Success Screen
      WLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link send to Reset Your Password');
    } catch (e) {
      // remove Loader
      WFullscreenLoader.stopLoadingDialog();
      // Show Error
      WLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
