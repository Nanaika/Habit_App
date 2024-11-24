import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit_bloc.dart';
import 'package:habit_app/components/body_medium.dart';
import 'package:habit_app/components/chip.dart';
import 'package:habit_app/components/close_circle_button.dart';
import 'package:habit_app/components/tab_bar_habit_type.dart';
import 'package:habit_app/utils/string_extensions.dart';
import 'package:habit_app/utils/utils.dart';

import '../domain/models/habit.dart';
import '../theme.dart';
import '../utils/const.dart';
import 'custom_text_field.dart';

class EditHabitDialog extends StatefulWidget {
  const EditHabitDialog({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  State<EditHabitDialog> createState() => _EditHabitDialogState();
}

class _EditHabitDialogState extends State<EditHabitDialog> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final numOfRepsController = TextEditingController();
  late final TabController tabController;
  late int categoryIndex;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.habit.name;
    numOfRepsController.text = widget.habit.numOfRepetition.toString();
    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(findTypeIndex(widget.habit.type));
    categoryIndex = findCategoryIndex(widget.habit.category);
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
                    'Edit Habit',
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
              selectedChip: categoryIndex,
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
                        updateHabit(context, widget.habit.id);
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

  void updateHabit(BuildContext context, int id) {
    final habit = Habit(
        name: nameController.text,
        type: HabitType.values[tabController.index],
        numOfRepetition: numOfRepsController.text != '' ? int.parse(numOfRepsController.text) : 0,
        category: HabitCategory.values[categoryIndex],
        dateCreated: DateTime.now());
    context.read<HabitBloc>().updateHabit(id, habit);
  }
}

class HabitCategoryChips extends StatefulWidget {
  const HabitCategoryChips({
    super.key,
    required this.onChanged,
    this.selectedChip = 0,
  });

  final int selectedChip;
  final void Function(int index) onChanged;

  @override
  State<HabitCategoryChips> createState() => _HabitCategoryChipsState();
}

class _HabitCategoryChipsState extends State<HabitCategoryChips> {
  bool check = true;
  int selectedChip = 0;

  @override
  void initState() {
    super.initState();
    selectedChip = widget.selectedChip;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 6,
        runSpacing: 6,
        children: List.generate(HabitCategory.values.length, (index) {
          return CustomChip(
            text: HabitCategory.values[index].name.capitalizeFirst(),
            isChecked: selectedChip == index ? check : false,
            assetPath: categoryImagePath[index],
            isCheckedColor: getColor(context).primary,
            onTap: () {
              selectedChip = index;
              widget.onChanged(index);
              setState(() {});
            },
          );
        }),
      ),
    );
  }
}
