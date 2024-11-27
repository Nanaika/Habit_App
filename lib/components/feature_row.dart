import 'package:flutter/material.dart';

import '../theme.dart';

class FeatureRow extends StatelessWidget {
  const FeatureRow({
    super.key,
    required this.imagePath,
    required this.text,
  });

  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 20,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            text,
            style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
