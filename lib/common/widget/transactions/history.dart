import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/helpers/helper_functions.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          //     boxShadow:  <BoxShadow> [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     blurRadius: 5.0,
          //     spreadRadius: 2.0,
          //     offset: Offset(5.0, 0),
          //   ),
          // ],
          color: dark ? WColors.dark : WColors.light,
          // border: Border(
          //   bottom: BorderSide(),
          // ),
        ),
        child: ListTile(
          leading: ClayContainer(
            color: dark ? WColors.dark : WColors.light,
            width: 40,
            height: 40,
            borderRadius: 8,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      WColors.borderPrimary,
                      WColors.borderSecondary,
                      WColors.dark,
                      WColors.darkerGrey,
                      WColors.lightContainer,
                      Color(0xFFB6BAA6),
                    ]).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: const Icon(
                Icons.history,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ),
          title: Text(
            'transaction.title',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            'Subtitle',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            '- \u{20B9}${209}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: WColors.success),
          ),
        ),
      ),
    );
  }
}
