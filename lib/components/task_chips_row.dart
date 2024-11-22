import 'package:flutter/cupertino.dart';

import '../pages/main_page_view.dart';
import 'chip.dart';

class TasksChipsRow extends StatelessWidget {
  const TasksChipsRow({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final void Function(int index) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          isChecked: selectedIndex == 0 ? true : false,
          text: 'Daily',
          onTap: () {
            onTap(0);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        Chip(
          isChecked: selectedIndex == 1 ? true : false,
          text: 'Weekly',
          onTap: () {
            onTap(1);
          },
        ),
      ],
    );
  }
}