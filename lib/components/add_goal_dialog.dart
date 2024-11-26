import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/add_goal_type_index_bloc.dart';
import 'package:habit_app/bloc/goal_bloc.dart';
import 'package:habit_app/components/tab_bar_goal_type.dart';

import '../domain/models/goal.dart';
import '../theme.dart';
import 'close_circle_button.dart';
import 'custom_no_icon_button.dart';
import 'custom_text_field.dart';

class AddGoalDialog extends StatefulWidget {
  const AddGoalDialog({
    super.key,
  });

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  int typeIndex = 0;
  late final TextEditingController nameController;
  late final TextEditingController hourController;
  late final TextEditingController minController;
  late final TextEditingController mlController;
  late final TextEditingController caloriesController;
  late final AddGoalTypeIndexBloc bloc;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    hourController = TextEditingController();
    minController = TextEditingController();
    mlController = TextEditingController();
    caloriesController = TextEditingController();
    bloc = context.read<AddGoalTypeIndexBloc>();
  }

  @override
  void dispose() {
    bloc.changeIndex(0);
    super.dispose();
    nameController.dispose();
    hourController.dispose();
    minController.dispose();
    mlController.dispose();
    caloriesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(defPaddingH),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Create goal',
                    style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).secondary),
                  ),
                ),
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
            TabBarGoalType(
              onChanged: (index) {
                typeIndex = index;
                context.read<AddGoalTypeIndexBloc>().changeIndex(index);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: nameController,
              hintText: 'Name goal',
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                const Row(
                  children: [
                    GoalTypeUnitName(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<AddGoalTypeIndexBloc, int>(
                  builder: (context, state) {
                    if (state == 0) {
                      return HoursMinRow(
                        hourController: hourController,
                        minController: minController,
                      );
                    } else if (state == 1) {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: '0',
                              controller: mlController,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: '0',
                              controller: caloriesController,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomNoIconButton(
                  onTap: () {
                    final GoalType type = GoalType.values[typeIndex];
                    Goal goal;
                    switch (type) {
                      case GoalType.fitness:
                        goal = Goal(
                            type: type,
                            name: nameController.text,
                            duration: CustomDuration(
                              hours: int.parse(hourController.text == '' ? '0' : hourController.text),
                              minutes: int.parse(minController.text == '' ? '0' : minController.text),
                            ),
                            dateCreated: DateTime.now(),
                            completedTimes: 0,
                            daysCompleted: []);
                      case GoalType.water:
                        goal = Goal(
                          ml: int.parse(mlController.text == '' ? '0' : mlController.text),
                          type: type,
                          name: nameController.text,
                          dateCreated: DateTime.now(),
                          completedTimes: 0,
                          daysCompleted: [],
                        );
                      case GoalType.nutrition:
                        goal = Goal(
                          calories: int.parse(caloriesController.text == '' ? '0' : caloriesController.text),
                          type: type,
                          name: nameController.text,
                          dateCreated: DateTime.now(),
                          completedTimes: 0,
                          daysCompleted: [],
                        );
                    }
                    context.read<GoalBloc>().saveGoal(goal);
                    Navigator.of(context).pop();
                  },
                  text: 'Save',
                  color: getColor(context).primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//TODO
//components
class GoalTypeUnitName extends StatelessWidget {
  const GoalTypeUnitName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGoalTypeIndexBloc, int>(
      builder: (BuildContext context, int state) {
        final text = switch (state) {
          0 => 'Duration',
          1 => 'Drink (ml)',
          2 => 'Calories',
          int() => '',
        };
        return Text(
          text,
          style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        );
      },
    );
  }
}

class HoursMinRow extends StatelessWidget {
  const HoursMinRow({
    super.key,
    required this.hourController,
    required this.minController,
  });

  final TextEditingController hourController;
  final TextEditingController minController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: hourController,
            hintText: 'Hours',
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomTextField(
            controller: minController,
            hintText: 'Mins',
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
