import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/features/home/controllers/user_controller.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/network/network_manager.dart';
import 'package:wallet_view/utils/popups/fullscreen_loader.dart';
import 'package:wallet_view/utils/popups/loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //* variables
  final localStorage = GetStorage();

  final email = TextEditingController(); //Controller for email input
  final password = TextEditingController(); //Controller for password input
  GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(); //Form key for Form validation

  final hidePassword = true.obs; //observable for hiding / showing password
  final rememberMe = false.obs;

  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //* Email and password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'Logging you in', WImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Validate Form

      if (!loginFormKey.currentState!.validate()) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Save Data if he rember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login user using email and password Authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Stop Loading
      WFullscreenLoader.stopLoadingDialog();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Stop Loading
      WFullscreenLoader.stopLoadingDialog();

      // Show Error
      WLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  //* Google Sign In
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      WFullscreenLoader.openLoadingDialog(
          'Logging you in', WImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        WFullscreenLoader.stopLoadingDialog();
        return;
      }

      // Login user using Google Authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredential);

      // Stop Loading
      WFullscreenLoader.stopLoadingDialog();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Stop Loading
      WFullscreenLoader.stopLoadingDialog();

      // Show Error
      WLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}
