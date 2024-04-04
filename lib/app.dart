import 'package:flutter/material.dart';
import 'package:walletview/features/authentication/screens/login/login.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/text_strings.dart';
import 'package:walletview/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: WTexts.appName,
      themeMode: ThemeMode.system,
      theme: WAppTheme.lightTheme,
      darkTheme: WAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: WColors.primary,
        body: Center(
          child: LoginScreen(
            
          ),
        ),
      ),
    );
  }
}
