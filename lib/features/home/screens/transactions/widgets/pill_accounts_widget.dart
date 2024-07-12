import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallet_view/features/expense/controllers/account_controller.dart';
import 'package:wallet_view/features/expense/controllers/transaction_controller.dart';
import 'package:wallet_view/features/expense/models/account_model.dart';
import 'package:wallet_view/utils/paisa_widgets/paisa_card.dart';


class PillsAccountWidget extends StatelessWidget {
  const PillsAccountWidget({
    super.key,
    required this.accountSelected,
  });

  final Function(AccountModel) accountSelected;

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.put(TransactionController());
    final AccountController accountcontroller = Get.put(AccountController());


    return Obx(() {
      final List<AccountModel> accounts = accountcontroller.accounts;
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 16 / 5,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: accounts.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final AccountModel account = accounts[index];
          final bool isSelected = account.id == controller.selectedAccountId.value;
          return PaisaFilterChip(
            color: Color(Colors.amber.value),
            onPressed: () {
              if (isSelected) {
                controller.selectedaAccountId('-1');
              } else {
                controller.selectedaAccountId(account.id);
              }
              accountSelected(account);
            },
            isSelected: isSelected,
            icon: MdiIcons.bankOutline,
            title: account.name,
          );
        },
      );
    });
  }
}

class PaisaFilterChip extends StatelessWidget {
  const PaisaFilterChip({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PaisaFilledCard(
      color: color.withOpacity(0.09),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? color : color.withOpacity(0.09),
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(icon, color: color),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
