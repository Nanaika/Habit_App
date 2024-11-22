import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class DatePickerRow extends StatelessWidget {
  const DatePickerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            '07.11.2024',
            style: getTextTheme(context).bodyMedium?.copyWith(color: getColor(context).secondary),
          )
        ],
      ),
    );
  }
}