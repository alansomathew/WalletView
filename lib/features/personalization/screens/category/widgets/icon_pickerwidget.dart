import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/features/personalization/controllers/category/icon_picker_controller.dart';

class IconPickerWidget extends StatelessWidget {
  IconPickerWidget({
    super.key,
    required this.defaultIcon,
  });

  final IconData defaultIcon;
  final  controller = Get.put(IconPickerController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            controller.filterIcons(value);
          },
        ),
        Expanded(
          child: Obx(() {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 70,
              ),
              shrinkWrap: true,
              itemCount: controller.iconKeys.length,
              itemBuilder: (_, index) {
                final String key = controller.iconKeys[index];
                final bool isSelected = controller.selectedIcon.value == MdiIcons.fromString(key);
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: isSelected
                      ? BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(32),
                        )
                      : null,
                  child: IconButton(
                    key: ValueKey(key.hashCode),
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    onPressed: () {
                      controller.updateSelectedIcon(MdiIcons.fromString(key) ?? defaultIcon);
                    },
                    icon: Icon(MdiIcons.fromString(key)),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
