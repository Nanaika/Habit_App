import 'package:flutter/material.dart';

import '../theme.dart';
import '../utils/const.dart';
import 'label_large.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.textAlign = TextAlign.center,
    this.minLines = 1,
    this.maxLines = 1,
    this.showLimit = false,
    required this.controller,
  });

  final String hintText;
  final TextAlign textAlign;
  final int minLines;
  final int maxLines;
  final bool showLimit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
      decoration:
          BoxDecoration(color: getColor(context).onSurface, borderRadius: BorderRadius.circular(defBorderRadius / 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
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
          if (showLimit) const LabelLarge(text: '0/100'),
        ],
      ),
    );
  }
}
