import 'package:flutter/material.dart';
import 'package:habit_app/components/custom_bottom_bar.dart';
import 'package:habit_app/pages/main_page_view.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: CustomBottomBar(),
        bottom: true,
      ),
      body: IndexedStack(
        index: 0,
        children: [
          MainPageView(),
          MainPageView(),
          MainPageView(),
        ],
      ),
    );
  }
}
