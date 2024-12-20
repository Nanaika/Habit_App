import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit_bloc.dart';
import 'package:habit_app/components/dialogs/add_habit/add_habit_dialog.dart';
import 'package:habit_app/components/dialogs/edit_habit_bottom_sheet/edit_habit_bottom_sheet.dart';
import 'package:habit_app/components/sub_title.dart';
import 'package:habit_app/theme.dart';
import 'package:habit_app/utils/string_extensions.dart';

import '../components/goal_page/create_goal_button.dart';
import '../components/habit_page/habit_check_view.dart';
import '../components/habit_page/habit_view.dart';
import '../components/image_row.dart';
import '../components/task_page/empty_task_view.dart';
import '../components/title_row.dart';
import '../domain/models/habit.dart';
import '../utils/const.dart';
import '../utils/utils.dart';

class HabitPageView extends StatefulWidget {
  const HabitPageView({super.key});

  @override
  State<HabitPageView> createState() => _HabitPageViewState();
}

class _HabitPageViewState extends State<HabitPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(context).surface,
      body: SafeArea(
        top: true,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defPaddingH),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleRow(
                      text: 'Habits',
                    ),
                    AddButton(
                      text: 'Add habit',
                      color: violet,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return const AddHabitDialog();
                            });
                      },
                    )
                  ],
                ),
                const ImageRow(
                  imagePath: 'assets/images/habit.png',
                ),
                const Row(
                  children: [
                    SubTitle(text: 'Habits'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: BlocBuilder<HabitBloc, List<Habit>>(
                    builder: (context, habits) {
                      if (habits.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyView(
                              imagePath: 'assets/images/empty_habit.svg',
                              text:
                                  'You don\'t have any habits added, to add a habit, click on the “Add habbit” button',
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (ctx, index) {
                                  return HabitView(
                                    assetPath: getCategoryAsset(habits[index].category),
                                    habitType: habits[index].type.name.capitalizeFirst(),
                                    habitName: habits[index].name,
                                    habitCategory: habits[index].category.name.capitalizeFirst(),
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          backgroundColor: getColor(context).surface,
                                          context: context,
                                          builder: (ctx) {
                                            return EditHabitBottomSheet(
                                              habit: habits[index],
                                            );
                                          });
                                    },
                                    numOfReps: habits[index].numOfRepetition.toString(),
                                    currentNumOfReps: habits[index].type == HabitType.daily
                                        ? habits[index].daysComplete.length.toString()
                                        : habits[index].weeksComplete.length.toString(),
                                    completedValue: habits[index].type == HabitType.daily
                                        ? calculatePercentage(
                                            habits[index].daysComplete.length, habits[index].numOfRepetition)
                                        : calculatePercentage(
                                            habits[index].weeksComplete.length, habits[index].numOfRepetition),
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return const SizedBox(
                                    width: 6,
                                  );
                                },
                                itemCount: habits.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    SubTitle(text: 'Today habits'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: BlocBuilder<HabitBloc, List<Habit>>(
                    builder: (context, habits) {
                      if (habits.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyView(
                              imagePath: 'assets/images/empty_habit_mark.svg',
                              text: 'Oops, looks like you didn\'t add the habit',
                            ),
                          ],
                        );
                      } else {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return HabitCheckView(
                              habit: habits[index],
                              key: ValueKey(habits[index].id),
                              id: habits[index].id,
                              name: habits[index].name,
                              assetPath: getCategoryAsset(habits[index].category),
                              type: habits[index].type.name.capitalizeFirst(),
                              isComplete: habits[index].type == HabitType.daily
                                  ? isCompletedToday(habits[index].daysComplete)
                                  : isCompletedThisWeek(habits[index].weeksComplete),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemCount: habits.length,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
