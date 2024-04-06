import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:walletview/features/expense/screens/expense.dart';
import 'package:walletview/features/expense/screens/graph.dart';
import 'package:walletview/features/home/screens/home.dart';
import 'package:walletview/features/spilt/spilt.dart';
import 'package:walletview/utils/constants/colors.dart';


import 'package:walletview/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = WHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: dark ? WColors.black : WColors.white,
          indicatorColor: dark
              ? WColors.white.withOpacity(0.1)
              : WColors.black.withOpacity(0.1),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.card),
              label: 'Cards',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.graph),
              label: 'Graphs',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.share),
              label: 'Spilt',
            ),
            
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ExpenseScreen(),
    const GraphScreen(),
    const SpiltScreen(),
  ];
}
