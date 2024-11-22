import 'package:flutter/material.dart';

import '../../theme.dart';

class SendFeedBackButton extends StatelessWidget {
  const SendFeedBackButton({
    super.key, this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: green,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            'Send',
            style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).surfaceTint),
          ),
        ),
      ),
    );
  }
}