import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/const.dart';

class CompleteProgressBar extends StatelessWidget {
  const CompleteProgressBar({
    super.key,
    required this.completedValue,
    this.color = blue,
    this.borderRadius = 16.0,
    this.minHeight = 8,
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