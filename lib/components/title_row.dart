import 'package:flutter/material.dart';

import '../theme.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Text(
            text,
            style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).onPrimary),
          ),
        )
      ],
    );
  }
}