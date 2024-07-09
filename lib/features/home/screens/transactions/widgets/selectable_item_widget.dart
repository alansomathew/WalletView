// Flutter imports:
import 'package:flutter/material.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

// Project imports:
// Assuming this is where your context extensions are located

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.selected,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.subtitle,
    required this.color,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;
  final String? subtitle;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    final shape = selected
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: color,
              width: 2,
            ),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          );

    return SizedBox(
      width: 150,
      child: Card(
        color:dark?WColors.darkContainer: WColors.accent,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        shadowColor: color,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundColor: color,
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                subtitle: subtitle != null
                    ? Text(
                        subtitle!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
