import 'package:flutter/material.dart';

class AccountSummaryTail extends StatelessWidget {
  const AccountSummaryTail({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String subtitle;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context)
              .colorScheme
              .onSecondaryContainer
              .withOpacity(0.75),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}