import 'package:flutter/material.dart';
import 'package:walletview/common/widget/container/header_component.dart';
import 'package:walletview/common/widget/container/search_container.dart';
import 'package:walletview/common/widget/texts/section_heading.dart';
import 'package:walletview/features/home/screens/widgets/home_appbar.dart';
import 'package:walletview/features/home/screens/widgets/home_overview.dart';
import 'package:walletview/utils/constants/colors.dart';
import 'package:walletview/utils/constants/size.dart';
import 'package:walletview/utils/constants/text_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* Header
            PrimaryHeaderComponent(
              child: Column(
                children: [
                  //* AppBar
                  HomeAppBar(),
                  SizedBox(
                    height: WSizes.spaceBtwSections,
                  ),

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
          ],
        ),
      ),
    );
  }
}
