import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/add_goal_type_index_bloc.dart';
import '../../../theme.dart';

class GoalTypeUnitName extends StatelessWidget {
  const GoalTypeUnitName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGoalTypeIndexBloc, int>(
      builder: (BuildContext context, int state) {
        final text = switch (state) {
          0 => 'Duration',
          1 => 'Drink (ml)',
          2 => 'Calories',
          int() => '',
        };
        return Text(
          text,
          style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        );
      },
    );
  }
}
