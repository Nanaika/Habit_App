import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/components/goal_view.dart';
import 'package:habit_app/pages/privacy_policy_page.dart';
import 'package:habit_app/theme.dart';

import '../components/image_row.dart';
import '../components/settings_page/feedback_bottom_sheet.dart';
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
                          return const FeedBackBottomSheet();
                        });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SettingsBlock(
                        imagePath: 'assets/images/privacy_policy.svg',
                        text: 'Privacy Policy',
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
                            return const PrivacyPolicyPage(
                              title: 'Privacy Policy',
                              text: privacyPolicy,
                            );
                          }));
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SettingsBlock(
                        imagePath: 'assets/images/terms_of_use.svg',
                        text: 'Terms of Use',
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
                            return const PrivacyPolicyPage(
                              title: 'Terms of Use',
                              text: termOfUse,
                            );
                          }));
                        },
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
