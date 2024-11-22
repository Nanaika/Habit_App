import 'package:flutter/cupertino.dart';

import '../theme.dart';

class DisplaySmall extends StatelessWidget {
  const DisplaySmall({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).secondary),
    );
  }
}