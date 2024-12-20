import 'package:flutter/cupertino.dart';

import '../chip.dart';

class CompletedDailyChipsRow extends StatelessWidget {
  const CompletedDailyChipsRow({
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
          text: 'Work',
          onTap: () {
            onTap(0);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        CustomChip(
          isChecked: selectedIndex == 1 ? true : false,
          text: 'Meetings',
          onTap: () {
            onTap(1);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        CustomChip(
          isChecked: selectedIndex == 2 ? true : false,
          text: 'Home',
          onTap: () {
            onTap(2);
          },
        ),
      ],
    );
  }
}
