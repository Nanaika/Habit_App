import 'package:flutter/material.dart';

import '../../domain/models/goal.dart';
import '../display_large.dart';
import '../label_large.dart';

class FitnessRow extends StatelessWidget {
  const FitnessRow({
    super.key,
    required this.duration,
  });

  final CustomDuration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        duration.hours != 0
            ? Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: DisplayLarge(
                      text: duration.hours.toString(),
                      overflow: TextOverflow.ellipsis,
                    )))
            : const SizedBox.shrink(),
        const SizedBox(
          width: 4,
        ),
        duration.hours != 0
            ? const LabelLarge(
                text: 'Hours',
              )
            : const SizedBox.shrink(),
        const SizedBox(
          width: 4,
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: DisplayLarge(
                  text: duration.minutes.toString(),
                  overflow: TextOverflow.ellipsis,
                ))),
        const SizedBox(
          width: 4,
        ),
        const LabelLarge(text: 'Mins'),
      ],
    );
  }
}
