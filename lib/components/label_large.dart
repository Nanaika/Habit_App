import 'package:flutter/material.dart';

import '../theme.dart';

class LabelLarge extends StatelessWidget {
  const LabelLarge({
    super.key,
    required this.text, this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context)
          .labelLarge
          ?.copyWith(color: getColor(context).onPrimary, overflow: overflow),
    );
  }
}