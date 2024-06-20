import 'package:flutter/material.dart';

import 'package:wallet_view/common/widget/layout/grid_layout.dart';
import 'package:wallet_view/utils/constants/colors.dart';

class SpiltScreen extends StatelessWidget {
  const SpiltScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            // a list a cards
            GridLayout(
                
                itemCount: 10,
                mainAxisExtent: 120,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Item $index'),
                      subtitle: Text('Description of item $index'),
                    ),
                  );
                }),
            // the divider between two lists of cards
            const Divider(),
            // another list of cards
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: WColors.primary,
        child: const Icon(Icons.splitscreen),
      ),
    );
  }
}
