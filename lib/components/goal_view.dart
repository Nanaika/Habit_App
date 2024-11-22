import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_app/components/custom_button.dart';
import 'package:habit_app/components/custom_no_icon_button.dart';
import 'package:habit_app/theme.dart';

class GoalView extends StatelessWidget {
  const GoalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(defBorderRadius / 2),
      color: getColor(context).surfaceTint,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: TypeNameColumn(),
                ),
                Expanded(
                  flex: 4,
                  child: CompletePercentDurationColumn(),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 6 ? 0 : 3),
                      child: GoalWeekDayTile(
                        text: 'S',
                      ),
                    ),
                  );

              }),
            ),

            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                LabelLarge(text: ' 0 of 7 goals accomplished this week.')
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            CustomNoIconButton(text: 'Execute', onTap: () {},)
          ],
        ),
      ),
    );
  }
}

//TODO
class GoalWeekDayTile extends StatelessWidget {
  const GoalWeekDayTile({
    super.key,
    this.isCompleted = false,
    required this.text,
    this.isCurrentDate = false,
  });

  final bool isCompleted;
  final bool isCurrentDate;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: isCompleted ? red : getColor(context).onSurface,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              strokeAlign: -1,
              color: isCurrentDate ? red : Colors.transparent,
              width: isCurrentDate ? 0.75 : 0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: getTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: isCompleted ? getColor(context).surfaceTint : getColor(context).onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

//TODO
class CompletePercentDurationColumn extends StatelessWidget {
  const CompletePercentDurationColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '10% complete',
          style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            DisplayLarge(
              text: '3',
            ),
            SizedBox(
              width: 4,
            ),
            LabelLarge(
              text: 'Hours',
            ),
            SizedBox(
              width: 4,
            ),
            DisplayLarge(text: '45'),
            SizedBox(
              width: 4,
            ),
            LabelLarge(text: 'Mins'),
          ],
        ),
      ],
    );
  }
}

//TODO
class DisplayLarge extends StatelessWidget {
  const DisplayLarge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).displayLarge?.copyWith(color: getColor(context).secondary),
    );
  }
}

//TODO
class LabelLarge extends StatelessWidget {
  const LabelLarge({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
    );
  }
}

//TODO
class TypeNameColumn extends StatelessWidget {
  const TypeNameColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/images/fitness.svg',
          colorFilter: const ColorFilter.mode(red, BlendMode.srcIn),
        ),
        Text(
          'fitness',
          style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Increase training time',
          overflow: TextOverflow.ellipsis,
          style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        )
      ],
    );
  }
}
