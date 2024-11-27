import 'package:flutter/material.dart';

import '../theme.dart';

class LabelLarge extends StatelessWidget {
  const LabelLarge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context)
          .labelLarge
          ?.copyWith(color: getColor(context).onPrimary, overflow: TextOverflow.ellipsis),
    );
  }
}