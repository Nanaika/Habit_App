import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_app/theme.dart';

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
                const TitleRow(),
                const ImageRow(),
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
                const EmptyTaskView(),
                const SizedBox(
                  height: 4,
                ),
                AddTaskButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AddTaskDialog();
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

//TODO
class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(defPaddingH),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Add task',
                    style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).secondary),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ClipOval(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: getColor(context).onSurface),
                      child: Icon(
                        CupertinoIcons.clear,
                        color: getColor(context).onPrimary,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const TabBarTaskType(),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Date',
                      style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const DatePicker(),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(defBorderRadius - 12),
                        color: getColor(context).primary,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(defBorderRadius - 12),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Save',
                              style: getTextTheme(context).bodyLarge?.copyWith(color: getColor(context).surfaceTint),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//TODO
class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(defBorderRadius / 2), color: getColor(context).onSurface),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/calendar.svg',
          ),
          SizedBox(
            width: defPaddingH,
          ),
          Text(
            '07.11.2024',
            style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
          )
        ],
      ),
    );
  }
}

//TODO
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
      decoration:
          BoxDecoration(color: getColor(context).onSurface, borderRadius: BorderRadius.circular(defBorderRadius / 2)),
      child: TextField(
        style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Task name',
          hintStyle: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).onPrimary),
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

//TODO
class TabBarTaskType extends StatelessWidget {
  const TabBarTaskType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: 34,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: getColor(context).onSurface,
          borderRadius: BorderRadius.circular(defBorderRadius - 14),
        ),
        child: TabBar(
          tabs: [
            Tab(
              child: Text('Work'),
            ),
            Tab(
              child: Text('Meetings'),
            ),
            Tab(
              child: Text('Home'),
            ),
          ],
          labelStyle: getTextTheme(context).labelLarge,
          labelColor: getColor(context).surfaceTint,
          unselectedLabelColor: getColor(context).onPrimary,
          splashFactory: NoSplash.splashFactory,
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: getColor(context).primary,
            borderRadius: BorderRadius.circular(defBorderRadius - 14),
          ),
        ),
      ),
    );
  }
}

//TODO
class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.plus,
                color: blueColor,
              ),
              Text(
                ' Add task',
                style: getTextTheme(context).bodyMedium?.copyWith(color: blueColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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

//TODO
class CompletedTasksContainer extends StatelessWidget {
  const CompletedTasksContainer({
    super.key,
    required this.title,
    required this.completedValue,
    required this.completedPercent,
  });

  final String title;
  final double completedValue;
  final double completedPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defPaddingH),
      decoration: BoxDecoration(
        color: getColor(context).surfaceTint,
        borderRadius: BorderRadius.circular(defBorderRadius / 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          LinearProgressIndicator(
            color: blueColor,
            backgroundColor: getColor(context).onSurface,
            minHeight: 8,
            value: completedValue,
            borderRadius: BorderRadius.circular(defBorderRadius / 2),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Complete daily tasks',
                  style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
                ),
              ),
              Text(
                '${completedPercent.toInt()}%',
                style: getTextTheme(context).labelLarge?.copyWith(color: getColor(context).onPrimary),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//TODO
class CompletedDailyChipsRow extends StatelessWidget {
  const CompletedDailyChipsRow({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final void Function(int index) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          isChecked: selectedIndex == 0 ? true : false,
          text: 'Work',
          onTap: () {
            onTap(0);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        Chip(
          isChecked: selectedIndex == 1 ? true : false,
          text: 'Meetings',
          onTap: () {
            onTap(1);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        Chip(
          isChecked: selectedIndex == 2 ? true : false,
          text: 'Home',
          onTap: () {
            onTap(2);
          },
        ),
      ],
    );
  }
}

//TODO
class TasksChipsRow extends StatelessWidget {
  const TasksChipsRow({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final void Function(int index) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
          isChecked: selectedIndex == 0 ? true : false,
          text: 'Daily',
          onTap: () {
            onTap(0);
          },
        ),
        const SizedBox(
          width: 8,
        ),
        Chip(
          isChecked: selectedIndex == 1 ? true : false,
          text: 'Weekly',
          onTap: () {
            onTap(1);
          },
        ),
      ],
    );
  }
}

//TODO
class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.text,
    this.onTap,
    required this.isChecked,
  });

  final String text;
  final void Function()? onTap;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defBorderRadius),
          color: isChecked ? blueColor : getColor(context).surfaceTint,
        ),
        child: Text(
          text,
          style: getTextTheme(context)
              .bodyMedium
              ?.copyWith(color: isChecked ? getColor(context).surfaceTint : getColor(context).onPrimary),
        ),
      ),
    );
  }
}

//TODO
class ImageRow extends StatelessWidget {
  const ImageRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset('assets/images/home.png')],
    );
  }
}

class TitleRow extends StatelessWidget {
  const TitleRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Text(
            'Main',
            style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).onPrimary),
          ),
        )
      ],
    );
  }
}
