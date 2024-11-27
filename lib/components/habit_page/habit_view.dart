import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme.dart';
import '../../utils/const.dart';
import '../body_medium.dart';
import '../complete_progress_bar.dart';
import '../label_large.dart';

class HabitView extends StatelessWidget {
  const HabitView({
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyMedium(text: habitName),
                      LabelLarge(text: habitType),
                      const SizedBox(
                        height: 12,
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
            ),
          )),
    );
  }
}
