import 'package:flutter/material.dart';
import 'package:walletview/common/widget/appbar/appbar.dart';
import 'package:walletview/common/widget/appbar/drawer.dart';
import 'package:walletview/features/expense/screens/widgets/piechart_graph.dart';
import 'package:walletview/utils/constants/size.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(),
      drawer: WDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity, // Example width
              height: 400, // Example height
              child: PieChartGraph(),
            ),
            SizedBox(
              height: WSizes.defaultSpace/2,
            ),
            SizedBox(
              width: double.infinity, // Example width
              height: 400, // Example height
              child: PieChartGraph(),
            ),

          ],
        ),
      ),
    );
  }
}
