import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/bottom_bar_index_bloc.dart';

import 'bottom_bar_button.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BottomBarButton(
          imagePath: 'assets/images/bb_home.svg',
          index: 0,
          onTap: () {
            context.read<BottomBarIndexBloc>().changePage(0);
          },
        ),
        BottomBarButton(
          imagePath: 'assets/images/bb_health.svg',
          index: 1,
          onTap: () {
            context.read<BottomBarIndexBloc>().changePage(1);
          },
        ),
        BottomBarButton(
          imagePath: 'assets/images/bb_run.svg',
          index: 2,
          onTap: () {
            context.read<BottomBarIndexBloc>().changePage(2);
          },
        ),
        BottomBarButton(
          imagePath: 'assets/images/bb_settings.svg',
          index: 3,
          onTap: () {
            context.read<BottomBarIndexBloc>().changePage(3);
          },
        ),
      ],
    );
  }
}
