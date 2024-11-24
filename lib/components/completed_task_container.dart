import 'package:flutter/material.dart';

import '../theme.dart';

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

class CompleteProgressBar extends StatelessWidget {
  const CompleteProgressBar({
    super.key,
    required this.completedValue, this.color = blue, this.borderRadius = 16.0, this.minHeight = 8,
  });

  final double completedValue;
  final Color color;
  final double borderRadius;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: color,
      backgroundColor: getColor(context).onSurface,
      minHeight: minHeight,
      value: completedValue,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }
}