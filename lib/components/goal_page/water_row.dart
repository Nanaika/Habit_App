import 'package:flutter/material.dart';

import '../display_large.dart';
import '../label_large.dart';

class WaterRow extends StatelessWidget {
  const WaterRow({
    super.key,
    required this.ml,
  });

  final int ml;

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
                  text: ml.toString(),
                  overflow: TextOverflow.ellipsis,
                ))),
        const SizedBox(
          width: 4,
        ),
        const LabelLarge(text: 'ml'),
      ],
    );
  }
}
