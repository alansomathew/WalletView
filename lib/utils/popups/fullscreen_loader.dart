import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletview/common/widget/loaders/animation_loader.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';


//! A utility class for managing a fullscreen loading dialog
class WFullscreenLoader {
  //* open a full screen loading dialog with a given text and animation
  //* This method doesn't return anything

  //* Parameters:
  //*   - text: The text to be displayed in the loading dialog
  //*   - animation: The lottie animation to be shown

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, //use Get.overlayContext for overlay dialogs
      barrierDismissible:
          false, //The dialog can't be dismissed by tapping outside of it
      builder: (_) => PopScope(
        canPop: false, //Disable popping with the back button
        child: Container(
            color: WHelperFunctions.isDarkMode(Get.context!)
                ? WColors.dark
                : WColors.white,
            width: double.infinity,
            height: double.infinity,
            child: AnimationLoaderWidget(text: text, animation: animation)),
      ),
    );
  }

  //* Stop the currently open loading dialog
  //* This method doesn't return anything

  static void stopLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop(); //Close the dialog using Navigator
  }
}
