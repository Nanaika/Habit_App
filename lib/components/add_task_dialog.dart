import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/components/tab_bar_task_type.dart';

import '../theme.dart';
import 'custom_text_field.dart';
import 'date_picker_row.dart';

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
                const DatePickerRow(),
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