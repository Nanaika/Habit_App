import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../utils/const.dart';

class HabitCheckViewButton extends StatelessWidget {
  const HabitCheckViewButton({
    super.key,
    this.onTap,
    this.isComplete = false,
  });

  final bool isComplete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: isComplete ? violet : getColor(context).surface),
          child: Icon(
            isComplete ? Icons.check : CupertinoIcons.add,
            color: isComplete ? getColor(context).surfaceTint : getColor(context).onPrimary,
          ),
        ),
      ),
    );
  }
}
