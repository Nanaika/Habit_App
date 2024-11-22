import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
      decoration:
      BoxDecoration(color: getColor(context).onSurface, borderRadius: BorderRadius.circular(defBorderRadius / 2)),
      child: TextField(
        style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Task name',
          hintStyle: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}