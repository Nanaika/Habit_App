import 'package:flutter/cupertino.dart';

import '../chip.dart';

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
        CustomChip(
          isChecked: selectedIndex == 0 ? true : false,
          text: 'Daily',
          onTap: () {
            onTap(0);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        CustomChip(
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
