import 'package:flutter/material.dart';

import 'package:wallet_view/features/expense/screens/widgets/piechart_graph.dart';
import 'package:wallet_view/utils/constants/size.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

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
