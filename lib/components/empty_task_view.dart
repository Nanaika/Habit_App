import 'package:flutter/cupertino.dart';

import '../theme.dart';

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/grey_home.png'),
        FractionallySizedBox(
          widthFactor: 0.75,
          child: Text(
            'You don\'t have any tasks added, add a task and it will appear here.',
            style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}