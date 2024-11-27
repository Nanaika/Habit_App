import 'package:flutter/material.dart';
import 'package:habit_app/components/goal_page/water_row.dart';

import '../../domain/models/goal.dart';
import '../../theme.dart';
import 'fitness_row.dart';
import 'nutrition_row.dart';

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
