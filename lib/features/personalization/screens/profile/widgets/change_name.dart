
import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/features/personalization/controllers/update_name_controller.dart';
import 'package:wallet_view/utils/constants/size.dart';

import 'package:wallet_view/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallet_view/utils/validators/validtion.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(WSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'Use Real name for easy verification.This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: WSizes.spaceBtwSections),

            //? TextField and a button
            Form(
              key: controller.updateUserFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    expands: false,
                    validator: (value) =>
                        WValidator.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                      labelText: WTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: WSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    expands: false,
                    validator: (value) =>
                        WValidator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                      labelText: WTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: WSizes.spaceBtwSections),
            //? Button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>controller.updateName(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
