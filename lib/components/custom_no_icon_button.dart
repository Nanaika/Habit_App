import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/const.dart';

class CustomNoIconButton extends StatelessWidget {
  const CustomNoIconButton({
    super.key,
    this.onTap,
    required this.text, this.color = red,
  });

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
            color: color,
            child: InkWell(
              borderRadius: BorderRadius.circular(defBorderRadius - 12),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
                child: Text(
                  textAlign: TextAlign.center,
                  text,
                  style: getTextTheme(context).bodyLarge?.copyWith(color: getColor(context).surfaceTint),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
