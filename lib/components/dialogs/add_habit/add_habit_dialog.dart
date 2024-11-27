import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit_bloc.dart';
import 'package:habit_app/components/body_medium.dart';
import 'package:habit_app/components/close_circle_button.dart';
import 'package:habit_app/components/dialogs/add_habit/habit_category_chips.dart';
import 'package:habit_app/components/habit_page/tab_bar_habit_type.dart';

import '../../../domain/models/habit.dart';
import '../../../theme.dart';
import '../../../utils/const.dart';
import '../../custom_text_field.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({
    super.key,
  });

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final numOfRepsController = TextEditingController();
  late final TabController tabController;
  int categoryIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    nameController.dispose();
    numOfRepsController.dispose();
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
                    'Add Habit',
                    style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).secondary),
                  ),
                ),
                CloseCircleButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              controller: nameController,
              hintText: 'Name habit',
            ),
            const SizedBox(
              height: 10,
            ),
            TabBarHabitType(
              controller: tabController,
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              children: [
                BodyMedium(text: 'Number of repetitions to perform'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: numOfRepsController,
              hintText: '0',
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              children: [
                BodyMedium(text: 'Category'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            HabitCategoryChips(
              onChanged: (index) {
                categoryIndex = index;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(defBorderRadius - 12),
                    color: getColor(context).primary,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(defBorderRadius - 12),
                      onTap: () {
                        saveHabit(context);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Save',
                          style: getTextTheme(context).bodyLarge?.copyWith(color: getColor(context).surfaceTint),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveHabit(BuildContext context) {
    final habit = Habit(
      name: nameController.text,
      type: HabitType.values[tabController.index],
      numOfRepetition: numOfRepsController.text != '' ? int.parse(numOfRepsController.text) : 0,
      category: HabitCategory.values[categoryIndex],
      dateCreated: DateTime.now(),
      daysComplete: [],
      weeksComplete: [],
    );
    context.read<HabitBloc>().saveHabit(habit);
  }
}
