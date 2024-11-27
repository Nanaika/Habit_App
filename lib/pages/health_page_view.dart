import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/goal_bloc.dart';
import 'package:habit_app/components/dialogs/add_goal/add_goal_dialog.dart';
import 'package:habit_app/components/dialogs/edit_goal_bottom_sheet/edit_goal_bottom_sheet.dart';
import 'package:habit_app/domain/models/goal.dart';
import 'package:habit_app/theme.dart';

import '../components/goal_page/create_goal_button.dart';
import '../components/goal_page/goal_view.dart';
import '../components/image_row.dart';
import '../components/sub_title.dart';
import '../components/task_page/empty_task_view.dart';
import '../components/title_row.dart';
import '../utils/const.dart';

class HealthPageView extends StatefulWidget {
  const HealthPageView({super.key});

  @override
  State<HealthPageView> createState() => _HealthPageViewState();
}

class _HealthPageViewState extends State<HealthPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(context).surface,
      body: SafeArea(
        top: true,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defPaddingH),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleRow(
                      text: 'Health',
                    ),
                    AddButton(
                      text: 'Create goal',
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AddGoalDialog();
                            });
                      },
                    )
                  ],
                ),
                const ImageRow(
                  imagePath: 'assets/images/health.png',
                ),
                const SizedBox(
                  height: 12,
                ),
                const Row(
                  children: [
                    SubTitle(text: 'Goals'),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<GoalBloc, List<Goal>>(builder: (ctx, state) {
                  if (state.isEmpty) {
                    return const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EmptyView(
                            imagePath: 'assets/images/heart.svg',
                            text:
                                'You do not have any health goals added, to add a goal click on the “Create goal” button.',
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          return GoalView(
                            goal: state[index],
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: getColor(context).surface,
                                  context: context,
                                  builder: (ctx) {
                                    return EditGoalBottomSheet(goal: state[index]);
                                  });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: state.length,
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
