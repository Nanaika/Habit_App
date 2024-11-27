import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../utils/const.dart';

class GoalExecuteButton extends StatelessWidget {
  const GoalExecuteButton({
    super.key,
    this.onTap,
    required this.text,
    this.color = red,
    required this.isActive,
  });

  final bool isActive;
  final void Function()? onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            borderRadius: BorderRadius.circular(defBorderRadius - 12),
            color: isActive ? color : getColor(context).surface,
            child: InkWell(
              borderRadius: BorderRadius.circular(defBorderRadius - 12),
              onTap: isActive ? onTap : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
                child: Text(
                  textAlign: TextAlign.center,
                  isActive ? text : 'Today\'s goal is accomplished',
                  style: getTextTheme(context)
                      .bodyLarge
                      ?.copyWith(color: isActive ? getColor(context).surfaceTint : getColor(context).onPrimary),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
