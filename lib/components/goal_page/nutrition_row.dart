import 'package:flutter/material.dart';

import '../display_large.dart';
import '../label_large.dart';

class NutritionRow extends StatelessWidget {
  const NutritionRow({
    super.key,
    required this.calories,
  });

  final int calories;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: DisplayLarge(
                  text: calories.toString(),
                  overflow: TextOverflow.ellipsis,
                ))),
        const SizedBox(
          width: 4,
        ),
        const LabelLarge(text: 'cal'),
      ],
    );
  }
}
