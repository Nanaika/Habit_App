import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/bottom_bar_index_bloc.dart';
import 'package:habit_app/components/custom_bottom_bar.dart';
import 'package:habit_app/pages/habit_page_view.dart';
import 'package:habit_app/pages/health_page_view.dart';
import 'package:habit_app/pages/main_page_view.dart';
import 'package:habit_app/pages/settings_page_view.dart';

final pages = [const MainPageView(), const HealthPageView(), const HabitPageView(), const SettingsPageView()];

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SafeArea(
        bottom: true,
        child: CustomBottomBar(),
      ),
      body: BlocBuilder<BottomBarIndexBloc, int>(
        builder: (context, index) { return IndexedStack(
          index: index,
          children: pages,
        ); },
      ),
    );
  }
}
