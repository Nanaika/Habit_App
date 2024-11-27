import 'package:flutter/material.dart';

import '../../../domain/models/goal.dart';
import '../../../theme.dart';
import '../../display_large.dart';
import '../../label_large.dart';

class StatisticDurationBlock extends StatelessWidget {
  const StatisticDurationBlock({
    super.key,
    required this.title,
    this.isCentre = false,
    required this.duration,
  });

  final String title;
  final CustomDuration duration;
  final bool isCentre;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: isCentre ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            LabelLarge(text: title),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: isCentre ? MainAxisAlignment.center : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                duration.hours != 0 ? DisplayLarge(text: duration.hours.toString()) : const SizedBox.shrink(),
                const SizedBox(
                  width: 8,
                ),
                duration.hours != 0 ? const LabelLarge(text: 'hours') : const SizedBox.shrink(),
                const SizedBox(
                  width: 12,
                ),
                DisplayLarge(text: duration.minutes.toString()),
                const SizedBox(
                  width: 8,
                ),
                const LabelLarge(text: 'mins'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
