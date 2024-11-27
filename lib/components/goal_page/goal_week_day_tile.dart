import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../utils/const.dart';

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
              color: !isCompleted
                  ? isCurrentDate
                      ? red
                      : Colors.transparent
                  : Colors.transparent,
              width: !isCompleted
                  ? isCurrentDate
                      ? 0.5
                      : 0
                  : 0,
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
