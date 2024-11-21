import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.text, this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(defBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defBorderRadius),
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(defButtonPadding),
          width: MediaQuery.of(context).size.width / 2,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(text, style: getTextTheme(context).bodyLarge?.copyWith(color: Colors.white),),
              Icon(CupertinoIcons.arrow_right, color: Colors.white.withOpacity(0.75),),
            ],
          ),
        ),
      ),
    );
  }
}