import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/helpers/helper_functions.dart';

class TransactionHistory extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final String dateString;
  final String type;
  final int iconCodePoint;
  final String? fontFamily;
  final String? fontPackage;

  const TransactionHistory({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.dateString,
    required this.type,
    required this.iconCodePoint,
    this.fontFamily,
    this.fontPackage,
  });

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);

    DateTime dateTime = DateTime.tryParse(dateString) ?? DateTime.now();
    Color typeColor;
    switch (type) {
      case 'income':
        typeColor = WColors.success;
        break;
      case 'expense':
        typeColor = WColors.error;
        break;
      case 'transfer':
        typeColor = WColors.secondary; // Replace with a suitable color
        break;
      default:
        typeColor = Colors.grey;
    }

    String formattedDate = DateFormat('MMMM d, y hh:mm a').format(dateTime);

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10,bottom: 5),
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
              child: Icon(
                IconData(iconCodePoint,
                    fontFamily: fontFamily, fontPackage: fontPackage),
                color: typeColor,
                size: 30,
              ),
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            '$formattedDate\n$subtitle',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Text(
            '${amount < 0 ? '-' : '+'} \u{20B9}${amount.abs().toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: typeColor,
                ),
          ),
        ),
      ),
    );
  }
}
