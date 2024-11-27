import 'package:flutter/material.dart';

import '../theme.dart';

class DisplayLarge extends StatelessWidget {
  const DisplayLarge({
    super.key,
    required this.text, this.overflow,
  });

  final String text;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).displayLarge?.copyWith(color: getColor(context).secondary, overflow: overflow),
    );
  }
}