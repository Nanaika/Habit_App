import 'package:flutter/material.dart';
import 'package:habit_app/components/add_goal_dialog.dart';
import 'package:habit_app/domain/models/goal.dart';
import 'package:habit_app/theme.dart';

import '../components/create_goal_button.dart';
import '../components/empty_task_view.dart';
import '../components/goal_view.dart';
import '../components/image_row.dart';
import '../components/sub_title.dart';
import '../components/title_row.dart';

class HealthPageView extends StatefulWidget {
  const HealthPageView({super.key});

  @override
  State<HealthPageView> createState() => _HealthPageViewState();
}

class _HealthPageViewState extends State<HealthPageView> {
  int selectedCompletedDaily = 0;
  int selectedTasks = 0;

  List<Goal> goals = [];

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
                    CreateGoalButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AddGoalDialog(
                                onTap: () {
                                  goals.add(Goal(
                                      type: GoalType.fitness,
                                      name: 'name',
                                      duration: const Duration(hours: 1),
                                      dateCreated: DateTime.now(),
                                      completed: 0,
                                      daysCompleted: []));
                                  setState(() {});
                                },
                              );
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
                const SubTitle(text: 'Goals'),
                const SizedBox(
                  height: 12,
                ),
                goals.isEmpty
                    ? const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyView(
                              imagePath: 'assets/images/bb_health.svg',
                              text:
                                  'You do not have any health goals added, to add a goal click on the “Create goal” button.',
                            ),
                          ],
                        ),
                      )
                    :
                Expanded(
                  child: ListView.separated(itemBuilder: (ctx, index) {
                    return GoalView();
                  }, separatorBuilder: (ctx, index) {
                    return SizedBox(height: 10,);
                  }, itemCount: goals.length),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
