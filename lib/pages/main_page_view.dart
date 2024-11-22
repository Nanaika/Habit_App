import 'package:flutter/material.dart';
import 'package:habit_app/theme.dart';

import '../components/add_task_button.dart';
import '../components/add_task_dialog.dart';
import '../components/completed_daily_chips_row.dart';
import '../components/completed_task_container.dart';
import '../components/empty_task_view.dart';
import '../components/image_row.dart';
import '../components/task_chips_row.dart';
import '../components/title_row.dart';

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
                const EmptyView(
                  text: 'You don\'t have any tasks added, add a task and it will appear here.',
                  imagePath: 'assets/images/bb_home.svg',
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
