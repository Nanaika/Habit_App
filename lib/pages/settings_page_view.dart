import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_app/components/close_circle_button.dart';
import 'package:habit_app/components/custom_no_icon_button.dart';
import 'package:habit_app/components/custom_text_field.dart';
import 'package:habit_app/components/display_small.dart';
import 'package:habit_app/components/goal_view.dart';
import 'package:habit_app/theme.dart';

import '../components/image_row.dart';
import '../components/settings_page/feedback_section.dart';
import '../components/settings_page/settings_block.dart';
import '../components/title_row.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(context).surface,
      body: SafeArea(
        top: true,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defPaddingH),
            child: Column(
              children: [
                const TitleRow(
                  text: 'Settings',
                ),
                const ImageRow(
                  imagePath: 'assets/images/settings.png',
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  children: [
                    LabelLarge(text: 'Application settings'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                FeedBackSection(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: getColor(context).surface,
                        context: context,
                        builder: (ctx) {
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DisplaySmall(text: 'Feedback'),
                                      CloseCircleButton(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextField(hintText: 'Text', textAlign: TextAlign.start,),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomNoIconButton(text: 'Send', color: getColor(context).primary,),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: SettingsBlock(
                        imagePath: 'assets/images/privacy_policy.svg',
                        text: 'Privacy Policy',
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SettingsBlock(
                        imagePath: 'assets/images/terms_of_use.svg',
                        text: 'Terms of Use',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
