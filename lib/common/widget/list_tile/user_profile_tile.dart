import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:walletview/common/widget/image/circular_image.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/image_strings.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(UserController());
    return ListTile(
      leading: const CircularImage(
          image: WImages.user, width: 50, height: 50, padding: 0),
      title: Text(
        'controller.user.value.fullName',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: WColors.white),
      ),
      subtitle: Text(
        'controller.user.value.email',
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: WColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: WColors.white,
          )),
    );
  }
}