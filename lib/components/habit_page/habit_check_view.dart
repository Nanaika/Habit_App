import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/utils/utils.dart';

import '../../bloc/habit_bloc.dart';
import '../../domain/models/habit.dart';
import '../../theme.dart';
import '../../utils/const.dart';
import '../body_medium.dart';
import '../label_large.dart';
import 'habit_check_view_button.dart';

class HabitCheckView extends StatefulWidget {
  const HabitCheckView({
    super.key,
    required this.assetPath,
    required this.name,
    required this.type,
    this.isComplete = false,
    required this.id,
    required this.habit,
  });

  final int id;
  final String assetPath;
  final String name;
  final String type;
  final bool isComplete;
  final Habit habit;

  @override
  State<HabitCheckView> createState() => _HabitCheckViewState();
}

class _HabitCheckViewState extends State<HabitCheckView> {
  late bool isComplete;

  @override
  void initState() {
    super.initState();
    isComplete = widget.isComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            isComplete = !isComplete;
          });
          context.read<HabitBloc>().updateHabitComplete(widget.id, isComplete);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      widget.assetPath,
                      colorFilter: const ColorFilter.mode(violet, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyMedium(text: widget.name),
                          LabelLarge(text: widget.type),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              HabitCheckViewButton(
                isComplete: checkComplete(widget.habit.type, widget.habit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool checkComplete(HabitType type, Habit habit) {
  return switch (type) {
    HabitType.daily => isCompletedToday(habit.daysComplete),
    HabitType.weekly => isCompletedThisWeek(habit.weeksComplete),
  };
}
