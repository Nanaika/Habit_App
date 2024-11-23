import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../domain/models/task.dart';
import '../theme.dart';
import '../utils/utils.dart';
import 'body_medium.dart';
import 'goal_view.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onDelete,
  });

  final Task task;
  final void Function(int id) onDelete;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.isComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide(color: getColor(context).onPrimary, width: 2),
            activeColor: blue,
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (check) {

              final taskDate = widget.task.date;
              final currentDate = DateTime.now();

              if (taskDate.year != currentDate.year ||
                  taskDate.month != currentDate.month ||
                  taskDate.day != currentDate.day) {
                return;
              }

              setState(() {
                isChecked = !isChecked;
              });

              context.read<TaskBloc>().updateTaskComplete(widget.task.id, isChecked);
            }),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BodyMedium(
                        text: widget.task.name,
                        isStrikethrough: isChecked,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    LabelLarge(
                      text: formatDate(widget.task.date),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: getColor(context).onSurface,
                ),
              ),
            ],
          ),
        ),
        if (isChecked)
          GestureDetector(
            onTap: () {
              widget.onDelete(widget.task.id);
            },
            child: Container(
              color: Colors.transparent,
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  CupertinoIcons.clear,
                  color: red,
                  size: 15,
                ),
              ),
            ),
          ),
      ],
    );
  }
}