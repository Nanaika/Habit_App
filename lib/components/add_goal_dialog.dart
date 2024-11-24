import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/components/tab_bar_goal_type.dart';

import '../theme.dart';
import 'close_circle_button.dart';
import 'custom_text_field.dart';
import 'custom_no_icon_button.dart';

class AddGoalDialog extends StatelessWidget {
  const AddGoalDialog({
    super.key, this.onTap,
  });
  final void Function()? onTap;
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
                    'Create goal',
                    style: getTextTheme(context).displaySmall?.copyWith(color: getColor(context).secondary),
                  ),
                ),
                const CloseCircleButton(),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const TabBarGoalType(),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: TextEditingController(),
              hintText: 'Name goal',
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Duration',
                      style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: TextEditingController(),
                        hintText: 'Hours',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: TextEditingController(),
                        hintText: 'Mins',
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomNoIconButton(onTap: onTap, text: 'Save', color: getColor(context).primary,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


