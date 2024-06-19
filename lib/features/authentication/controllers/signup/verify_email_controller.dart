// import 'dart:async';


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// class VerifyEmailController extends GetxController {
//   static VerifyEmailController get instance => Get.find();

//   final _auth = FirebaseAuth.instance;

//   //? Send Email whenever verify screen apperars & set Timer for auto redirect.
//   @override
//   void onInit() {
//     sendEmailVerification();
//     setTimerForAutoRedirect() ;
//     super.onInit();
//   }

//   //* Send Email verfication Link

//   sendEmailVerification() async {
//     try {
//       await AuthenticationRepository.instance.sendMailVerification();
//       Loaders.successSnackBar(
//           title: 'Email Sent',
//           message: 'Please Check your inbox and verify your email.');
//     } catch (e) {
//       Loaders.errorSnackBar(title: 'Oh Snap!.', message: e.toString());
//     }
//   }

//   //* Timer to automatically redirect on email verification

//   setTimerForAutoRedirect() {
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       _auth.currentUser?.reload();
//       final user = _auth.currentUser;
//       if (user?.emailVerified ?? false) {
//         timer.cancel();
//         Get.off(() => SuccessScreen(
//               image: TImages.successfulPaymentIcon,
//               title: TTexts.yourAccountCreatedTitle,
//               subTitle: TTexts.yourAccountCreatedSubTitle,
//               onPressed: () =>
//                   AuthenticationRepository.instance.screenRedirect(),
//             ));
//       }
//     });
//   }

//   //* Manully check if email Verified

//   checkEmailVerificationStatus() {
//     final currentUser = _auth.currentUser;
//     if (currentUser != null && currentUser.emailVerified) {
//       Get.off(() => SuccessScreen(
//             image: TImages.successfulPaymentIcon,
//             title: TTexts.yourAccountCreatedTitle,
//             subTitle: TTexts.yourAccountCreatedSubTitle,
//             onPressed: () =>
//                 AuthenticationRepository.instance.screenRedirect(),
//           ));
//     }
//   }
// }
