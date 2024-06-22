import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/firebase_options.dart';

import 'app.dart';

//* Entry point of flutter App
//* Add Widgets Binding
Future<void> main() async {
//* Add Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

//* Init local storage
  await GetStorage.init();

// Todo: Init Payment Methods

// Await Native Splash 
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

// Initialize Firebase & Authentication Repository

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

// Load all the Material Design / Themes / Localizations / Bindings
  runApp(const MyApp());
}
