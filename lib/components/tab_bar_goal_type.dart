import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class TabBarGoalType extends StatefulWidget {
  const TabBarGoalType({
    super.key,
  });

  @override
  State<TabBarGoalType> createState() => _TabBarGoalTypeState();
}

class _TabBarGoalTypeState extends State<TabBarGoalType> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: getColor(context).onSurface,
        borderRadius: BorderRadius.circular(defBorderRadius - 14),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/fitness.svg',
                  colorFilter: ColorFilter.mode(
                      _tabController.index == 0 ? getColor(context).surfaceTint : getColor(context).onPrimary,
                      BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Fitness',
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/water.svg',
                  colorFilter: ColorFilter.mode(
                      _tabController.index == 1 ? getColor(context).surfaceTint : getColor(context).onPrimary,
                      BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Water',
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/nutrition.svg',
                  colorFilter: ColorFilter.mode(
                      _tabController.index == 2 ? getColor(context).surfaceTint : getColor(context).onPrimary,
                      BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  'Nutrition',
                ),
              ],
            ),
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
    );
  }
}
