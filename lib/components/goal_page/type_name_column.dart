import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/utils/string_extensions.dart';

import '../../domain/models/goal.dart';
import '../../theme.dart';
import '../../utils/const.dart';

class TypeNameColumn extends StatelessWidget {
  const TypeNameColumn({
    super.key,
    required this.type,
    required this.name,
  });

  final GoalType type;
  final String name;

  @override
  Widget build(BuildContext context) {
    final iconPath = switch (type) {
      GoalType.fitness => goalTypeIcons[0],
      GoalType.water => goalTypeIcons[1],
      GoalType.nutrition => goalTypeIcons[2],
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: const ColorFilter.mode(red, BlendMode.srcIn),
        ),
        Text(
          type.name.capitalizeFirst(),
          style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
        ),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        )
      ],
    );
  }
}
