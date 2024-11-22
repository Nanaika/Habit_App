import 'package:flutter/cupertino.dart';

import '../theme.dart';

class CloseCircleButton extends StatelessWidget {
  const CloseCircleButton({
    super.key, this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: getColor(context).onSurface),
          child: Icon(
            CupertinoIcons.clear,
            color: getColor(context).onPrimary,
            size: 16,
          ),
        ),
      ),
    );
  }
}