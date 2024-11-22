import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme.dart';
import '../close_circle_button.dart';
import '../custom_no_icon_button.dart';
import '../custom_text_field.dart';
import '../display_small.dart';

class FeedBackBottomSheet extends StatelessWidget {
  const FeedBackBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: getColor(context).surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            SvgPicture.asset('assets/images/line.svg'),
            const SizedBox(
              height: 16,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisplaySmall(text: 'Feedback'),
                CloseCircleButton(),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hintText: 'Text',
              textAlign: TextAlign.start,
              minLines: 6,
              maxLines: 6,
              showLimit: true,
            ),

            const SizedBox(
              height: 16,
            ),
            CustomNoIconButton(
              text: 'Send',
              color: getColor(context).primary,
            ),
          ],
        ),
      ),
    );
  }
}