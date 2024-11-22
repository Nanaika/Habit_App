import 'package:flutter/material.dart';

import '../theme.dart';

class CreateGoalButton extends StatelessWidget {
  const CreateGoalButton({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: red,
      borderRadius: BorderRadius.circular(defBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defBorderRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            'Create goal',
            style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).surfaceTint),
          ),
        ),
      ),
    );
  }
}