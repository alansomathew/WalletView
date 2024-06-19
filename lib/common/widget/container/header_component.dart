import 'package:flutter/material.dart';

import 'package:wallet_view/common/widget/container/circular_container.dart';
import 'package:wallet_view/common/widget/curved_edges/curved_edges_widget.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class PrimaryHeaderComponent extends StatelessWidget {
  const PrimaryHeaderComponent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: WColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                  backgroundColor: WColors.white.withOpacity(0.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(
                  backgroundColor: WColors.white.withOpacity(0.1)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
