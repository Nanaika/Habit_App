import 'package:flutter/cupertino.dart';

import '../theme.dart';

class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.text,
    this.onTap,
    required this.isChecked,
  });

  final String text;
  final void Function()? onTap;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defBorderRadius),
          color: isChecked ? blue : getColor(context).surfaceTint,
        ),
        child: Text(
          text,
          style: getTextTheme(context)
              .bodyMedium
              ?.copyWith(color: isChecked ? getColor(context).surfaceTint : getColor(context).onPrimary),
        ),
      ),
    );
  }
}