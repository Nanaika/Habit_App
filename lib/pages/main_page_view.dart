import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/task_bloc.dart';
import 'package:habit_app/theme.dart';

import '../components/add_task_button.dart';
import '../components/add_task_dialog.dart';
import '../components/completed_daily_chips_row.dart';
import '../components/completed_task_container.dart';
import '../components/empty_task_view.dart';
import '../components/image_row.dart';
import '../components/task_chips_row.dart';
import '../components/task_tile.dart';
import '../components/title_row.dart';
import '../domain/models/task.dart';

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
                Builder(builder: (context) {
                  if (selectedCompletedDaily == 0) {
                    return const CompletedTasksContainer(
                      title: 'Work',
                      completedValue: 0.33,
                      completedPercent: 33,
                    );
                  } else if (selectedCompletedDaily == 1) {
                    return const CompletedTasksContainer(
                      title: 'Meetings',
                      completedValue: 0,
                      completedPercent: 0,
                    );
                  } else {
                    return const CompletedTasksContainer(
                      title: 'Home',
                      completedValue: 0.90,
                      completedPercent: 90,
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
                BlocBuilder<TaskBloc, List<Task>>(builder: (ctx, tasks) {
                  if (tasks.isEmpty) {
                    return const EmptyView(
                      text: 'You don\'t have any tasks added, add a task and it will appear here.',
                      imagePath: 'assets/images/bb_home.svg',
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                          itemBuilder: (ctx, index) {
                            return TaskTile(
                              key: ValueKey(tasks[index].id),
                              task: tasks[index],
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
                          itemCount: tasks.length),
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
