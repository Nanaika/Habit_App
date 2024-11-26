import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_app/bloc/goal_bloc.dart';
import 'package:habit_app/theme.dart';
import 'package:habit_app/utils/string_extensions.dart';
import 'package:habit_app/utils/utils.dart';

import '../domain/models/goal.dart';

const List<String> goalTypeIcons = [
  'assets/images/fitness.svg',
  'assets/images/water.svg',
  'assets/images/nutrition.svg'
];

const List<String> weekLiterals = [
  'M',
  'T',
  'W',
  'T',
  'F',
  'S',
  'S',
];

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
                  print(completeIndices.toString());
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

class GoalExecuteButton extends StatelessWidget {
  const GoalExecuteButton({
    super.key,
    this.onTap,
    required this.text,
    this.color = red,
    required this.isActive,
  });

  final bool isActive;
  final void Function()? onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(defBorderRadius - 12),
            color: isActive ? color : getColor(context).surface,
            child: InkWell(
              borderRadius: BorderRadius.circular(defBorderRadius - 12),
              onTap: isActive ? onTap : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
                child: Text(
                  textAlign: TextAlign.center,
                  isActive ? text : 'Today\'s goal is accomplished',
                  style: getTextTheme(context)
                      .bodyLarge
                      ?.copyWith(color: isActive ? getColor(context).surfaceTint : getColor(context).onPrimary),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//TODO
class GoalWeekDayTile extends StatelessWidget {
  const GoalWeekDayTile({
    super.key,
    this.isCompleted = false,
    required this.text,
    this.isCurrentDate = false,
  });

  final bool isCompleted;
  final bool isCurrentDate;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Material(
        color: isCompleted ? red : getColor(context).onSurface,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              strokeAlign: 1,
              color: !isCompleted ? isCurrentDate ? red : Colors.transparent : Colors.transparent,
              width: !isCompleted ? isCurrentDate ? 0.5 : 0 : 0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: getTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: isCompleted ? getColor(context).surfaceTint : getColor(context).onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

//TODO
class CompletePercentUnitColumn extends StatelessWidget {
  const CompletePercentUnitColumn({
    super.key,
    required this.type,
    required this.completeDaysLength,
    this.duration,
    this.ml,
    this.calories,
  });

  final GoalType type;
  final int completeDaysLength;
  final CustomDuration? duration;
  final int? ml;
  final int? calories;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${completeDaysLength <= 10 ? completeDaysLength * 10 : 100}% complete',
          style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        switch (type) {
          GoalType.fitness => FitnessRow(
              duration: duration ?? CustomDuration(),
            ),
          GoalType.water => WaterRow(
              ml: ml ?? 0,
            ),
          GoalType.nutrition => NutritionRow(
              calories: calories ?? 0,
            ),
        },
      ],
    );
  }
}

class FitnessRow extends StatelessWidget {
  const FitnessRow({
    super.key,
    required this.duration,
  });

  final CustomDuration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        duration.hours != 0
            ? Expanded(child: Align(alignment: Alignment.centerRight,child: DisplayLarge(text: duration.hours.toString(), overflow: TextOverflow.ellipsis,)))
            : const SizedBox.shrink(),
        const SizedBox(
          width: 4,
        ),
        duration.hours != 0
            ? const LabelLarge(
                text: 'Hours',
              )
            : const SizedBox.shrink(),
        const SizedBox(
          width: 4,
        ),
        Expanded(child: Align(alignment: Alignment.centerRight,child: DisplayLarge(text: duration.minutes.toString(), overflow: TextOverflow.ellipsis,))),
        const SizedBox(
          width: 4,
        ),
        const LabelLarge(text: 'Mins'),
      ],
    );
  }
}

class WaterRow extends StatelessWidget {
  const WaterRow({
    super.key,
    required this.ml,
  });

  final int ml;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(child: Align(alignment: Alignment.centerRight,child: DisplayLarge(text: ml.toString(), overflow: TextOverflow.ellipsis,))),
        const SizedBox(
          width: 4,
        ),
        const LabelLarge(text: 'ml'),
      ],
    );
  }
}

class NutritionRow extends StatelessWidget {
  const NutritionRow({
    super.key,
    required this.calories,
  });

  final int calories;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(child: Align(alignment: Alignment.centerRight,child: DisplayLarge(text: calories.toString(), overflow: TextOverflow.ellipsis,))),
        const SizedBox(
          width: 4,
        ),
        const LabelLarge(text: 'cal'),
      ],
    );
  }
}

//TODO
class DisplayLarge extends StatelessWidget {
  const DisplayLarge({
    super.key,
    required this.text, this.overflow,
  });

  final String text;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).displayLarge?.copyWith(color: getColor(context).secondary, overflow: overflow),
    );
  }
}

//TODO
class LabelLarge extends StatelessWidget {
  const LabelLarge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context)
          .labelLarge
          ?.copyWith(color: getColor(context).onPrimary, overflow: TextOverflow.ellipsis),
    );
  }
}

//TODO
class TypeNameColumn extends StatelessWidget {
  const TypeNameColumn({
    super.key,
    required this.type,
    required this.name,
  });

  final GoalType type;
  final String name;

  @override
  Widget build(BuildContext context) {
    final iconPath = switch (type) {
      GoalType.fitness => goalTypeIcons[0],
      GoalType.water => goalTypeIcons[1],
      GoalType.nutrition => goalTypeIcons[2],
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: const ColorFilter.mode(red, BlendMode.srcIn),
        ),
        Text(
          type.name.capitalizeFirst(),
          style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
        ),

        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        )
      ],
    );
  }
}
