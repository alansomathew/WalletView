import 'package:flutter/material.dart';
import 'package:walletview/common/widget/appbar/appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
      ), 
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}