import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/bloc/goal_bloc.dart';
import 'package:habit_app/components/edit_goal_dialog.dart';
import 'package:habit_app/components/goal_view.dart';
import 'package:habit_app/components/sub_title.dart';
import 'package:habit_app/utils/utils.dart';

import '../../theme.dart';
import '../domain/models/goal.dart';
import 'close_circle_button.dart';
import 'display_small.dart';

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

class EditMainBlock extends StatelessWidget {
  const EditMainBlock({
    super.key,
    required this.goal,
    required this.completeIndices,
  });

  final Goal goal;
  final List<int> completeIndices;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
              ],
            ),
            const SizedBox(
              height: 18,
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
          ],
        ),
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
    this.isCentre = false,
  });

  final String title;
  final String amount;
  final String timeUnit;
  final bool isCentre;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: isCentre ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            LabelLarge(text: title),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: isCentre ? MainAxisAlignment.center : MainAxisAlignment.start,
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

class StatisticDurationBlock extends StatelessWidget {
  const StatisticDurationBlock({
    super.key,
    required this.title,
    this.isCentre = false,
    required this.duration,
  });

  final String title;
  final CustomDuration duration;
  final bool isCentre;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: isCentre ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            LabelLarge(text: title),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: isCentre ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                duration.hours != 0 ? DisplayLarge(text: duration.hours.toString()) : const SizedBox.shrink(),
                const SizedBox(
                  width: 8,
                ),
                duration.hours != 0 ? const LabelLarge(text: 'hours') : const SizedBox.shrink(),
                const SizedBox(
                  width: 12,
                ),
                DisplayLarge(text: duration.minutes.toString()),
                const SizedBox(
                  width: 8,
                ),
                const LabelLarge(text: 'mins'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
