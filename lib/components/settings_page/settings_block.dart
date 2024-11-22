import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme.dart';
import '../body_medium.dart';

class SettingsBlock extends StatelessWidget {
  const SettingsBlock({
    super.key,
    required this.text,
    required this.imagePath,
  });

  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: getColor(context).surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(
              height: 8,
            ),
            BodyMedium(
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}