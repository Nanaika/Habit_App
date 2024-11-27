import 'package:flutter/material.dart';

import '../../theme.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.textColor,
    required this.text,
    this.onTap,
  });

  final String text;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getColor(context).surfaceTint,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: getTextTheme(context).bodyLarge?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
