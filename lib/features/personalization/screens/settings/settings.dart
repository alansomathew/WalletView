import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/common/widget/container/header_component.dart';
import 'package:wallet_view/common/widget/list_tile/settings_menu_tile.dart';
import 'package:wallet_view/common/widget/list_tile/user_profile_tile.dart';
import 'package:wallet_view/common/widget/texts/section_heading.dart';
import 'package:wallet_view/data/repositories/authentication/authentication_repository.dart';
import 'package:wallet_view/features/home/controllers/category/category_controller.dart';
import 'package:wallet_view/features/personalization/screens/category/category.dart';
import 'package:wallet_view/features/personalization/screens/profile/profile.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catController = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //? Header
            PrimaryHeaderComponent(
              child: Column(
                children: [
                  //? AppBar
                  TAppBar(
                    title: Text(
                      'Accounts',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: WColors.white),
                    ),
                  ),

                  //? UserProfile Card
                  UserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),

                  const SizedBox(
                    height: WSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            //?  Body
            Padding(
              padding: const EdgeInsets.all(WSizes.defaultSpace),
              child: Column(
                children: [
                  //? Account Settings
                  const SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: WSizes.spaceBtwItems,
                  ),

                  //? Settings Menu
                  // SettingsMenuTile(
                  //   icon: Iconsax.safe_home,
                  //   title: 'My Address',
                  //   subTitle: 'Set shopping delivery address',
                  //   onTap: () => Get.to(() => const UserAddressScreen()),
                  // ),
                  // SettingsMenuTile(
                  //     icon: Iconsax.shopping_cart,
                  //     title: 'My Cart',
                  //     subTitle: 'Add, remove products and move to checkout',
                  //     onTap: () => Get.to(() => const CartScreen())),
                  // SettingsMenuTile(
                  //     icon: Iconsax.bag_tick,
                  //     title: 'My Orders',
                  //     subTitle: 'In-progress and Completed Orders',
                  //     onTap: () => Get.to(() => const OrderScreen())),
                  SettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.category,
                    title: 'My Categories',
                    subTitle: 'List of all the Categories',
                    onTap: () => Get.to(() => const CategoryScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected account',
                    onTap: () {},
                  ),

                  //? App Settings
                  const SizedBox(
                    height: WSizes.spaceBtwSections,
                  ),
                  const SectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: WSizes.spaceBtwItems,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Upload Data',
                    subTitle: 'Upload data to your cloud firebase',
                    onTap: () => catController.uploadPrebuiltCategories(),
                  ),

                  //? Logout Button
                  const SizedBox(
                    height: WSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: WSizes.spaceBtwSections * 2.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
