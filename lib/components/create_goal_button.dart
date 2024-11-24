import 'package:flutter/material.dart';

import '../theme.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    this.onTap, required this.text, this.color = red,
  });

  final void Function()? onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(defBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defBorderRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            text,
            style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).surfaceTint),
          ),
        ),
      ),
    );
  }
}