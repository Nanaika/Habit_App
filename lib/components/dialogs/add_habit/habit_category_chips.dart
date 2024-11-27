import 'package:flutter/material.dart';
import 'package:habit_app/utils/string_extensions.dart';

import '../../../domain/models/habit.dart';
import '../../../theme.dart';
import '../../../utils/const.dart';
import '../../chip.dart';

class HabitCategoryChips extends StatefulWidget {
  const HabitCategoryChips({
    super.key,
    required this.onChanged,
  });

  final void Function(int index) onChanged;

  @override
  State<HabitCategoryChips> createState() => _HabitCategoryChipsState();
}

class _HabitCategoryChipsState extends State<HabitCategoryChips> {
  bool check = true;
  int selectedChip = 0;

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
