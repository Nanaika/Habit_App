import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_app/components/settings_page/send_feedback_button.dart';

import '../../theme.dart';
import '../display_small.dart';
import '../goal_view.dart';

class FeedBackSection extends StatelessWidget {
  const FeedBackSection({
    super.key, this.onTap,
  });
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: getColor(context).surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/feedback.svg'),
                  const SizedBox(
                    height: 8,
                  ),
                  const DisplaySmall(
                    text: 'Feedback',
                  ),
                  const LabelLarge(text: 'Send feedback, suggestions, or bug reports.'),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                SendFeedBackButton(onTap: onTap,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}