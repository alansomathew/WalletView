import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_view/data/repositories/user/user_repository.dart';
import 'package:wallet_view/features/personalization/controllers/user_controller.dart';
import 'package:wallet_view/features/personalization/screens/profile/profile.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

//! Controller to manage user related Functionality
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => UpdateNameController();

  //* variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final upiId = TextEditingController(); // UPI ID TextEditingController
  final phoneNumber =
      TextEditingController(); // TextEditingController for phone number
  GlobalKey<FormState> updateUserFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateUpiIdFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  //* Init user data when Home Screen Appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //* fetch user Record
  Future<void> initializeNames() async {
    try {
      firstName.text = userController.user.value.firstName;
      lastName.text = userController.user.value.lastName;
      upiId.text = userController.user.value.upiId; // Initialize UPI ID
      phoneNumber.text =
          userController.user.value.phoneNumber; // Load phone number
    } catch (e) {
      firstName.text = '';
      lastName.text = '';
      upiId.text = ''; // Initialize UPI ID to empty
      phoneNumber.text = ''; // Initialize phone number to empty
    }
  }

//* update the userName
  Future<void> updateName() async {
    try {
      //  Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are updating your information', WImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Form Validation
      if (!updateUserFormKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // update users firstname and last name in the firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateUserField(name);

      // update the Rx User value

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // remove loading
      WFullscreenLoader.stopLoadingDialog();

      // show success message
      WLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been upddated');
      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // remove loading
      WFullscreenLoader.stopLoadingDialog();

      // show error message
      WLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update user's UPI ID
  Future<void> updateUpiId() async {
    // Update UPI ID method
    try {
      //  Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are updating your information', WImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Form Validation
      if (!updateUpiIdFormKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // update users UPI ID in the firebase Firestore
      Map<String, dynamic> upiIdData = {
        'UpiId': upiId.text.trim(),
      };
      await userRepository.updateUserField(upiIdData);

      // update the Rx User value
      userController.user.value.upiId = upiId.text.trim();

      // remove loading
      WFullscreenLoader.stopLoadingDialog();

      // show success message
      WLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your UPI ID has been updated');

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // remove loading
      WFullscreenLoader.stopLoadingDialog();

      // show error message
      WLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update user's phone number
  Future<void> updatePhoneNumber() async {
    try {
      // Start loading dialog
      WFullscreenLoader.openLoadingDialog(
          'We are updating your Phone Number', WImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Validate form fields
      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Prepare data to update in Firestore
      Map<String, dynamic> phoneData = {
        'PhoneNumber': phoneNumber.text.trim(),
      };

      // Call repository to update user data
      await userRepository.updateUserField(phoneData);

      // Update Rx User value
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      // Stop loading dialog
      WFullscreenLoader.stopLoadingDialog();

      // Show success message
      WLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Phone Number has been updated');

      // Navigate back to ProfileScreen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // Stop loading dialog
      WFullscreenLoader.stopLoadingDialog();

      // Show error message
      WLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Dispose text controllers when the controller is closed
  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    upiId.dispose();
    phoneNumber.dispose();
    super.onClose();
  }
}
