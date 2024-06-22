import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:wallet_view/common/widget/appbar/appbar.dart';
import 'package:wallet_view/features/personalization/controllers/update_name_controller.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/validators/validtion.dart';

class ChangeUpiId extends StatelessWidget {
  const ChangeUpiId({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Change UPI ID',
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
              'Update your UPI ID for transactions.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: WSizes.spaceBtwSections),

            // Form
            Form(
              key: controller.updateUpiIdFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.upiId,
                    validator: (value) =>
                        WValidator.validateEmptyText('UPI ID', value),
                    decoration: const InputDecoration(
                      labelText: 'UPI ID',
                      prefixIcon: Icon(Iconsax.wallet),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: WSizes.spaceBtwSections),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUpiId(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
