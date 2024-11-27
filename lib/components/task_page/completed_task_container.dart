import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../utils/const.dart';
import '../complete_progress_bar.dart';

class CompletedItemsContainer extends StatelessWidget {
  const CompletedItemsContainer({
    super.key,
    required this.title,
    required this.completedValue,
    required this.completedPercent,
  });

  final String title;
  final double completedValue;
  final double completedPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defPaddingH),
      decoration: BoxDecoration(
        color: getColor(context).surfaceTint,
        borderRadius: BorderRadius.circular(defBorderRadius / 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CompleteProgressBar(completedValue: completedValue),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Complete daily tasks',
                  style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
                ),
              ),
              Text(
                '${completedPercent.toInt()}%',
                style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
