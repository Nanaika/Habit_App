import 'package:flutter/material.dart';

import '../theme.dart';

class TabBarTaskType extends StatelessWidget {
  const TabBarTaskType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: 34,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: getColor(context).onSurface,
          borderRadius: BorderRadius.circular(defBorderRadius - 14),
        ),
        child: TabBar(
          tabs: const [
            Tab(
              child: Text('Work'),
            ),
            Tab(
              child: Text('Meetings'),
            ),
            Tab(
              child: Text('Home'),
            ),
          ],
          labelStyle: getTextTheme(context).labelLarge,
          labelColor: getColor(context).surfaceTint,
          unselectedLabelColor: getColor(context).onPrimary,
          splashFactory: NoSplash.splashFactory,
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: getColor(context).primary,
            borderRadius: BorderRadius.circular(defBorderRadius - 14),
          ),
        ),
      ),
    );
  }
}