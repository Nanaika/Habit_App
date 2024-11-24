import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    this.onTap,
    required this.isChecked,
    this.isCheckedColor = blue,
    this.assetPath,
  });

  final String text;
  final void Function()? onTap;
  final bool isChecked;
  final Color isCheckedColor;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defBorderRadius),
          color: isChecked ? isCheckedColor : getColor(context).surfaceTint,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  assetPath!,
                  colorFilter: ColorFilter.mode(
                      isChecked ? getColor(context).surfaceTint : getColor(context).onPrimary, BlendMode.srcIn),
                ),
              ),
            Text(
              text,
              style: getTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: isChecked ? getColor(context).surfaceTint : getColor(context).onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
