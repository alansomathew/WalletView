import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallet_view/bindings/general_bindings.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:wallet_view/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: WTexts.appName,
      themeMode: ThemeMode.system,
      theme: WAppTheme.lightTheme,
      darkTheme: WAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      //* Show loader or circular progress indicator meanwhile Authentication Repository is declaring to show relevant screen
      home: const Scaffold(
        backgroundColor: WColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}