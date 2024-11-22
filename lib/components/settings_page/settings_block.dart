import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme.dart';
import '../body_medium.dart';

class SettingsBlock extends StatelessWidget {
  const SettingsBlock({
    super.key,
    required this.text,
    required this.imagePath, this.onTap,
  });

  final String text;
  final String imagePath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: getColor(context).surfaceTint,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
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
      ),
    );
  }
}