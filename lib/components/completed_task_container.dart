import 'package:flutter/material.dart';

import '../theme.dart';

class CompletedTasksContainer extends StatelessWidget {
  const CompletedTasksContainer({
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
          LinearProgressIndicator(
            color: blue,
            backgroundColor: getColor(context).onSurface,
            minHeight: 8,
            value: completedValue,
            borderRadius: BorderRadius.circular(defBorderRadius / 2),
          ),
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