import 'package:flutter/material.dart';

import 'package:wallet_view/common/widget/container/header_component.dart';
import 'package:wallet_view/common/widget/texts/product_title_text.dart';
import 'package:wallet_view/common/widget/texts/section_heading.dart';
import 'package:wallet_view/features/home/screens/widgets/home_appbar.dart';
import 'package:wallet_view/features/home/screens/widgets/home_overview.dart';
import 'package:wallet_view/utils/constants/colors.dart';
import 'package:wallet_view/utils/constants/size.dart';
import 'package:wallet_view/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* Header
            const PrimaryHeaderComponent(
              child: Column(
                children: [
                  //* AppBar
                  HomeAppBar(),
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
                  // ListLayout(
                  //   itemCount: 10,
                  //   itemBuilder: (_, index) => const TransactionHistory(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: WColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
