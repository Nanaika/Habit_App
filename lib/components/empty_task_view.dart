import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.imagePath,
    required this.text,
  });

  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(imagePath, width: 60, height: 60,),
        FractionallySizedBox(
          widthFactor: 0.75,
          child: Text(
            text,
            style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

// 'assets/images/grey_home.png'
// 'You don\'t have any tasks added, add a task and it will appear here.'
