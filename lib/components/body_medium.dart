import 'package:flutter/material.dart';

import '../theme.dart';

class BodyMedium extends StatelessWidget {
  const BodyMedium({
    super.key,
    required this.text,
    this.isStrikethrough = false,
  });

  final bool isStrikethrough;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).bodyMedium?.copyWith(overflow: TextOverflow.ellipsis,
          color: isStrikethrough ? getColor(context).onPrimary : getColor(context).secondary,
          decoration: isStrikethrough ? TextDecoration.lineThrough : null,
          decorationColor: getColor(context).onPrimary),
    );
  }
}
