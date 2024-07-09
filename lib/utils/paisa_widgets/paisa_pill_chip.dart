import 'package:flutter/material.dart';

class PaisaPillChip extends StatelessWidget {
  const PaisaPillChip({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColorDark;
    final textColor = isSelected
        ? Theme.of(context).primaryColorDark
        : Theme.of(context).primaryColorLight;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: bgColor,
          border: Border.all(
            width: 1.5,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.white.withOpacity(0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    Key? key,
    required this.selected,
    required this.onSelected,
    required this.icon,
    required this.title,
    required this.color,
    this.fontFamily,
    this.fontPackage,
  }) : super(key: key);

  final int icon;
  final String? fontFamily;
  final String? fontPackage;
  final Function(bool) onSelected;
  final bool selected;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: onSelected,
      selectedColor: selected ? color.withOpacity(0.8) : null,
      avatar: Icon(
        IconData(icon, fontFamily: fontFamily ?? 'MaterialDesignIcons', fontPackage: fontPackage ?? 'material_design_icons_flutter'),
        color: color,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      showCheckmark: false,
      label: Text(title),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
    );
  }
}
