import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<IconData> paisaIconPicker({
  required BuildContext context,
  IconData defaultIcon = Icons.home_rounded,
}) async {
  IconData selectedIcon = defaultIcon;
  List<String> iconKeys = iconMap.keys.toList();

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      icon: Icon(defaultIcon),
      title: Text(
        'context.loc.selectIconTitle',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        child: _IconPickerWidget(
          iconKeys: iconKeys,
          selectedIcon: selectedIcon,
          onSelectedIcon: (icon) {
            selectedIcon = icon;
          },
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: () {
            Navigator.of(context).pop(defaultIcon);
          },
          child: Text(
           ' context.loc.cancel',
            style: TextStyle(color: Theme.of(context).indicatorColor),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: () {
            Navigator.of(context).pop(selectedIcon);
          },
          child: Text(
            'context.loc.done',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        )
      ],
    ),
  );
  return selectedIcon;
}


class _IconPickerWidget extends StatefulWidget {
  const _IconPickerWidget({
    required this.iconKeys,
    required this.selectedIcon,
    required this.onSelectedIcon,
  });

  final List<String> iconKeys;
  final Function(IconData icon) onSelectedIcon;
  final IconData? selectedIcon;

  @override
  State<_IconPickerWidget> createState() => _IconPickerWidgetState();
}

class _IconPickerWidgetState extends State<_IconPickerWidget> {
  final controller = TextEditingController();
  late List<String> iconKeys = widget.iconKeys;
  late IconData? selectedIcon = widget.selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            iconKeys = widget.iconKeys
                .where((element) => element
                    .toLowerCase()
                    .contains(value.toLowerCase().replaceAll(' ', '')))
                .toList();
            setState(() {});
          },
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 70,
            ),
            shrinkWrap: true,
            itemCount: iconKeys.length,
            itemBuilder: (_, index) {
              final bool isSelected =
                  selectedIcon == MdiIcons.fromString(iconKeys[index]);
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
                  key: ValueKey(iconKeys[index].hashCode),
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  onPressed: () {
                    setState(() {
                      selectedIcon = MdiIcons.fromString(iconKeys[index]);
                      widget.onSelectedIcon.call(selectedIcon ?? Icons.home);
                    });
                  },
                  icon: Icon(MdiIcons.fromString(iconKeys[index])),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}