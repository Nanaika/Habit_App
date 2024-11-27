import 'package:flutter/material.dart';

import '../../../theme.dart';
import '../../display_large.dart';
import '../../label_large.dart';

class StatisticBlock extends StatelessWidget {
  const StatisticBlock({
    super.key,
    required this.title,
    required this.amount,
    required this.timeUnit,
  });

  final String title;
  final String amount;
  final String timeUnit;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelLarge(text: title),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                DisplayLarge(text: amount),
                const SizedBox(
                  width: 8,
                ),
                LabelLarge(text: timeUnit),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
