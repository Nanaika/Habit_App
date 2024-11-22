import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, required this.hintText, this.textAlign = TextAlign.center,
  });

  final String hintText;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
      decoration:
      BoxDecoration(color: getColor(context).onSurface, borderRadius: BorderRadius.circular(defBorderRadius / 2)),
      child: TextField(
        style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}