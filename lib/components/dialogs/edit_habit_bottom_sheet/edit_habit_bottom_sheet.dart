import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/components/dialogs/edit_habit_bottom_sheet/statistic_block.dart';
import 'package:habit_app/components/dialogs/edit_habit/edit_habit_dialog.dart';
import 'package:habit_app/components/sub_title.dart';
import 'package:habit_app/utils/string_extensions.dart';
import 'package:habit_app/utils/utils.dart';

import '../../../../theme.dart';
import '../../../bloc/habit_bloc.dart';
import '../../../domain/models/habit.dart';
import '../../../utils/const.dart';
import '../../close_circle_button.dart';
import '../../display_small.dart';
import '../../habit_page/expanded_habit_view.dart';
import '../edit_button.dart';

class EditHabitBottomSheet extends StatelessWidget {
  const EditHabitBottomSheet({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  Widget build(BuildContext context) {
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
            height: 16,
          ),
          ExpandedHabitView(
            assetPath: getCategoryAsset(habit.category),
            habitType: habit.type.name.capitalizeFirst(),
            habitName: habit.name,
            habitCategory: habit.category.name.capitalizeFirst(),
            numOfReps: habit.numOfRepetition.toString(),
            currentNumOfReps: habit.type == HabitType.daily
                ? habit.daysComplete.length.toString()
                : habit.weeksComplete.length.toString(),
            completedValue: habit.type == HabitType.daily
                ? calculatePercentage(habit.daysComplete.length, habit.numOfRepetition)
                : calculatePercentage(habit.weeksComplete.length, habit.numOfRepetition),
          ),
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
                title: 'Current streak',
                amount: habit.type == HabitType.daily
                    ? getCurrentStreak(habit.daysComplete).toString()
                    : getCurrentStreakWeek(habit.weeksComplete).toString(),
                timeUnit: 'days',
              )),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: StatisticBlock(
                title: 'Best streak day',
                amount: habit.type == HabitType.daily
                    ? getMaxStreak(habit.daysComplete).toString()
                    : getMaxStreakWeeks(habit.weeksComplete).toString(),
                timeUnit: 'days',
              )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: StatisticBlock(
                    title: 'Completed habits',
                    amount: habit.type == HabitType.daily
                        ? habit.daysComplete.length.toString()
                        : habit.weeksComplete.length.toString(),
                    timeUnit: '/${habit.numOfRepetition}',
                  )),
              const SizedBox(
                width: 8,
              ),
              const Expanded(flex: 1, child: SizedBox()),
            ],
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
                    text: 'Edit habit',
                    textColor: getColor(context).secondary,
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return EditHabitDialog(
                              habit: habit,
                            );
                          });
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: EditButton(
                    text: 'Delete habit',
                    textColor: red,
                    onTap: () {
                      context.read<HabitBloc>().deleteHabit(habit.id);
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


