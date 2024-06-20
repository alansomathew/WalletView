
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:image_picker/image_picker.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/data/repositories/user/user_repository.dart';
import 'package:wallet_view/features/authentication/models/user_model.dart';
import 'package:wallet_view/features/authentication/screens/login/login.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  //* variables
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // fetch user Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //* Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First Update Rx user and then check if user data is already stored.if not store new data
      await fetchUserRecord();

      // Check if no user data is already stored

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          // Convert Name to first and last name
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          
          // Map Data
          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            upiId:  '',
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
          );

          // Save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      WLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  //* Delete Accounting Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(WSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure want to delete your Account permanently? This action is not reversible and all of your data will be removed permanently. ',
      confirm: ElevatedButton(
        onPressed: () async => deleteAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: WSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //* Delete Account
  Future<void> deleteAccount() async {
    try {
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are deleting your account', WImages.docerAnimation);

      // First ReAuthenticate User
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // ReAuthenticate User
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          WFullscreenLoader.stopLoadingDialog();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          WFullscreenLoader.stopLoadingDialog();
          // Get.offAll(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      // remove loading
      WFullscreenLoader.stopLoadingDialog();
      // show success message
      WLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  //* ReAuthenticate User
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'We are verifying your credentials', WImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }
      // Submit Data to Server
      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());

      await AuthenticationRepository.instance.deleteAccount();
      WFullscreenLoader.stopLoadingDialog();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      // remove loading
      WFullscreenLoader.stopLoadingDialog();
      // show success message
      WLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  //* Update User Profile Picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 520,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('users/Images/Profile/', image);

        // update User image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateUserField(json);

        user.value.profilePicture = imageUrl;
      }
      // show success message
      WLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your profile picture has been updated successfully');
    } catch (e) {
      // show success message
      WLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
