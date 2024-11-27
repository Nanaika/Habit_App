import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/task_bloc.dart';
import 'package:habit_app/theme.dart';

import '../components/dialogs/add_task_dialog.dart';
import '../components/image_row.dart';
import '../components/task_page/add_task_button.dart';
import '../components/task_page/completed_daily_chips_row.dart';
import '../components/task_page/completed_task_container.dart';
import '../components/task_page/empty_task_view.dart';
import '../components/task_page/task_chips_row.dart';
import '../components/task_page/task_tile.dart';
import '../components/title_row.dart';
import '../utils/const.dart';
import '../utils/utils.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  int selectedCompletedDaily = 0;
  int selectedTasks = 0;

  void selectCompletedDailyChip(int index) {
    setState(() {
      selectedCompletedDaily = index;
    });
  }

  void selectTaskChip(int index) {
    setState(() {
      selectedTasks = index;
    });
  }

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
                const TitleRow(
                  text: 'Main',
                ),
                const ImageRow(
                  imagePath: 'assets/images/main.png',
                ),
                CompletedDailyChipsRow(
                  selectedIndex: selectedCompletedDaily,
                  onTap: (index) {
                    selectCompletedDailyChip(index);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<TaskBloc, MyTasks>(builder: (ctx, state) {
                  if (selectedCompletedDaily == 0) {
                    return CompletedItemsContainer(
                      title: 'Work',
                      completedValue: calculateCompletionPercentage(state.completedDailyTasks.workCompletedTasks.length,
                              state.completedDailyTasks.workTasksLength) /
                          100,
                      completedPercent: calculateCompletionPercentage(
                          state.completedDailyTasks.workCompletedTasks.length,
                          state.completedDailyTasks.workTasksLength),
                    );
                  } else if (selectedCompletedDaily == 1) {
                    return CompletedItemsContainer(
                      title: 'Meetings',
                      completedValue: calculateCompletionPercentage(
                              state.completedDailyTasks.meetingsCompletedTasks.length,
                              state.completedDailyTasks.meetingsTasksLength) /
                          100,
                      completedPercent: calculateCompletionPercentage(
                          state.completedDailyTasks.meetingsCompletedTasks.length,
                          state.completedDailyTasks.meetingsTasksLength),
                    );
                  } else {
                    return CompletedItemsContainer(
                      title: 'Home',
                      completedValue: calculateCompletionPercentage(state.completedDailyTasks.homeCompletedTasks.length,
                              state.completedDailyTasks.homeTasksLength) /
                          100,
                      completedPercent: calculateCompletionPercentage(
                          state.completedDailyTasks.homeCompletedTasks.length,
                          state.completedDailyTasks.homeTasksLength),
                    );
                  }
                }),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tasks',
                        style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TasksChipsRow(
                  selectedIndex: selectedTasks,
                  onTap: (index) {
                    selectTaskChip(index);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                selectedTasks == 0
                    ? BlocBuilder<TaskBloc, MyTasks>(builder: (ctx, tasks) {
                        if (tasks.dailyTasks.isEmpty) {
                          return const EmptyView(
                            text: 'You don\'t have any tasks added, add a task and it will appear here.',
                            imagePath: 'assets/images/home.svg',
                          );
                        } else {
                          return Expanded(
                            child: ListView.separated(
                                itemBuilder: (ctx, index) {
                                  return TaskTile(
                                    key: ValueKey(tasks.dailyTasks[index].id),
                                    task: tasks.dailyTasks[index],
                                    onDelete: (id) {
                                      context.read<TaskBloc>().deleteTask(id);
                                    },
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return const SizedBox(
                                    height: 4,
                                  );
                                },
                                itemCount: tasks.dailyTasks.length),
                          );
                        }
                      })
                    : BlocBuilder<TaskBloc, MyTasks>(builder: (ctx, tasks) {
                        if (tasks.weeklyTasks.isEmpty) {
                          return const EmptyView(
                            text: 'You don\'t have any tasks added, add a task and it will appear here.',
                            imagePath: 'assets/images/home.svg',
                          );
                        } else {
                          return Expanded(
                            child: ListView.separated(
                                itemBuilder: (ctx, index) {
                                  return TaskTile(
                                    key: ValueKey(tasks.weeklyTasks[index].id),
                                    task: tasks.weeklyTasks[index],
                                    onDelete: (id) {
                                      context.read<TaskBloc>().deleteTask(id);
                                    },
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return const SizedBox(
                                    height: 4,
                                  );
                                },
                                itemCount: tasks.weeklyTasks.length),
                          );
                        }
                      }),
                const SizedBox(
                  height: 4,
                ),
                AddTaskButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return const AddTaskDialog();
                        });
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
