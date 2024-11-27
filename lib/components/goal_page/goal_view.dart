import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/goal_bloc.dart';
import 'package:habit_app/components/goal_page/type_name_column.dart';
import 'package:habit_app/theme.dart';
import 'package:habit_app/utils/utils.dart';

import '../../domain/models/goal.dart';
import '../../utils/const.dart';
import '../label_large.dart';
import 'complete_percent_unit_column.dart';
import 'goal_execute_button.dart';
import 'goal_week_day_tile.dart';



class GoalView extends StatelessWidget {
  const GoalView({super.key, required this.goal, this.onTap});

  final Goal goal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final completeIndices = getIndicesOfCurrentWeekDates(goal.daysCompleted);
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(defBorderRadius / 2),
        color: getColor(context).surfaceTint,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TypeNameColumn(
                      type: goal.type,
                      name: goal.name,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: CompletePercentUnitColumn(
                      duration: goal.duration,
                      ml: goal.ml,
                      calories: goal.calories,
                      type: goal.type,
                      completeDaysLength: goal.daysCompleted.length,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  return Expanded(
                    child: GoalWeekDayTile(
                      isCompleted: completeIndices.contains(index),
                      text: weekLiterals[index],
                      isCurrentDate: index == getIndexOfTodayInCurrentWeek(),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  LabelLarge(text: '${countDaysInCurrentWeek(goal.daysCompleted)} of 7 goals accomplished this week.')
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              GoalExecuteButton(
                isActive: !isCompletedToday(goal.daysCompleted),
                text: 'Execute',
                onTap: () {
                  context.read<GoalBloc>().updateGoalComplete(
                        goal.id,
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
