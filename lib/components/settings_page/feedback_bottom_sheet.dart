import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme.dart';
import '../close_circle_button.dart';
import '../custom_no_icon_button.dart';
import '../custom_text_field.dart';
import '../display_small.dart';

class FeedBackBottomSheet extends StatefulWidget {
  const FeedBackBottomSheet({
    super.key,
  });

  @override
  State<FeedBackBottomSheet> createState() => _FeedBackBottomSheetState();
}

class _FeedBackBottomSheetState extends State<FeedBackBottomSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16, left: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 8),
      child: SafeArea(
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            SvgPicture.asset('assets/images/line.svg'),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DisplaySmall(text: 'Feedback'),
                CloseCircleButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              maxLength: 100,
              controller: controller,
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
              onTap: () {
                controller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
