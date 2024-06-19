
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:walletview/data/repositories/user/user_repository.dart';
import 'package:walletview/features/authentication/screens/login/login.dart';
import 'package:walletview/features/authentication/screens/onboarding/onboarding.dart';
import 'package:walletview/features/authentication/screens/signup/verify_email.dart';
import 'package:walletview/navigation_menu.dart';
import 'package:walletview/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:walletview/utils/exceptions/firebase_exceptions.dart';
import 'package:walletview/utils/exceptions/format_exceptions.dart';
import 'package:walletview/utils/exceptions/platform_exceptions.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // get Authenticated User Data
  User? get authUser => _auth.currentUser;

  //* Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //* Function to show Relevent Screen

  screenRedirect() {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      //* Local Storage

      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /* ------------- Email and password sign-in ------------- */

  // * [EmailAuthentication] - LOGIN

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // * [EmailAuthentication] - Register

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // * [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateEmailAndPassword(
      String email, String password) async {
    try {
      // create credentials
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      // get current user and reauthenticate it with the provided credentials
      await _auth.currentUser?.reauthenticateWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // * [EmailVerification] - Mail Verification

  Future<void> sendMailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // * [EmailAuthentication] - Forget PASSWORD

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  /* ------------- Federated identity & social sign-in ------------- */

  // * [GoogleAuthentication] - Google

  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     // Trigger the authenticatio flow
  //     final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth =
  //         await userAccount?.authentication;

  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     return await _auth.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     throw WFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw WFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const WFormatException();
  //   } on PlatformException catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     throw WPlatformException(e.code).message;
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('something went wrong: $e');
  //     }
  //     // throw 'something went wrong. Please try again';
  //     return null;
  //   }
  // }

  // * [FacebookAuthentication] - FaceBook

  /* ------------- ./end Federated identity & social sign-in ------------- */

  // * [LogoutUser] - valid for any authentication

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }

  // * Delete User - Remove user Auth and Firestore Account
  /// This will delete the current logged in account from both firebase auth and firestore database.

  Future<void> deleteAccount() async {
    try {
      // Delete User from Auth
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw WFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw WFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const WFormatException();
    } on PlatformException catch (e) {
      throw WPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong. Please try again';
    }
  }
}
