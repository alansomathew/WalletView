import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/common/widget/image/circular_image.dart';
import 'package:wallet_view/common/widget/shimmers/shimmer_effect.dart';
import 'package:wallet_view/common/widget/texts/section_heading.dart';
import 'package:wallet_view/features/personalization/screens/profile/widgets/change_name.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


import 'package:wallet_view/features/personalization/controllers/user_controller.dart';
import 'package:wallet_view/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:wallet_view/utils/constants/image_strings.dart';
import 'package:wallet_view/utils/constants/size.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WSizes.defaultSpace),
          child: Column(
            children: [
              //? Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : WImages.user;

                      return controller.imageUploading.value
                          ? const ShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : CircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              //? Details
              const SizedBox(height: WSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: WSizes.spaceBtwItems),
              const SectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: WSizes.spaceBtwItems),

              ProfileMenu(
                onTap: () => Get.to(() => const ChangeName()),
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Email',
                value: controller.user.value.email,
              ),
              const SizedBox(height: WSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: WSizes.spaceBtwItems),

              //? Heading personel info
              const SectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: WSizes.spaceBtwItems),

              ProfileMenu(
                onTap: () {},
                title: 'UserID',
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Upi ID',
                value: controller.user.value.upiId,
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Gender',
                value: 'male',
              ),
              ProfileMenu(
                onTap: () {},
                title: 'Date of Birth',
                value: '24 Nov 2000',
              ),
              const Divider(),
              const SizedBox(height: WSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
