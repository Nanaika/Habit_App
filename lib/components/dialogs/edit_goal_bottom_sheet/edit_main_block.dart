import 'package:flutter/material.dart';

import '../../../domain/models/goal.dart';
import '../../../utils/const.dart';
import '../../../utils/utils.dart';
import '../../goal_page/goal_week_day_tile.dart';
import '../../goal_page/type_name_column.dart';

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
