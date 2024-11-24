import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';
import 'body_medium.dart';
import 'completed_task_container.dart';
import 'goal_view.dart';

class ExpandedHabitView extends StatelessWidget {
  const ExpandedHabitView({
    super.key,
    this.onTap,
    required this.assetPath,
    required this.habitType,
    required this.habitName,
    required this.habitCategory,
    required this.numOfReps,
    required this.currentNumOfReps,
    required this.completedValue,
  });

  final void Function()? onTap;
  final String assetPath;
  final String habitCategory;
  final String habitName;
  final String habitType;
  final String numOfReps;
  final String currentNumOfReps;
  final double completedValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                            child: SvgPicture.asset(
                              assetPath,
                              colorFilter: const ColorFilter.mode(violet, BlendMode.srcIn),
                            ),
                          ),
                          LabelLarge(text: habitCategory),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BodyMedium(text: habitName),
                          LabelLarge(text: habitType),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CompleteProgressBar(
                      minHeight: 4,
                      completedValue: completedValue,
                      color: violet,
                      borderRadius: 0,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelLarge(text: currentNumOfReps),
                        LabelLarge(text: numOfReps),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
