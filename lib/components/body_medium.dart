import 'package:flutter/material.dart';

import '../theme.dart';

class BodyMedium extends StatelessWidget {
  const BodyMedium({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
    );
  }
}