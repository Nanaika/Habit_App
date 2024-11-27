import 'package:flutter/material.dart';

import '../../custom_text_field.dart';

class HoursMinRow extends StatelessWidget {
  const HoursMinRow({
    super.key,
    required this.hourController,
    required this.minController,
  });

  final TextEditingController hourController;
  final TextEditingController minController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: hourController,
            hintText: 'Hours',
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomTextField(
            controller: minController,
            hintText: 'Mins',
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}