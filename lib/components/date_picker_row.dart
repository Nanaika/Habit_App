import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/utils/utils.dart';

import '../theme.dart';

class DatePickerRow extends StatefulWidget {
  const DatePickerRow({
    super.key,
    required this.onDateChanged,
  });

  final void Function(DateTime) onDateChanged;

  @override
  State<DatePickerRow> createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {

  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return CupertinoDatePicker(
                initialDateTime: date,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime) {
                  widget.onDateChanged(dateTime);
                  setState(() {
                    date = dateTime;
                  });
                },
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defPaddingH, vertical: defPaddingH - 4),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(defBorderRadius / 2), color: getColor(context).onSurface),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/calendar.svg',
            ),
            const SizedBox(
              width: defPaddingH,
            ),
            Text(
              formatDate(date),
              style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
            )
          ],
        ),
      ),
    );
  }
}
