import 'package:flutter/material.dart';
import 'package:habit_app/components/body_medium.dart';
import 'package:habit_app/components/goal_view.dart';
import 'package:habit_app/theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key, required this.title, required this.text});
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(context).surface,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: getColor(context).primary),
        centerTitle: true,
        title: BodyMedium(text: title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: LabelLarge(text: text),
      ),
    );
  }
}
