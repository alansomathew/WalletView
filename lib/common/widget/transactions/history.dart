import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

class TransactionHistory extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount; // Assuming amount is in rupees

  const TransactionHistory({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: dark ? WColors.dark : WColors.light,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: const Offset(5.0, 0),
            ),
          ],
          color: dark ? WColors.dark : WColors.light,
          border: const Border(
            bottom: BorderSide(),
          ),
        ),
        child: ListTile(
          leading: ClayContainer(
            color: dark ? WColors.dark : WColors.light,
            width: 30,
            height: 30,
            borderRadius: 8,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    WColors.shade1,
                    WColors.shade2,
                    WColors.shade3,
                    WColors.shade4,
                    WColors.shade5,
                    WColors.shade6,
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(
                Icons.food_bank,
                color: WColors.accent,
                size: 30,
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            '- \u{20B9}${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: amount < 0 ? WColors.error : WColors.success,
                ),
          ),
        ),
      ),
    );
  }
}
