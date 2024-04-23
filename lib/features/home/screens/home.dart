import 'package:flutter/material.dart';
import 'package:walletview/common/widget/appbar/appbar.dart';
import 'package:walletview/common/widget/appbar/drawer.dart';
import 'package:walletview/common/widget/container/circular_container.dart';
import 'package:walletview/common/widget/container/header_component.dart';
import 'package:walletview/common/widget/layout/list_layout.dart';
import 'package:walletview/common/widget/products/cart_menu_icon.dart';
import 'package:walletview/common/widget/texts/product_title_text.dart';
import 'package:walletview/common/widget/texts/section_heading.dart';
import 'package:walletview/common/widget/transactions/history.dart';
import 'package:walletview/features/home/screens/widgets/home_overview.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      drawer: WDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* Header
            const PrimaryHeaderComponent(
              child: Column(
                children: [
                  //* AppBar

                  //* Progress Bar
                  Padding(
                    padding: EdgeInsets.only(left: WSizes.defaultSpace),
                    child: Column(
                      children: [
                        //* Headings
                        SectionHeading(
                          title: WTexts.popularCategories,
                          showActionButton: false,
                          textColor: WColors.white,
                        ),
                        SizedBox(
                          height: WSizes.spaceBtwItems,
                        ),

                        // //* Categories
                        OverView(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: WSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(WSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* popular products
                  SectionHeading(
                    title: WTexts.recentSpents,
                    onPressed: () => {},
                  ),
                  const SizedBox(
                    height: WSizes.spaceBtwItems,
                  ),
                  const ProductTitleText(
                    title: 'date',
                    textAlign: TextAlign.left,
                  ),
                  ListLayout(
                    itemCount: 10,
                    itemBuilder: (_, index) => const TransactionHistory(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
        backgroundColor: WColors.primary,
      ),
    );
  }
}
