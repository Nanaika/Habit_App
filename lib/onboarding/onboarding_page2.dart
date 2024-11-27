import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_app/theme.dart';

import '../components/custom_button.dart';
import '../components/feature_row.dart';
import 'onboarding_page3.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
                    child: Image.asset('assets/images/star.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Feature overview',
                    style: getTextTheme(context).displayLarge?.copyWith(color: getColor(context).secondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const FeatureRow(
                    imagePath: 'assets/images/checkbox.png',
                    text: 'Task scheduling',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const FeatureRow(
                    imagePath: 'assets/images/heart.png',
                    text: ' Health tracker',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const FeatureRow(
                    imagePath: 'assets/images/dictionary.png',
                    text: 'Habit tracking',
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                child: SafeArea(
                  bottom: true,
                  child: CustomButton(
                    text: 'Next',
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
                        return const OnboardingPage3();
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
