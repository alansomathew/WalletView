import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.description,
    this.onActionPressed,
    this.actionTitle,
  }) : super(key: key);

  final String? actionTitle;
  final String description;
  final IconData icon;
  final VoidCallback? onActionPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 96,
              color: Theme.of(context).primaryColor, // Use theme primary color
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall, // Adjust text style
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                description,
                style: Theme.of(context).textTheme.labelSmall, // Adjust text style
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            if (onActionPressed != null)
              ElevatedButton(
                onPressed: onActionPressed!,
                child: Text(actionTitle ?? ''),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
