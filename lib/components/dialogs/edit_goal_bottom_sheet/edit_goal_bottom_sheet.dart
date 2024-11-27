import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/bloc/goal_bloc.dart';
import 'package:habit_app/components/dialogs/edit_button.dart';
import 'package:habit_app/components/dialogs/edit_goal_bottom_sheet/statistic_block.dart';
import 'package:habit_app/components/dialogs/edit_goal_bottom_sheet/statistic_duration_block.dart';
import 'package:habit_app/components/dialogs/edit_goal_dialog.dart';
import 'package:habit_app/components/sub_title.dart';
import 'package:habit_app/utils/utils.dart';

import '../../../../theme.dart';
import '../../../domain/models/goal.dart';
import '../../../utils/const.dart';
import '../../close_circle_button.dart';
import '../../display_small.dart';
import 'edit_main_block.dart';

class EditGoalBottomSheet extends StatelessWidget {
  const EditGoalBottomSheet({
    super.key,
    required this.goal,
  });

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final completeIndices = getIndicesOfCurrentWeekDates(goal.daysCompleted);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8,
          ),
          SvgPicture.asset('assets/images/line.svg'),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DisplaySmall(text: 'Edit'),
              CloseCircleButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          EditMainBlock(goal: goal, completeIndices: completeIndices),
          const SizedBox(
            height: 16,
          ),
          switch (goal.type) {
            GoalType.fitness => StatisticDurationBlock(
                title: 'Goal',
                duration: goal.duration ?? CustomDuration(),
                isCentre: true,
              ),
            GoalType.water => StatisticBlock(
                title: 'Goal',
                amount: goal.ml.toString(),
                timeUnit: 'ml',
                isCentre: true,
              ),
            GoalType.nutrition => StatisticBlock(
                title: 'Goal',
                amount: goal.calories.toString(),
                timeUnit: 'cal',
                isCentre: true,
              ),
          },
          const SizedBox(
            height: 16,
          ),
          const SubTitle(text: 'Statistic'),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: StatisticBlock(
                title: 'Complete',
                amount: '${goal.daysCompleted.length <= 10 ? goal.daysCompleted.length * 10 : 100}',
                timeUnit: '%',
              )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: StatisticBlock(
                title: 'Completed this week',
                amount: '${countDaysInCurrentWeek(goal.daysCompleted)}',
                timeUnit: ' of 7',
              )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 16,
          ),
          SafeArea(
            bottom: true,
            child: Row(
              children: [
                Expanded(
                  child: EditButton(
                    text: 'Edit goal',
                    textColor: getColor(context).secondary,
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return EditGoalDialog(goal: goal);
                          });
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: EditButton(
                    text: 'Delete goal',
                    textColor: red,
                    onTap: () {
                      context.read<GoalBloc>().deleteGoal(goal.id);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
