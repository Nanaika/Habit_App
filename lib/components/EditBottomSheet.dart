import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/components/edit_habit_dialog.dart';
import 'package:habit_app/components/goal_view.dart';
import 'package:habit_app/components/sub_title.dart';
import 'package:habit_app/utils/string_extensions.dart';
import 'package:habit_app/utils/utils.dart';

import '../../theme.dart';
import '../bloc/habit_bloc.dart';
import '../domain/models/habit.dart';
import 'close_circle_button.dart';
import 'display_small.dart';
import 'expanded_habit_view.dart';

class EditBottomSheet extends StatelessWidget {
  const EditBottomSheet({
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
            currentNumOfReps: '5',
            completedValue: 0.5,
          ),
          const SizedBox(
            height: 16,
          ),
          const SubTitle(text: 'Statistic'),
          const SizedBox(
            height: 8,
          ),
          const Row(
            children: [
              Expanded(
                  child: StatisticBlock(
                title: 'Current streak',
                amount: '5',
                timeUnit: 'days',
              )),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: StatisticBlock(
                title: 'Best streak day',
                amount: '5',
                timeUnit: 'days',
              )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Row(
            children: [
              Expanded(
                  flex: 1,
                  child: StatisticBlock(
                    title: 'Completed habits',
                    amount: '5',
                    timeUnit: '/25',
                  )),
              SizedBox(
                width: 8,
              ),
              Expanded(flex: 1, child: SizedBox()),
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

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.textColor,
    required this.text,
    this.onTap,
  });

  final String text;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: getTextTheme(context).bodyLarge?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

class StatisticBlock extends StatelessWidget {
  const StatisticBlock({
    super.key,
    required this.title,
    required this.amount,
    required this.timeUnit,
  });

  final String title;
  final String amount;
  final String timeUnit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelLarge(text: title),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                DisplayLarge(text: amount),
                const SizedBox(
                  width: 8,
                ),
                LabelLarge(text: timeUnit),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
