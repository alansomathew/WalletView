import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:walletview/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //* variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //* update current index wwhen page scrolls
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //* jumb to spectfic dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  //* update current index and jumb to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final deviceStorage = GetStorage();

      if (kDebugMode) {
        print('------------ Get Storage AuthRepo ------------');
        print(deviceStorage.read('IsFirstTime'));
      }

      deviceStorage.write('IsFirstTime', false);

      Get.to(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //* update curent inex and jumb to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
