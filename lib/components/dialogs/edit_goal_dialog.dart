import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/components/dialogs/add_goal/hours_min_row.dart';
import 'package:habit_app/components/goal_page/tab_bar_goal_type.dart';

import '../../bloc/add_goal_type_index_bloc.dart';
import '../../bloc/goal_bloc.dart';
import '../../domain/models/goal.dart';
import '../../theme.dart';
import '../../utils/const.dart';
import '../close_circle_button.dart';
import '../custom_no_icon_button.dart';
import '../custom_text_field.dart';
import 'add_goal/goal_type_unit_name.dart';

class EditGoalDialog extends StatefulWidget {
  const EditGoalDialog({
    super.key,
    required this.goal,
  });

  final Goal goal;

  @override
  State<EditGoalDialog> createState() => _EditGoalDialogState();
}

class _EditGoalDialogState extends State<EditGoalDialog> {
  late final TextEditingController nameController;
  late final TextEditingController hourController;
  late final TextEditingController minController;
  late final TextEditingController mlController;
  late final TextEditingController caloriesController;
  late final AddGoalTypeIndexBloc typeIndexBloc;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    hourController = TextEditingController();
    minController = TextEditingController();
    mlController = TextEditingController();
    caloriesController = TextEditingController();

    typeIndexBloc = context.read<AddGoalTypeIndexBloc>();
    nameController.text = widget.goal.name;

    switch (widget.goal.type) {
      case GoalType.fitness:
        hourController.text = widget.goal.duration!.hours.toString();
        minController.text = widget.goal.duration!.minutes.toString();
      case GoalType.water:
        mlController.text = widget.goal.ml.toString();
      case GoalType.nutrition:
        caloriesController.text = widget.goal.calories.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    hourController.dispose();
    minController.dispose();
    mlController.dispose();
    caloriesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    typeIndexBloc.changeIndex(GoalType.values.indexOf(widget.goal.type));

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
                    'Edit goal',
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
              initIndex: GoalType.values.indexOf(widget.goal.type),
              onChanged: (index) {
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
                    final GoalType type = GoalType.values[typeIndexBloc.state];
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
                    context.read<GoalBloc>().updateGoal(widget.goal.id, goal);
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
