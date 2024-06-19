
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class WLoaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              color: WHelperFunctions.isDarkMode(Get.context!)
                  ? WColors.darkerGrey.withOpacity(0.9)
                  : WColors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  static void successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      backgroundColor: WColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: WColors.white),
    );
  }

  static void warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: WColors.warning,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: WColors.white),
    );
  }

  static void errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: WColors.white),
    );
  }
}
