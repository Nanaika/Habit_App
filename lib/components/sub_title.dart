import 'package:flutter/cupertino.dart';

import '../theme.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
    );
  }
}