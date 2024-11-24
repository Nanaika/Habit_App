import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/components/body_medium.dart';
import 'package:habit_app/components/tab_bar_task_type.dart';

import '../bloc/task_bloc.dart';
import '../domain/models/task.dart';
import '../theme.dart';
import 'custom_text_field.dart';
import 'date_picker_row.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    super.key,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  late final TabController tabController;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    date = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(defPaddingH),
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
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
            TabBarTaskType(
              controller: tabController,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: nameController,
              hintText: 'Task name',
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    BodyMedium(text: 'Date')
                    // Text(
                    //   'Date',
                    //   style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DatePickerRow(
                  onDateChanged: (dateTime) {
                    date = dateTime;
                  },
                ),
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
                          onTap: () {
                            saveTask(context);
                            Navigator.of(context).pop();
                          },
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

  void saveTask(BuildContext context) {
    final task = Task(
        type: TaskType.values[tabController.index],
        name: nameController.text,
        date: date,
        dateCreated: DateTime.now());
    context.read<TaskBloc>().saveTask(task);
  }
}
