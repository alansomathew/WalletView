// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:

class PaisaCard extends StatelessWidget {
  const PaisaCard({
    Key? key,
    required this.child,
    this.elevation,
    this.color,
    this.shape,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: color ?? Theme.of(context).cardColor,
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 2.0,
      shadowColor: color ?? Colors.transparent, // Use transparent for shadow color if no specific color is set
      child: child,
    );
  }
}

class PaisaOutlineCard extends StatelessWidget {
  const PaisaOutlineCard({
    Key? key,
    required this.child,
    this.shape,
  }) : super(key: key);

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Theme.of(context).cardColor,
      shadowColor: Colors.transparent, // Use transparent for shadow color
      child: child,
    );
  }
}


class PaisaFilledCard extends StatelessWidget {
  const PaisaFilledCard({
    Key? key,
    required this.child,
    this.shape,
    this.color,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: color ?? Theme.of(context).cardColor,
      shadowColor: Colors.transparent, // Use transparent for shadow color
      child: child,
    );
  }
}
